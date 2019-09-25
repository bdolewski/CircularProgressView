# CircularProgressView
Circular and animated progress bar for iOS

## Available properties

##### lineWidth
Size of the bar (stroke width) - default value is `CGFloat(12.0)`

##### text
Text to be displayed in the middle - default value is `nil`

##### attributedText
Attributed text to be displayed in the middle - default value is `nil`

##### textColor
Color for text inside progress bar when no `attributedText` is used - default value is `UIColor.darkGray`

##### textSize
Font size for text inside progress bar - default value is `CGFloat(16.0)`

##### backgroundBarColor
Color for background (base) track - default value is `UIColor.systemGray`

##### foregroundBarColor
Color for foreground (main) track - default value is `UIColor.systemBlue`

##### maximumBarColor
Color for the foreground (main) track when it reaches the maximum value (full circle) - default value is `UIColor.systemRed`

##### animationDuration
Duration of the "filling" animation - default value is `TimeInterval(1.0)`

## Available functions

##### setProgress(to:animated:)
```swift
    /// Set the visual impression of progress on this UIView
    ///
    /// - Parameters:
    ///   - progress: normalized value from range [0,1] however upper bound will be clamped
    ///   - animated: Switch animations on/off
    public func setProgress(to progress: Double, animated: Bool)
```
