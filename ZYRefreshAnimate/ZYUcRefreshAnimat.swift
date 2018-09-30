//
//  ZYUcRefreshAnimat.swift
//  ZYRefreshAnimate
//
//  Created by yu zhou on 29/09/2018.
//  Copyright © 2018 yu zhou. All rights reserved.
//

import Foundation
import MJRefresh

class ZYUcRefreshAnimat: MJRefreshHeader {
    var bigCircleLayer: CAShapeLayer = CAShapeLayer()
    var smallCircleLayer: CAShapeLayer = CAShapeLayer()
    var isRefreshed: Bool = false
    override var state: MJRefreshState{
        didSet{
            if state == .refreshing {
                isRefreshed = true
                var anim = CAKeyframeAnimation(keyPath: "transform.rotation.x")
                anim.values = [0,CGFloat.pi*2,0]
                anim.duration = 2
                anim.repeatCount = Float(Int.max)
                anim.isRemovedOnCompletion = false
                anim.fillMode = kCAFillModeForwards
                bigCircleLayer.add(anim, forKey: "bigCircleLayerX")
                
                anim = CAKeyframeAnimation(keyPath: "transform.rotation.z")
                anim.values = [0,CGFloat.pi,0]
                anim.duration = 2
                anim.repeatCount = Float(Int.max)
                anim.isRemovedOnCompletion = false
                anim.fillMode = kCAFillModeForwards
                bigCircleLayer.add(anim, forKey: "bigCircleLayerY")
                
                anim = CAKeyframeAnimation(keyPath: "transform.rotation.x")
                anim.values = [CGFloat.pi*2.5,CGFloat.pi/2,CGFloat.pi*2.5]
                anim.duration = 2
                anim.repeatCount = Float(Int.max)
                anim.isRemovedOnCompletion = false
                anim.fillMode = kCAFillModeForwards
                smallCircleLayer.add(anim, forKey: "smallCircleLayerX")
                
                anim = CAKeyframeAnimation(keyPath: "transform.rotation.z")
                anim.values = [0,-CGFloat.pi,0]
                anim.duration = 2
                anim.repeatCount = Float(Int.max)
                anim.isRemovedOnCompletion = false
                anim.fillMode = kCAFillModeForwards
                smallCircleLayer.add(anim, forKey: "smallCircleLayerY")
            }else if state == .idle {
                if isRefreshed == true {
                    self.perform(#selector(resetLayers), with: nil, afterDelay: 0.7)
                    isRefreshed = false
                }
            }
        }
    }
    
    @objc func resetLayers() {
        bigCircleLayer.removeAllAnimations()
        smallCircleLayer.removeAllAnimations()
        bigCircleLayer.transform = CATransform3DMakeRotation(CGFloat.pi*1.5, 1, 0, 1)
        smallCircleLayer.transform = CATransform3DMakeRotation(0, 1, 0, 1)
    }
    
    override var pullingPercent: CGFloat{
        didSet{
            let percent = pullingPercent > 0 ? (pullingPercent > 1 ? 1 : pullingPercent) : 0
            bigCircleLayer.transform = CATransform3DMakeRotation(CGFloat.pi*1.5*(1-pow(percent, 4)), 1, 0, 1)
            smallCircleLayer.transform = CATransform3DMakeRotation(CGFloat.pi*1.5*pow(percent, 4), 1, 0, 1)
        }
    }
    
    override func prepare() {
        super.prepare()
        let bigCirclePath = UIBezierPath(arcCenter: CGPoint(x: 6, y: 6), radius: 12, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: false)
        bigCircleLayer = CAShapeLayer()
        bigCircleLayer.bounds = CGRect(x: 0, y: 0, width: 12, height: 12)
        bigCircleLayer.position = CGPoint(x: self.mj_w/2, y: self.mj_h/2)
        bigCircleLayer.lineWidth = 3
        bigCircleLayer.strokeColor = UIColor.blue.cgColor
        bigCircleLayer.fillColor = UIColor.clear.cgColor
        bigCircleLayer.path = bigCirclePath.cgPath
        self.layer.addSublayer(bigCircleLayer)
        bigCircleLayer.transform = CATransform3DMakeRotation(CGFloat.pi*1.5, 1, 0, 1)
        
        let smallCirclePath = UIBezierPath(arcCenter: CGPoint(x: 4.5, y: 4.5), radius: 9, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: false)
        smallCircleLayer = CAShapeLayer()
        smallCircleLayer.bounds = CGRect(x: 0, y: 0, width: 9, height: 9)
        smallCircleLayer.position = CGPoint(x: self.mj_w/2, y: self.mj_h/2)
        smallCircleLayer.lineWidth = 3
        smallCircleLayer.strokeColor = UIColor.blue.withAlphaComponent(0.5).cgColor
        smallCircleLayer.fillColor = UIColor.clear.cgColor
        smallCircleLayer.path = smallCirclePath.cgPath
        self.layer.addSublayer(smallCircleLayer)
        
    }
    override func placeSubviews() {
        super.placeSubviews()
        bigCircleLayer.position = CGPoint(x: self.mj_w/2, y: self.mj_h/2)
        smallCircleLayer.position = CGPoint(x: self.mj_w/2, y: self.mj_h/2)
    }
}
