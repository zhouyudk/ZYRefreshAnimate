//
//  ZYMailRefreshAnimat.swift
//  ZYRefreshAnimate
//
//  Created by yu zhou on 10/10/2018.
//  Copyright © 2018 yu zhou. All rights reserved.
//

import Foundation
import MJRefresh

class ZYMailRefreshAnimat: MJRefreshHeader {
    var replicatorLayer = CAReplicatorLayer()
    var contentLayer = CALayer()
    var isRefreshed = false
    override var state: MJRefreshState {
        didSet{
            if state == .refreshing {
                var anim = CABasicAnimation(keyPath: "transform.rotation.z")
                anim.fromValue = 0
                anim.toValue = CGFloat.pi
                anim.duration = 1
                anim.isRemovedOnCompletion = false
                anim.fillMode = kCAFillModeForwards
                self.replicatorLayer.add(anim, forKey: "transform.rotation.z")
                
                self.replicatorLayer.instanceDelay = 1/14
                anim = CABasicAnimation(keyPath: "opacity")
                anim.fromValue = 1
                anim.toValue = 0.3
                anim.duration = 1
                anim.isRemovedOnCompletion = false
                anim.repeatCount = Float(Int.max)
                anim.fillMode = kCAFillModeForwards
                self.contentLayer.add(anim, forKey: "opacity")
                
                self.isRefreshed = true
            }
        }
    }
    
    override var pullingPercent: CGFloat {
        didSet{
            if !isRefreshed {
                let percent = pullingPercent > 0 ? (pullingPercent > 1 ? 1 : pullingPercent) : 0
                replicatorLayer.instanceCount = Int(percent*14)
            }else{
                replicatorLayer.removeAllAnimations()
                contentLayer.removeAllAnimations()
                CATransaction.begin()
                CATransaction.setAnimationDuration(0.7)
                //动画完成后将属性复原
                CATransaction.setCompletionBlock({
                    self.isRefreshed = false
                    self.replicatorLayer.transform = CATransform3DMakeScale(1, 1, 1)
                })
                replicatorLayer.transform = CATransform3DMakeScale(0.3, 0.3, 1)
                CATransaction.commit()
            }
        }
    }
    
    override func prepare() {
        super.prepare()
        
        replicatorLayer.frame = CGRect(x: 0, y: 0, width: 54, height: 54)
        self.layer.addSublayer(replicatorLayer)
        
        replicatorLayer.instanceCount = 10
        
        var transform = CATransform3DIdentity
//        transform = CATransform3DTranslate(transform, 0, -35, 0)
        transform = CATransform3DRotate(transform, CGFloat.pi/7, 0, 0, 1)//CATransform3DTranslate(transform, 50, 0, 0)
//        transform = CATransform3DTranslate(transform, 0, -15, 0)
        replicatorLayer.instanceTransform = transform
        
        contentLayer = CALayer()
        contentLayer.backgroundColor = UIColor.gray.cgColor
        contentLayer.frame = CGRect(x: 27-1.5, y: 10, width: 3, height: 10)
        replicatorLayer.addSublayer(contentLayer)
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        replicatorLayer.position = CGPoint(x: self.mj_w/2, y: self.mj_h/2)
    }
}
