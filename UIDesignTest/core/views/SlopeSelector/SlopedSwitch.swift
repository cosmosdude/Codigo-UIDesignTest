//
//  SlopedSwitch.swift
//  UIDesignTest
//
//  Created by Thwin Htoo Aung on 2022-06-06.
//

import UIKit

class SlopedSwitch: UIControl {

    
    override class var layerClass: AnyClass
    { CAShapeLayer.self }
    var shapeLayer: CAShapeLayer { layer as! CAShapeLayer }
    private var highlightMesh: CAShapeLayer!
    private var highlightDash: CAShapeLayer!
    
    private var leftLabel: UILabel!
    private var rightLabel: UILabel!
    
    @IBInspectable
    var horizontalPadding: CGFloat = 0 {
        didSet {
            layoutSubviews()
        }
    }
    
    @IBInspectable
    var verticalPadding: CGFloat = 0 {
        didSet {
            layoutSubviews()
        }
    }
    
    
    
    @IBInspectable
    var slope: CGFloat = 100 {
        didSet {
            layoutSubviews()
        }
    }
    
    @IBInspectable
    var leftName: String = "" {
        didSet { leftLabel?.text = leftName }
    }
    
    @IBInspectable
    var rightName: String = "" {
        didSet { rightLabel?.text = rightName }
    }
    
    private(set) var selectedType: SelectionType = .byRate
    
    func setSelection(by selectionType: SelectionType) {
        self.selectedType = selectionType
        layoutSubviews()
    }
    
    override var tintColor: UIColor! {
        set {
            super.tintColor = newValue
            shapeLayer.strokeColor = newValue?.cgColor ?? UIColor.clear.cgColor
            highlightDash.strokeColor = newValue?.cgColor ?? UIColor.clear.cgColor
            highlightMesh.fillColor = newValue?.cgColor ?? UIColor.clear.cgColor
        }
        get { super.tintColor }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = tintColor?.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineCap = .round
        shapeLayer.lineJoin = .round
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = 1
            
        highlightMesh = { () -> CAShapeLayer in
            let shape = CAShapeLayer()
            layer.addSublayer(shape)
            shape.lineWidth = 0
            shape.fillColor = tintColor?.cgColor ?? UIColor.clear.cgColor
            return shape
        }()
        highlightDash = { () -> CAShapeLayer in
            let shape = CAShapeLayer()
            layer.addSublayer(shape)
            shape.lineWidth = 2
            shape.strokeColor = tintColor?.cgColor ?? UIColor.clear.cgColor
            return shape
        }()
        
        leftLabel = { () -> UILabel in
            let lbl = UILabel()
            lbl.font = UIFont(name: "EncodeSansSemiCondensed-Bold", size: 15)
            lbl.text = leftName
            addSubview(lbl)
            return lbl
        }()
        rightLabel = { () -> UILabel in
            let lbl = UILabel()
            lbl.font = UIFont(name: "EncodeSansSemiCondensed-Bold", size: 15)
            lbl.text = rightName
            addSubview(lbl)
            return lbl
        }()
    }

    
    var strokeEnd: CGFloat {
        set { shapeLayer.strokeEnd = newValue }
        get { shapeLayer.strokeEnd }
    }
    
}


extension SlopedSwitch {
    override var intrinsicContentSize: CGSize {
        CGSize(width: 0, height: 60)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let actualFrame = CGRect(
            origin: .init(x: horizontalPadding, y: verticalPadding),
            size: CGSize(
                width: bounds.size.width - (horizontalPadding * 2),
                height: bounds.size.height - (verticalPadding * 2)
            )
        )
        layoutLabels(in: actualFrame)
        drawLine(in: actualFrame)
        drawHighlightMesh(in: actualFrame)
        drawHighlightLine(in: actualFrame)
    }
    
    private func layoutLabels(in actualFrame: CGRect) {
        let centerY = bounds.size.height / 2
        let actualWidth = actualFrame.size.width
        let widthInterval = actualWidth / 4
        
        leftLabel.sizeToFit()
        leftLabel.center = CGPoint(
            x: actualFrame.origin.x + widthInterval,
            y: centerY
        )
        
        rightLabel.sizeToFit()
        rightLabel.center = CGPoint(
            x: actualFrame.origin.x + widthInterval * 3,
            y: centerY
        )
    }
    
    private func drawLine(in actualFrame: CGRect) {
        
        let path = CGMutablePath()
        
        let lineHalf = shapeLayer.lineWidth / 2
        
        if selectedType == .byRoom {
            path.move(
                to: CGPoint(
                    x: actualFrame.origin.x + slope + lineHalf,
                    y: actualFrame.origin.y + lineHalf
                )
            )
            path.addLine(
                to: CGPoint(
                    x: actualFrame.origin.x + actualFrame.size.width - lineHalf,
                    y: actualFrame.origin.y + lineHalf
                )
            )
            path.addLine(
                to: CGPoint(
                    x: actualFrame.origin.x + actualFrame.size.width - lineHalf,
                    y: actualFrame.origin.y + actualFrame.size.height - lineHalf
                )
            )
            path.addLine(
                to: CGPoint(
                    x: actualFrame.origin.x + lineHalf,
                    y: actualFrame.origin.y + actualFrame.size.height - lineHalf
                )
            )
            path.closeSubpath()
        } else {
            path.move(
                to: CGPoint(
                    x: actualFrame.origin.x + actualFrame.size.width - lineHalf,
                    y: actualFrame.origin.y + lineHalf
                )
            )
            
            path.addLine(
                to: CGPoint(
                    x: actualFrame.origin.x + actualFrame.size.width - lineHalf,
                    y: actualFrame.origin.y + actualFrame.size.height - lineHalf
                )
            )
            
            path.addLine(
                to: CGPoint(
                    x: actualFrame.origin.x + lineHalf,
                    y: actualFrame.origin.y + actualFrame.size.height - lineHalf
                )
            )
            
            path.addLine(
                to: CGPoint(
                    x: actualFrame.origin.x + slope + lineHalf,
                    y: actualFrame.origin.y + lineHalf
                )
            )
            path.closeSubpath()
        }
        
        
        shapeLayer.path = path
    }
    
    
    
    private func drawHighlightMesh(in actualFrame: CGRect) {
        highlightMesh.frame = bounds
        
        let path = CGMutablePath()
        let halfWidth = actualFrame.size.width / 2
        if selectedType == .byRoom {
            
            
            path.move(
                to: .init(
                    x:actualFrame.origin.x + slope, y: actualFrame.origin.y
                )
            )
            
            path.addLine(
                to: .init(
                    x:actualFrame.origin.x + halfWidth + slope,
                    y: actualFrame.origin.y
                )
            )
            path.addLine(
                to: .init(
                    x:actualFrame.origin.x + halfWidth,
                    y: actualFrame.origin.y + actualFrame.size.height
                )
            )
            
            path.addLine(
                to: .init(
                    x:actualFrame.origin.x,
                    y: actualFrame.origin.y + actualFrame.size.height
                )
            )
            path.closeSubpath()
        } else {
            path.move(
                to: .init(
                    x:actualFrame.origin.x + halfWidth + slope,
                    y: actualFrame.origin.y
                )
            )
            path.addLine(
                to: .init(
                    x:actualFrame.origin.x + actualFrame.size.width,
                    y: actualFrame.origin.y
                )
            )
            path.addLine(
                to: .init(
                    x:actualFrame.origin.x + actualFrame.size.width,
                    y: actualFrame.origin.y + actualFrame.size.height
                )
            )
            path.addLine(
                to: .init(
                    x:actualFrame.origin.x + halfWidth,
                    y: actualFrame.origin.y + actualFrame.size.height
                )
            )
            path.closeSubpath()
        }
        highlightMesh.path = path
    }
    
    private func drawHighlightLine(in actualFrame: CGRect) {
        highlightDash.frame = bounds
        
        let path = CGMutablePath()
        let lineHalf = shapeLayer.lineWidth / 2
        
        if selectedType == .byRoom {
            path.move(
                to: CGPoint(
                    x: actualFrame.origin.x + lineHalf,
                    y: actualFrame.origin.y + actualFrame.size.height - lineHalf
                )
            )
            path.addLine(
                to: CGPoint(
                    x: actualFrame.origin.x + (actualFrame.size.width / 2) - lineHalf ,
                    y: actualFrame.origin.y + actualFrame.size.height - lineHalf
                )
            )
        } else {
            path.move(
                to: CGPoint(
                    x: actualFrame.origin.x + (actualFrame.size.width / 2) + lineHalf,
                    y: actualFrame.origin.y + actualFrame.size.height - lineHalf
                )
            )
            path.addLine(
                to: CGPoint(
                    x: actualFrame.origin.x + actualFrame.size.width - lineHalf,
                    y: actualFrame.origin.y + actualFrame.size.height - lineHalf
                )
            )
        }
        highlightDash.path = path
        
    }
    
}



extension SlopedSwitch {
    
    enum SelectionType {
        case byRoom, byRate
        
        mutating func toggle() {
            switch self {
            case .byRoom: self = .byRate
            case .byRate: self = .byRoom
            }
        }
    }
    
}
