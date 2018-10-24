//
//  PushButton.swift
//  WaterBalance
//
//  Created by Ruslan Akberov on 24/10/2018.
//  Copyright © 2018 Ruslan Akberov. All rights reserved.
//

import UIKit

class PushButton: UIButton {
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        UIColor.green.setFill()
        path.fill()
    }
}
