# ReportPortalAgent


[![Version](https://img.shields.io/cocoapods/v/ReportPortalAgent.svg?style=flat)](http://cocoapods.org/pods/ReportPortalAgent)
[![License](https://img.shields.io/cocoapods/l/ReportPortalAgent.svg?style=flat)](http://cocoapods.org/pods/ReportPortalAgent)
[![Platform](https://img.shields.io/cocoapods/p/ReportPortalAgent.svg?style=flat)](http://cocoapods.org/pods/ReportPortalAgent)

## Installation

ReportPortalAgent is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ReportPortalAgent'
```
and install it:
```bash
cd <project>
pod install
```

## Report Portal properties

Use info.plist file of your test target to specify properties of Report Portal:

* ReportPortalURL - URL to API of report portal (exaple https://report-portal.company.com/api/v1).
* ReportPortalToken - token for authentication which can be get from RP account settings.
* ReportPortalLaunchName - name of launch.
* Principal class - use ReportPortalAgent.RPListener from ReportPortalAgent lib. Also you can specify your own Observer which should conform [XCTestObservation](https://developer.apple.com/documentation/xctest/xctestobservation) protocol.
* PushTestDataToReportPortal - can be used for switch off/on reporting
* ReportPortalProjectName - project name from Report Portal
* ReportPortalTags(optinal) - can be used to specify tags, separeted by comma.
* IsFinalTestBundle - use to mark last test target as YES, and all others as NO to allow single launch for them

Example:
![Alt text](https://github.com/Windmill-Smart-Solutions/ReportPortalAgent/blob/master/Screen%20Shot.png)

## Authors

DarthRumata, stas.kirichok@windmill.ch (Windmill Smart Solutions)
SergeVKom, sergvkom@gmail.com

## License

ReportPortalAgent is available under the MIT license. See the LICENSE file for more info.
