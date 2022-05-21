//
//  DashBorderedView.swift
//  UIDesignTest
//
//  Created by Thwin Htoo Aung on 2022-05-21.
//

import Foundation
import UIKit

class DashBorderedView: UIView {
    
    override class var layerClass: AnyClass { CAShapeLayer.self }
    var shapeLayer: CAShapeLayer { layer as! CAShapeLayer }
    
    @IBInspectable
    var dashColor: UIColor {
        set {
            shapeLayer.strokeColor = newValue.cgColor
            drawShape()
        }
        get {
            UIColor(
                cgColor: shapeLayer.strokeColor ?? UIColor.clear.cgColor
            )
        }
    }
    
    @IBInspectable
    var dashWidth: CGFloat {
        set {
            shapeLayer.lineWidth = newValue
            drawShape()
        }
        get { shapeLayer.lineWidth }
    }
    
    
    private func drawShape() {
        shapeLayer.lineDashPattern = [3, 3]
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.path = CGPath(
            rect: bounds, transform: nil
        )
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        drawShape()
    }
    
    
}
