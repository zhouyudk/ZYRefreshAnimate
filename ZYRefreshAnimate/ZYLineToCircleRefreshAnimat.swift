//
//  ZYLineToCircleRefreshAnimat.swift
//  ZYRefreshAnimate
//
//  Created by yu zhou on 15/10/2018.
//  Copyright © 2018 yu zhou. All rights reserved.
//

import Foundation
import MJRefresh

class ZYLineToCircleRefreshAnimat: MJRefreshHeader {
    var shapeLayer = CAShapeLayer()
    override var state: MJRefreshState {
        didSet{
            
        }
    }
    
    override var pullingPercent: CGFloat {
        didSet{
            let percent = pullingPercent > 0 ? (pullingPercent > 1 ? 1 : pullingPercent) : 0
            let pp = pow(percent, 2)
            shapeLayer.strokeEnd = pp
            let lineLength = 30+2*CGFloat.pi*12
            if pp > (lineLength-30)/lineLength {
                shapeLayer.strokeStart = pp - (lineLength-30)/lineLength
            }
        }
    }
    
    override func prepare() {
        super.prepare()
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 24, y: 0))
        bezierPath.addLine(to: CGPoint(x: 24, y: 30))
        bezierPath.addArc(withCenter: CGPoint(x: 12, y: 30), radius: 12, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 3
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.bounds = CGRect(x: 0, y: 0, width: 24, height: 42)
        self.layer.addSublayer(shapeLayer)
        
        shapeLayer.strokeEnd = 0
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        shapeLayer.position = CGPoint(x: self.mj_w/2, y: self.mj_h/2)
    }
}
