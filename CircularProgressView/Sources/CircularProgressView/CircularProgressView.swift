//
//  CircularProgressView.swift
//  CircularProgressView
//
//  Created by Bartosz Dolewski on 23/04/2019.
//  Copyright © 2019 Bartosz Dolewski. All rights reserved.

import UIKit

@IBDesignable
public final class CircularProgressView: UIView {
    /// Size of the bar (stroke width)
    @IBInspectable public var lineWidth: CGFloat = 12.0 {
        didSet {
            foregroundLayer.lineWidth = lineWidth
            backgroundLayer.lineWidth = lineWidth
        }
    }
    
    /// Text to be displayed in the middle
    @IBInspectable public var text: String? {
        didSet {
            label.text = text
        }
    }
    
    /// Attributed text to be displayed inside of progress bar
    @IBInspectable public var attributedText: NSAttributedString? {
        didSet {
            label.attributedText = attributedText
        }
    }
    
    /// Color for backgorund/base bar
    @IBInspectable public var backgroundBarColor = UIColor.systemGray
    
    /// Color for foreground/main bar
    @IBInspectable public var foregroundBarColor = UIColor.systemBlue
    
    /// Color for maximum value (100%) of the bar
    @IBInspectable public var maximumBarColor = UIColor.systemRed
    
    /// Duration of the "filling" animation
    @IBInspectable public var animationDuration = TimeInterval(1.0)
    
    /// Color for text inside progress bar
    @IBInspectable public var textColor = UIColor.darkGray
    
    /// Font size for text inside progress bar
    @IBInspectable public var textSize = CGFloat(16.0)
    
    private var label = UILabel()
    private let foregroundLayer = CAShapeLayer()
    private let backgroundLayer = CAShapeLayer()
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
        
        setupBars()
        setupPercentageLabel()
    }
    
    /// Set the visual impression of progress on this UIView
    ///
    /// - Parameters:
    ///   - progress: normalized value from range [0,1] however upper bound will be clamped
    ///   - animated: Switch animations on/off
    public func setProgress(to progress: Double, animated: Bool) {
        foregroundLayer.strokeEnd = CGFloat(progress.clamped(to: 0...1))
        setColor(by: progress)
        
        if animated {
            progressAnimation(progress)
        } else {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            foregroundLayer.strokeEnd = CGFloat(progress.clamped(to: 0...1))
            CATransaction.commit()
        }
    }
}

// MARK: - Animation
private extension CircularProgressView {
    func progressAnimation(_ progress: Double) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = progress
        animation.duration = animationDuration
        animation.fillMode = .forwards
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.isRemovedOnCompletion = false
        
        foregroundLayer.add(animation, forKey: "foregroundAnimation")
    }
}

// MARK: - Setup bars
private extension CircularProgressView {
    func setupBars(){
        setupBackgroundLayer()
        setupForegroundLayer()
    }
    
    func setupBackgroundLayer() {
        backgroundLayer.path = circularPath.cgPath
        backgroundLayer.lineWidth = lineWidth
        backgroundLayer.strokeColor = backgroundBarColor.cgColor
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.position = pathCenter
        backgroundLayer.transform = CATransform3DMakeRotation(rotationAngle, 0, 0, 1)
        
        layer.addSublayer(backgroundLayer)
    }
    
    func setupForegroundLayer() {
        foregroundLayer.path = circularPath.cgPath
        foregroundLayer.lineWidth = lineWidth
        foregroundLayer.fillColor = UIColor.clear.cgColor
        foregroundLayer.position = pathCenter
        foregroundLayer.transform = CATransform3DMakeRotation(rotationAngle, 0, 0, 1)
        foregroundLayer.strokeEnd = 0
        
        layer.addSublayer(foregroundLayer)
    }
    
    func setColor(by progress: Double) {
        foregroundLayer.strokeColor = (progress >= 1.0) ? maximumBarColor.cgColor : foregroundBarColor.cgColor
    }
}

// MARK: - Setup label
private extension CircularProgressView {
    func setupPercentageLabel() {
        label.textAlignment = .center
        label.textColor = textColor
        label.font = UIFont.systemFont(ofSize: textSize)
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        [label.centerXAnchor.constraint(equalTo: centerXAnchor),
         label.centerYAnchor.constraint(equalTo: centerYAnchor)].forEach { $0.isActive = true }
    }
}

// MARK: - Calculations & helpers
private extension CircularProgressView {
    var circularPath: UIBezierPath {
        return UIBezierPath(arcCenter: .zero, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
    }
    
    var radius: CGFloat {
        let availableSpace = min(frame.width, frame.height)
        return (availableSpace - lineWidth).half
    }
    
    var pathCenter: CGPoint {
        CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    var rotationAngle: CGFloat {
        -CGFloat.pi.half
    }
}
