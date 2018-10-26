//
//  CounterView.swift
//  WaterBalance
//
//  Created by Ruslan Akberov on 26/10/2018.
//  Copyright © 2018 Ruslan Akberov. All rights reserved.
//

import UIKit

@IBDesignable
class CounterView: UIView {
    
    private struct Constants {
        static let numberOfGlasses = 8
        static let lineWidth: CGFloat = 5.0
        static let arcWidth: CGFloat = 76
        static var halfOfLineWidth: CGFloat {
            return lineWidth / 2
        }
    }
    
    @IBInspectable var counter: Int = 3
    @IBInspectable var outlineColor: UIColor = .blue
    @IBInspectable var counterColor: UIColor = .orange
    
    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: bounds.width / 2 , y: bounds.height / 2)
        let diameter: CGFloat = max(bounds.width, bounds.height)
        let startAngle: CGFloat = 3 * .pi / 4
        let endAngle: CGFloat = .pi / 4
        let path = UIBezierPath(arcCenter: center, radius: diameter / 2 - Constants.arcWidth / 2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.lineWidth = Constants.arcWidth
        counterColor.setStroke()
        path.stroke()
    }
}
