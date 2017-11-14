<h2>UXKit
<img src="http://zeezide.com/img/UXKitIcon1024.png"
  align="right" width="128" height="128" />
</h2>

There is a rumor that something called *UXKit* exists as part of the Apple Photos
application,
enabling the same codebase to run on macOS and iOS.
While I think the
[article](https://medium.com/@guilhermerambo/why-uikit-for-macos-is-important-ff4e74a82cf0)
is quite incorrect:

> UIKit for macOS already exists, and it is called UXKit
> I heard about UXKit when Apple first introduced the new Photos app for macOS.

At [ZeeZide](http://www.zeezide.de/) we are using something along the lines to build
all applications for both, macOS and iOS.
One demo of that are the
[CodeCows](http://zeezide.com/en/products/codecows/index.html)
and
[ASCII Cows](http://zeezide.com/en/products/asciicows/index.html)
applications, which share about 90% of the code, while offering unique system features
on both platforms (e.g. Stickers on iOS and System Services on macOS).

This is not only useful for actual deployment to macOS, but also during development,
as it saves you a lot of the simulator or device testing hassle if you develop for macOS first.

## ZeeZide UXKit

The Apple acquired UXKit is not an official API, and there are good reasons for this.
UXKit is more of a hack to get stuff running than a beautiful framework abstracting
UIKit and AppKit away.

This codebase while not small, has very little 'actual' code.
Most stuff is just typealiases, constant aliases, etc.

The idea of this is NOT to provide a full cross platform abstraction.
It is expected that a lot of apps will still carry `#if os(macOS)` like code to enable/disable
specific features.

WORK IN PROGRESS: Still cleaning up the stuff.

## How to do write Cross-Platform Code using UXKit

### View Aliases

TODO

### Target/Action

TODO
- single target/action
- gestures

### Table Views

TODO
- sectioned list view vs table view vs outline view
- source lists

### Collection Views

TODO
- VC vs View factory

### Layer based views

TODO

### View Controllers

TODO

### Who

**UXKit** is brought to you by
[ZeeZide](http://zeezide.de).
We like feedback, GitHub stars, cool contract work,
presumably any form of praise you can think of.

