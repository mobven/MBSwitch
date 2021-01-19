//
//  MBSwitch.swift
//  MBSwitch
//
//  Created by Ali Hasanoğlu on 15.01.2021.
//  Copyright © 2021 Ali Hasanoğlu. All rights reserved.
//

import Foundation
import UIKit

public class MBSwitch: UIControl {
    
    /// MBSwitch layers
    public enum Layer {
        /// Represents trackLayer of MBSwitch
        case track
        /// Represents thumbLayer of MBSwitch
        case thumb
    }
    
//  MARK: Customizable properties of Switch
        
    /// Determines trackLayer's cornerRadius is default value or decided by the developer
    private var defaultTrackCornerRadius: Bool = true
    /// Determines thumbLayer's cornerRadius is default value or decided by the developer
    private var defaultThumbCornerRadius: Bool = true
    
    /// Switch's current state
    @IBInspectable public private(set) var isOn: Bool = false {
        didSet {
            self.valueChanged()
        }
    }
    
    /// Background color of trackLayer when the switch state is on
    @IBInspectable public var trackOnTintColor: UIColor = .green {
        didSet {
            trackLayer.backgroundColor = trackBackgroundColor.cgColor
        }
    }

    /// Background color of trackLayer when the switch state is off
    @IBInspectable public var trackOffTintColor: UIColor = .gray {
        didSet {
            trackLayer.backgroundColor = trackBackgroundColor.cgColor
        }
    }
    
    /// Border width of trackLayer when the switch state is on
    @IBInspectable public var trackOnBorderWidth: CGFloat = 0 {
        didSet {
            trackLayer.borderWidth = trackBorderWidth
        }
    }
    
    /// Border width of trackLayer when the switch state is off
    @IBInspectable public var trackOffBorderWidth: CGFloat = 0 {
        didSet {
            trackLayer.borderWidth = trackBorderWidth
        }
    }
    
    /// Border color of trackLayer
    @IBInspectable public var trackBorderColor: UIColor = .black {
        didSet {
            trackLayer.borderColor = trackBorderColor.cgColor
        }
    }
    
    /// Vertical padding of trackLayer
    @IBInspectable public var trackVerticalPadding: CGFloat = 0 {
        didSet {
            layoutSublayers(of: layer)
        }
    }

    /// Padding of thumbLayer
    @IBInspectable public var thumbRadiusPadding: CGFloat = 0 {
        didSet {
            layoutThumbLayer(for: layer.bounds)
        }
    }
    
    /// Background color of thumbLayer
    @IBInspectable public var thumbTintColor: UIColor = .white {
        didSet {
            thumbLayer.backgroundColor = thumbTintColor.cgColor
        }
    }
    
    /// Corner radius of trackLayer. trackLayer has corner defaultly.
    @IBInspectable public var trackCornerRadius: CGFloat = 0 {
        didSet {
            defaultTrackCornerRadius = false
            layoutThumbLayer(for: layer.bounds)
        }
    }
    
    /// Corner radius of thumbLayer. thumbLayer is round defaultly.
    @IBInspectable public var thumbCornerRadius: CGFloat = 0 {
        didSet {
            defaultThumbCornerRadius = false
            layoutThumbLayer(for: layer.bounds)
        }
    }
    
//  MARK: Helper properties
    internal var trackBackgroundColor: UIColor {
        return isOn ? trackOnTintColor: trackOffTintColor
    }
    
    internal var trackBorderWidth: CGFloat {
        return isOn ? trackOnBorderWidth: trackOffBorderWidth
    }
    
    internal var thumbRect: CGSize {
        let height = bounds.height - (2 * (trackBorderWidth + thumbRadiusPadding))
        let width = height
        return CGSize(width: width, height: height)
    }
    
    internal var thumbOrigin: CGPoint {
        let inset = trackBorderWidth + thumbRadiusPadding
        let xPosition = isOn ? bounds.width - thumbRect.width - inset : inset
        return CGPoint(x: xPosition, y: inset)
    }
    
    let trackLayer = CALayer()
    let thumbLayer = CALayer()
    
//    MARK: Initializers
    public convenience init() {
        self.init(frame: .zero)
        frame.size = intrinsicContentSize
    }
    
    public convenience init(with frame: CGRect) {
        self.init(frame: frame)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViews()
    }
    
    fileprivate func initViews() {
        layer.addSublayer(trackLayer)
        layer.addSublayer(thumbLayer)
        
        trackLayer.backgroundColor = trackBackgroundColor.cgColor
        trackLayer.borderColor = trackBorderColor.cgColor
        trackLayer.borderWidth = trackBorderWidth
        
        thumbLayer.backgroundColor = thumbTintColor.cgColor
        thumbLayer.shadowColor = UIColor.gray.cgColor
        thumbLayer.shadowRadius = 2
        thumbLayer.shadowOpacity = 0.4
        thumbLayer.shadowOffset = CGSize(width: 0.75, height: 2)
        thumbLayer.contentsGravity = .resizeAspect
    }
    
    fileprivate func valueChanged() {
        trackLayer.backgroundColor = trackBackgroundColor.cgColor
        trackLayer.borderWidth = trackBorderWidth
        layoutSublayers(of: layer)
    }
    
    /// Sets initial status of MBSwitch
    /// - Parameter on: Initial state of MBSwitch
    /// - Parameter actionable: sendActions can fire or not
    public func setOn(_ on: Bool, actionable: Bool = true) {
        isOn = on
        layoutSublayers(of: layer)
        if actionable {
            sendActions(for: .valueChanged)
        }
    }
    
    override open var intrinsicContentSize : CGSize {
        return CGSize(width: 50, height: 26)
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        setOn(!isOn)
    }
    
    public override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        layoutTrackLayer(for: layer.bounds)
        layoutThumbLayer(for: layer.bounds)
    }

    fileprivate func layoutTrackLayer(for bounds: CGRect) {
        trackLayer.frame = bounds.insetBy(
            dx: trackVerticalPadding, dy: trackVerticalPadding
        )
        trackLayer.cornerRadius = defaultTrackCornerRadius
            ?
            trackLayer.bounds.height / 2
            :
            trackCornerRadius
    }

    fileprivate func layoutThumbLayer(for bounds: CGRect) {
        let size = thumbRect
        let origin = thumbOrigin
        thumbLayer.frame = CGRect(origin: origin, size: size)
        thumbLayer.cornerRadius = defaultThumbCornerRadius
            ?
            size.height / 2
            :
            thumbCornerRadius
    }
    
    /// Adds gradient to a specific layer
    /// - Parameters:
    ///   - layer: Layer that can add gradient
    ///   - colors: Gradient colors array
    ///   - direction: Gradient direction
    public func applyGradient(to layer: MBSwitch.Layer,
                              colors: [UIColor],
                              direction: GradientDirection = .leftToRight) {
        switch layer {
        case .track:
            trackLayer.applyGradient(colors: colors, direction: direction)
        case .thumb:
            thumbLayer.applyGradient(colors: colors, direction: direction)
        }
    }
}
