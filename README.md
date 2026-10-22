# kashmeister/tap

Homebrew formulae by kashmeister.

## MacTouch

[MacTouch](https://github.com/kashmeister/mactouch) is a touchscreen driver for macOS: a menu bar app
that makes USB touch screen monitors work on a Mac, with tap, drag, right click, scrolling with
momentum, pinch to zoom, swipes and calibration.

```sh
brew install kashmeister/tap/mactouch
brew services start mactouch
```

Then enable MacTouch in System Settings › Privacy & Security under Input Monitoring and
Accessibility. The formula builds MacTouch from source with the Xcode Command Line Tools, so macOS
shows no warning about an unidentified developer.
