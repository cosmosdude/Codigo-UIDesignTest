//
//  ClippedSlopeView.swift
//  UIDesignTest
//
//  Created by Thwin Htoo Aung on 2022-05-21.
//

import UIKit

class ClippedSlopeView: UIView {

    override class var layerClass: AnyClass { CAShapeLayer.self }
    var shapeLayer: CAShapeLayer { layer as! CAShapeLayer }
    
    @IBInspectable
    var slope: CGFloat = 0 {
        didSet {
            if slope < 0 { slope.negate() }
            drawShape()
        }
    }
    
    @IBInspectable
    var lineWidth: CGFloat {
        set { shapeLayer.lineWidth = newValue }
        get { shapeLayer.lineWidth }
    }
    
    @IBInspectable
    var strokeColor: UIColor {
        set { shapeLayer.strokeColor = newValue.cgColor }
        get { UIColor(cgColor: shapeLayer.strokeColor ?? UIColor.clear.cgColor) }
    }
    
    @IBInspectable
    var fillColor: UIColor {
        set { shapeLayer.fillColor = newValue.cgColor }
        get {
            UIColor(cgColor: shapeLayer.fillColor ?? UIColor.clear.cgColor)
        }
    }
    
    private func drawShape() {
        let path = CGMutablePath()
        path.move(to: CGPoint(x: slope, y: 0))
        path.addLine(to: CGPoint(x: bounds.width, y: 0))
        path.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
        path.addLine(to: CGPoint(x: 0, y: bounds.height))
        path.closeSubpath()
        shapeLayer.path = path
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        drawShape()
    }

}
