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
    
    @IBInspectable var counter: Int = 0 {
        didSet {
            if counter <= Constants.numberOfGlasses {
                setNeedsDisplay()
            }
        }
    }
    @IBInspectable var outlineColor: UIColor = .blue
    @IBInspectable var counterColor: UIColor = .orange
    
    override func draw(_ rect: CGRect) {
        // center filled arc
        let center = CGPoint(x: bounds.width / 2 , y: bounds.height / 2)
        let diameter: CGFloat = max(bounds.width, bounds.height)
        let startAngle: CGFloat = 3 * .pi / 4
        let endAngle: CGFloat = .pi / 4
        let path = UIBezierPath(arcCenter: center, radius: diameter / 2 - Constants.arcWidth / 2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.lineWidth = Constants.arcWidth
        counterColor.setStroke()
        path.stroke()
        
        // arc outlines
        let arcAngle: CGFloat = 2 * .pi - startAngle + endAngle
        let arcLengthPerGlass = arcAngle / CGFloat(Constants.numberOfGlasses)
        let outlineEndAngle = arcLengthPerGlass * CGFloat(counter) + startAngle
        let outlinePath = UIBezierPath(arcCenter: center, radius: diameter / 2 - Constants.halfOfLineWidth, startAngle: startAngle, endAngle: outlineEndAngle, clockwise: true)
        outlinePath.addArc(withCenter: center, radius: diameter / 2 - Constants.arcWidth + Constants.halfOfLineWidth, startAngle: outlineEndAngle, endAngle: startAngle, clockwise: false)
        outlinePath.close()
        outlineColor.setStroke()
        outlinePath.lineWidth = Constants.lineWidth
        outlinePath.stroke()
        
        // markers
        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()
        outlineColor.setFill()
        let markerWidth: CGFloat = 5
        let markerSize: CGFloat = 10
        let markerPath = UIBezierPath(rect: CGRect(x: -markerWidth / 2, y: 0, width: markerWidth, height: markerSize))
        context.translateBy(x: rect.width / 2, y: rect.height / 2)
        for i in 1...Constants.numberOfGlasses {
            context.saveGState()
            let angle = arcLengthPerGlass * CGFloat(i) + startAngle - .pi / 2
            context.rotate(by: angle)
            context.translateBy(x: 0, y: rect.height / 2 - markerSize)
            markerPath.fill()
            context.restoreGState()
        }
        context.restoreGState()
    }
    
}
