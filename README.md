# Unifi Checker
Check stock on unifi products online since the stock notifications don't seem to work correctly.

# ⚠️ 🔴 ‼️ [WARNING] Please do not share your unifi_cookies.yml or your checker.yml file with anyone since they contain private login information and can be used to log into your unifi account ⚠️ 🔴 ‼️
## Disclaimer: This will break at some point when ubiquiti changes layout for their website or product pages.

### Installing pre-requisites
1. Install ruby (3.1 or higher) for your platform: https://www.ruby-lang.org/en/documentation/installation/
2. Install bundler gem: ```gem install bundler```

## How to use this script:

1. Clone this repo locally and install dependencies: 
```
  gh repo clone rishabg/unifi_checker
  cd unifi_checker
  bundle install
```

2. Create checker.yml file in YAML format (preferably from the included example file):
      * ```cp checker_example.yml checker.yml```
      * Using your preferred text editor, edit checker.yml 
        - add the missing information (username, password, product urls that you are interested in)





3. Run the script: ```ruby scraper.rb```

Expected output is a list of In-stock and out-of-stock items eg:

```
---
Sold Out:
- https://store.ui.com/collections/unifi-network-wireless/products/unifi-ap6-professional
- https://store.ui.com/collections/unifi-network-wireless/products/unifi-ap-6-lite
- https://store.ui.com/collections/unifi-network-wireless/products/access-point-wifi-6-in-wall
- https://store.ui.com/collections/unifi-network-wireless/products/access-point-wifi-6-enterprise-ea
- https://store.ui.com/collections/unifi-network-unifi-os-consoles/products/dream-wall-ea
- https://store.ui.com/collections/unifi-network-unifi-os-consoles/products/dream-machine-se
- https://store.ui.com/collections/unifi-network-unifi-os-consoles/products/udm-pro
- https://store.ui.com/collections/early-access/products/camera-ai-bullet-ea
- https://store.ui.com/collections/unifi-protect/products/g4-doorbell-pro
- https://store.ui.com/collections/unifi-protect/products/unifi-protect-ai-360
In-Stock:
- https://store.ui.com/collections/unifi-network-wireless/products/unifi-6-long-range-access-point
```

### Warnings and Potential gotchas
- This uses watir to launch a test chrome browser. This can be difficult to install on some platforms. While the browser automation is running, it is best to avoid interacting with the launched browser until it shuts down after logging-in.
- Chrome is only launched conditionally (once in two days or if the ```unifi_cookies.yml``` is not found on local dir). 
- This bears repeating: **Please do not share your unifi_cookies.yml or your checker.yml file with anyone since they contain private login information and can be used to log into your unifi account**
- If the login didn't work, the script will not be able to check stock for Early Access products.


### MIT Licensed: https://github.com/rishabg/unifi_checker/blob/main/LICENSE)
