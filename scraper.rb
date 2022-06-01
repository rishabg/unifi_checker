require 'mechanize'
require 'yaml'
require 'pry'
require 'watir'
require 'date'

checker_settings = YAML.load_file('checker.yml') rescue nil
abort('checker.yml file not found') if checker_settings.nil?
unifi_username = checker_settings['credentials']['username']
unifi_password = checker_settings['credentials']['password']
product_urls = checker_settings['product_urls']

STORE_URL = 'https://store.ui.com'
COOKIES_FILE = 'unifi_cookies.yml'

found_cookies_file = File.exist?(COOKIES_FILE)
if found_cookies_file
  age_of_cookies_file = (Date.today - File.mtime(COOKIES_FILE).to_date).to_i
  stale_cookies_file = age_of_cookies_file > 1 ? true : false
else
  stale_cookies_file = false
end

if !found_cookies_file || stale_cookies_file
  browser = Watir::Browser.new :chrome
  browser.goto STORE_URL
  browser.link(id: 'headerLoginLink').click
  File.delete(COOKIES_FILE) if stale_cookies_file
  browser.text_field(name: 'username').set unifi_username
  browser.text_field(name: 'password').set unifi_password
  browser.button(type: 'submit').click
  browser.goto 'https://store.ui.com/collections/unifi-network-unifi-os-consoles/products/dream-wall-ea' # for some redirect weirdness that the site has
  browser.link(id: 'headerLoginLink').click

  File.open(COOKIES_FILE, 'w') { |file| file.write(browser.cookies.to_a.to_yaml) }
  browser.close
end

cookies_array = YAML.load_file(COOKIES_FILE, permitted_classes: [::Symbol, ::Time])

agent = Mechanize.new
cookies_array.each do |c|
  cookie = Mechanize::Cookie.new(c)
  agent.cookie_jar << cookie
end

availability = Hash.new
product_urls.each do |url|
  page = agent.get url
  stock_label = page.at('.comProduct__title--wrapper .comProductTile__inStock, .comProduct__title--wrapper .comProductTile__soldOut')&.text
  availability[stock_label] ||= []
  availability[stock_label] << url
end

puts availability.to_yaml
