# TFLog

[![Swift Version][swift-image]][swift-url]
[![Build Status][travis-image]][travis-url]
[![License][license-image]][license-url]
[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)
<!-- [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com) -->

A protocol based Swift logging utility, currently supporting OSLog and Console.

<!-- ![](header.png) -->

## Features

- [x] Customizable log prefixes (unicode)
- [x] Main logging runs in background thread
- [x] Swappable log providers by conforming to protocol
- [x] Default support for OSLog and Console
- [x] Out of the box usage by conforming your type to protocol 'Logging'

## Requirements

- iOS 12.0+
- Xcode 11.3+
- Swift 5+

## Installation

#### Manually
Download and drop ```TFLog/Source``` in your project.

To get the full benefits, import `TFLog` whenever you want to log something and make your classes/structs conform
to protocol 'Logging'.

``` swift
import TFLog
```

#### CocoaPods
Not yet supported.


#### Carthage
Not yet supported.

## Usage example

```swift
import TFLog

// Simple usage
struct Drummer: Logging {

logger.log("Take care", data: anyData, lev: .warning)
logger.log("of your snare.")
logger.log("Too late.", lev: .error)

logger.verticalDivider()

logger.log(data: anyData)
}
```


<!-- ## Contribute -->

<!-- We would love you for the contribution to **TFLog**, check the ``LICENSE`` file for more info. -->

### Creator

Tammo Fornalik

### Licence

Distributed under the MIT license. See ``LICENSE`` for more information.

[https://github.com/dbyte](https://github.com/dbyte/)

[swift-image]:https://img.shields.io/badge/swift-5.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
[travis-image]: https://travis-ci.com/dbyte/TFLog.svg?branch=master
[travis-url]: https://travis-ci.com/dbyte/TFLog
