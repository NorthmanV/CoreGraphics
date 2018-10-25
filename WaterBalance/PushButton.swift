//
//  PushButton.swift
//  WaterBalance
//
//  Created by Ruslan Akberov on 24/10/2018.
//  Copyright © 2018 Ruslan Akberov. All rights reserved.
//

import UIKit

class PushButton: UIButton {
    
    private struct Constants {
        static let plusLineWidth: CGFloat = 3.0
        static let plusButtonScale: CGFloat = 0.6
        static let halfPointShift: CGFloat = 0.5
    }
    
    private var halfWidth: CGFloat {
        return bounds.width / 2
    }
    
    private var halfHeight: CGFloat {
        return bounds.height / 2
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        UIColor.blue.setFill()
        path.fill()
        
        let plusWidth: CGFloat = min(bounds.width, bounds.height) * Constants.plusButtonScale
        let halfPlusWidth: CGFloat = plusWidth / 2
        let plusPath = UIBezierPath()
        plusPath.lineWidth = Constants.plusLineWidth
        plusPath.move(to: CGPoint(x: halfWidth - halfPlusWidth, y: halfHeight))
        plusPath.addLine(to: CGPoint(x: halfWidth + halfPlusWidth, y: halfHeight))
        UIColor.white.setStroke()
        plusPath.stroke()
    }

}
