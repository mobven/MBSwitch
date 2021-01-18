//
//  CALayer + Extension.swift
//  MBSwitch
//
//  Created by Ali Hasanoğlu on 17.01.2021.
//  Copyright © 2021 Ali Hasanoğlu. All rights reserved.
//

import Foundation
import UIKit

/// Gradient color direcitons
public enum GradientDirection: Int {
    case topToBottom = 0
    case bottomToTop
    case leftToRight
    case rightToLeft
    case topLeftToBottomRight
    case topRightToBottomLeft
}

internal extension CALayer {
    func applyGradient(colors: [UIColor], direction: GradientDirection) {
        
        let gradient = self.sublayers?.first?.sublayers?.first as? CAGradientLayer ?? CAGradientLayer()
        gradient.colors = colors.map { $0.cgColor }
        gradient.locations = [0.0, 1.0]
        gradient.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        gradient.cornerRadius = cornerRadius
        
        switch direction {
        
        case .topToBottom:
            gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        case .bottomToTop:
            gradient.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradient.endPoint = CGPoint(x: 0.5, y: 0.0)
        case .leftToRight:
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        case .rightToLeft:
            gradient.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 0.0, y: 0.5)
        case .topLeftToBottomRight:
            gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        case .topRightToBottomLeft:
            gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.0)
        }
        
        if !(self.sublayers?.first?.sublayers?.first is CAGradientLayer) {
            removeSublayer(layerIndex: 0)
            self.insertSublayer(gradient, at: 0)
        }
    }
    
    private func removeSublayer(layerIndex index: Int) {
        guard let sublayers = self.sublayers else {
            return
        }
        if sublayers.count > index {
            sublayers[index].removeFromSuperlayer()
        }
    }
}
