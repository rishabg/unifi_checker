# Unifi Checker
Check stock on unifi products online since the stock notifications don't seem to work correctly.

## Disclaimer: This will break at some point when ubiquity changes layout for their website or product pages.

## How to use

1. Clone this repo locally: ```gh repo clone rishabg/unifi_checker```
2. CD into repo folder: ```cd unifi_chcker```
3. Install ruby (tested against ruby 3.1.0 on an M1 pro Macbook)
4. Install bundler: ```gem install bundler```
5. Install bundled gems: ```bundle install```
6. Run the script: ```ruby scraper.rb```

Expected output is a list of In-stock and out-of-stock items.

### Potential gotchas
- This uses watir to launch a test chrome browser. This can be difficult to install on some platforms.
- Chrome is launched conditionally (once a day or if the ```cookies.yml``` is not found on local dir)
- If the login didn't work, the script will not be able to check stock for Early Access products.
