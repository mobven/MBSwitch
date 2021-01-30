# MBSwitch

MBSwitch is highly customizable switch that inherited from UIControl.

[![SwiftPM compatible](https://img.shields.io/badge/SwiftPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)

## Requirements
* iOS 10.0+
* Xcode 11+
* Swift 5.2+

## Installation
MBSwitch is distributed with [Swift Package Manager](https://swift.org/package-manager/) which is the only official distribution tool by Apple. You can add MBSwitch to your project from Xcode's `File > Swift Packages > Add Package Dependency` menu with its github URL:
```
https://github.com/mobven/MBSwitch.git
```
## Usage

MBSwitch can be initialized and used either from storyboard or programmatically. Value changes of MBSwitch can be observed via `addTarget(self, action: #selector(func), for: .valueChanged)` function.

```swift
mbSwitch.addTarget(self, action: #selector(self.onSwitchChanged), for: .valueChanged)

@objc func onSwitchChanged() {
    print(mbSwitch.isOn)
}
```
### Setting MBSwitch's State

MBSwitch's state can be changed via `setOn(_ on: Bool)` function. The boolean `on` parameter sets switch's state. Through `setOn(_ on: Bool)` function `sendActions(for: .valueChanged)` will be fired. In some case we don't want to fire `sendActions(for: .valueChanged)` so we can change the state of MBSwitch with `isOn` property without sending action. 

### Supported Attributes

MBSwitch contains two different layers: thumbLayer and trackLayer. You can customize this layers via below attributes:

- trackOnTintColor (UIColor)     ->  Background color of trackLayer when the switch state is on
- trackOffTintColor (UIColor)    ->  Background color of trackLayer when the switch state is off
- trackOnBorderWidth (CGFloat)   ->  Border width of trackLayer when the switch state is on
- trackOffBorderWidth (CGFloat)  ->  Border width of trackLayer when the switch state is off
- trackBorderColor (UIColor)     ->  Border color of trackLayer
- trackVerticalPadding (CGFloat) ->  Vertical padding of trackLayer
- trackCornerRadius (CGFloat)    ->  Corner radius of trackLayer. trackLayer has corner defaultly.
- thumbCornerRadius (CGFloat)    ->  Corner radius of thumbLayer. thumbLayer is round defaultly.
- thumbRadiusPadding (CGFloat)   ->  Padding of thumbLayer
- thumbTintColor (UIColor)       ->  Background color of thumbLayer

### Gradient Support

MBSwitch supports gradient for trackLayer and thumbLayer. You can add gradients via `applyGradient(to layer: MBSwitch.Layer, colors: [UIColor], direction: GradientDirection = .leftToRight)` method. You can set gradient direction, gradient colors and layer that will apply.

### Programmatically Initialize

- Create a MBSwitch instance and add as a subview.

```swift
   let mbSwitch: MBSwitch = MBSwitch(with: CGRect(x: 0, y: 0, width: 70, height: 32))
   or 
   let mbSwitch: MBSwitch = MBSwitch() -> defaultly set. (width: 50, height: 26)
```

### Storyboard Initialization

- Create a UIView in storyboard.
- Select view and set custom class in the identity inspector to `MBSwitch`.
- Can set @IBInspactable params in attribute inspector.
- Create an outlet and set attributes for MBSwitch instance.

---
Developed with 🖤 at [Mobven](https://mobven.com/)
