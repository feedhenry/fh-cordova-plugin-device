fh-cordova-plugin-device
========================

## Run tests
1. Use your existing cordova app, or create a new one.
1. Add the plugin and the tests:

  ```bash
  cordova plugin add https://github.com/feedhenry/fh-cordova-plugin-device.git
  cordova plugin add https://github.com/feedhenry/fh-cordova-plugin-device.git#:/tests
  ```

1. Add this plugin:
  ```bash
  cordova plugin add http://git-wip-us.apache.org/repos/asf/cordova-plugin-test-framework.git
  ```
  
1. Change the start page in `config.xml` with `<content src="cdvtests/index.html" />` or navigate to cdvtests/index.html from within your app.