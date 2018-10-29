//
//  GraphView.swift
//  WaterBalance
//
//  Created by Ruslan Akberov on 27/10/2018.
//  Copyright © 2018 Ruslan Akberov. All rights reserved.
//

import UIKit

@IBDesignable
class GraphView: UIView {
    
    @IBInspectable var startoColor: UIColor = .red
    @IBInspectable var endColor: UIColor = .green
    var graphPoints = [4, 2, 6, 4, 5, 8, 3]
    
    private struct Constants {
        static let cornerRadiusSize = CGSize(width: 8, height: 8)
        static let margin: CGFloat = 20
        static let topBorder: CGFloat = 60
        static let bottomBorder: CGFloat = 50
        static let colorAlpha: CGFloat = 0.3
        static let circleDiameters: CGFloat = 5
    }
    
    override func draw(_ rect: CGRect) {
        let width = rect.width
        let height = rect.height
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: Constants.cornerRadiusSize)
        path.addClip()
        
        let context = UIGraphicsGetCurrentContext()
        let colors = [startoColor.cgColor, endColor.cgColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0.0, 1.0]
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: colorLocations)
        
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: bounds.height)
        context?.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: [])
        
        // calculate the X point
        let margin = Constants.margin
        let graphWidth = width - margin * 2 - 4
        let columnXPoint = { (column: Int) -> CGFloat in
            let spacing = graphWidth / CGFloat(self.graphPoints.count - 1)
            return CGFloat(column) * spacing + margin + 2
        }
        
        // calculate the Y point
        let topBorder = Constants.topBorder
        let bottomBorder = Constants.bottomBorder
        let graphHeight = height - topBorder - bottomBorder
        let maxValue = graphPoints.max()!
        let columnYPoint = { (graphPoint: Int) -> CGFloat in
            let y = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
            // Flip the graph because Y is positive from top to bottom
            return graphHeight + topBorder - y
        }
        
        // draw the line graph
        UIColor.white.setFill()
        UIColor.white.setStroke()
        let graphPath = UIBezierPath()
        graphPath.move(to: CGPoint(x: columnXPoint(0), y: columnYPoint(graphPoints[0])))
        for i in 1..<graphPoints.count {
            let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
            graphPath.addLine(to: nextPoint)
        }
        
        // save current context state
        context!.saveGState()
        
        // draw gradient underneath of graph
        let clippingPath = graphPath.copy() as! UIBezierPath
        clippingPath.addLine(to: CGPoint(x: columnXPoint(graphPoints.count - 1), y: height))
        clippingPath.addLine(to: CGPoint(x: columnXPoint(0), y: height))
        clippingPath.close()
        clippingPath.addClip()
        let highestYPoint = columnYPoint(maxValue)
        let graphStartPoint = CGPoint(x: margin, y: highestYPoint)
        let graphEndPoint = CGPoint(x: margin, y: bounds.height)
        context?.drawLinearGradient(gradient!, start: graphStartPoint, end: graphEndPoint, options: [])
        graphPath.lineWidth = 2.0
        graphPath.stroke()
        
        // restore context state before clipping (if not - newly added dots will display clipped)
        context?.restoreGState()
        
        // draw dots on graph
        for i in 0..<graphPoints.count {
            var point = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
            point.x -= Constants.circleDiameters / 2
            point.y -= Constants.circleDiameters / 2
            let circle = UIBezierPath(ovalIn: CGRect(origin: point, size: CGSize(width: Constants.circleDiameters, height: Constants.circleDiameters)))
            circle.fill()
        }
        
        // draw horizontal lines
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: margin, y: topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: topBorder))
        linePath.move(to: CGPoint(x: margin, y: graphHeight / 2 + topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: graphHeight / 2 + topBorder))
        linePath.move(to: CGPoint(x: margin, y: height - bottomBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: height - bottomBorder))
        let color = UIColor(white: 1.0, alpha: Constants.colorAlpha)
        color.setStroke()        
        linePath.lineWidth = 1
        linePath.stroke()
        
    }
    
}
