//
//  ZYImagePathRefreshAnimat.swift
//  ZYRefreshAnimate
//
//  Created by yu zhou on 30/09/2018.
//  Copyright © 2018 yu zhou. All rights reserved.
//

import Foundation
import MJRefresh

class ZYImagePathRefreshAnimat: MJRefreshHeader {
    var shapeLayer = CAShapeLayer()
    var lightSpotView = CALayer()
    override var state: MJRefreshState{
        didSet{
            if state == .refreshing {
                lightSpotView.isHidden = false
                let anim = CAKeyframeAnimation(keyPath: "position")
                anim.fillMode = kCAFillModeForwards
                anim.isRemovedOnCompletion = false
                anim.duration = 3
                anim.repeatCount = Float(Int.max)
                anim.path = shapeLayer.path
                lightSpotView.add(anim, forKey: "lightSpotViewPosition")
            }else if state == .idle {
                if lightSpotView.isHidden == false {
                    self.perform(#selector(resetLayers), with: nil, afterDelay: 0.7)
                }
            }
        }
    }
    
    @objc func resetLayers() {
        lightSpotView.isHidden = true
        lightSpotView.removeAllAnimations()
        shapeLayer.strokeEnd = 0
    }
    
    override var pullingPercent: CGFloat {
        didSet{
            if lightSpotView.isHidden {
                let percent = pullingPercent > 0 ? (pullingPercent > 1 ? 1 : pullingPercent) : 0
                shapeLayer.strokeEnd = pow(percent, 4)
            }
        }
    }
    
    override func prepare() {
        super.prepare()
        shapeLayer = CAShapeLayer()
        let pathPath = UIBezierPath()
        pathPath.move(to: CGPoint(x: 57.21, y: 66.65))
        pathPath.addCurve(to: CGPoint(x: 57.73, y: 65.71), controlPoint1: CGPoint(x: 57.53, y: 66.43), controlPoint2: CGPoint(x: 57.71, y: 66.11))
        pathPath.addCurve(to: CGPoint(x: 56.71, y: 59.81), controlPoint1: CGPoint(x: 57.85, y: 64.01), controlPoint2: CGPoint(x: 56.94, y: 60.67))
        pathPath.addCurve(to: CGPoint(x: 53.93, y: 54.72), controlPoint1: CGPoint(x: 56.38, y: 58.64), controlPoint2: CGPoint(x: 55.46, y: 56.95))
        pathPath.addCurve(to: CGPoint(x: 52.25, y: 39.77), controlPoint1: CGPoint(x: 55.41, y: 50.19), controlPoint2: CGPoint(x: 54.86, y: 45.21))
        pathPath.addCurve(to: CGPoint(x: 40.49, y: 26.65), controlPoint1: CGPoint(x: 49.65, y: 34.34), controlPoint2: CGPoint(x: 45.73, y: 29.96))
        pathPath.addCurve(to: CGPoint(x: 45.47, y: 38.35), controlPoint1: CGPoint(x: 43.4, y: 32.05), controlPoint2: CGPoint(x: 45.06, y: 35.95))
        pathPath.addCurve(to: CGPoint(x: 44.34, y: 47.48), controlPoint1: CGPoint(x: 45.89, y: 40.74), controlPoint2: CGPoint(x: 45.51, y: 43.78))
        pathPath.addCurve(to: CGPoint(x: 37.41, y: 43.27), controlPoint1: CGPoint(x: 41.01, y: 45.7), controlPoint2: CGPoint(x: 38.7, y: 44.29))
        pathPath.addCurve(to: CGPoint(x: 22.63, y: 30.15), controlPoint1: CGPoint(x: 36.13, y: 42.24), controlPoint2: CGPoint(x: 31.2, y: 37.87))
        pathPath.addCurve(to: CGPoint(x: 25.58, y: 35.27), controlPoint1: CGPoint(x: 23.79, y: 32.53), controlPoint2: CGPoint(x: 24.78, y: 34.24))
        pathPath.addCurve(to: CGPoint(x: 34.7, y: 45.68), controlPoint1: CGPoint(x: 26.39, y: 36.31), controlPoint2: CGPoint(x: 29.43, y: 39.78))
        pathPath.addCurve(to: CGPoint(x: 24.81, y: 38.92), controlPoint1: CGPoint(x: 30.24, y: 42.78), controlPoint2: CGPoint(x: 26.94, y: 40.52))
        pathPath.addCurve(to: CGPoint(x: 17.14, y: 32.44), controlPoint1: CGPoint(x: 22.68, y: 37.31), controlPoint2: CGPoint(x: 20.13, y: 35.16))
        pathPath.addCurve(to: CGPoint(x: 27.37, y: 45.68), controlPoint1: CGPoint(x: 22.32, y: 39.48), controlPoint2: CGPoint(x: 25.73, y: 43.89))
        pathPath.addCurve(to: CGPoint(x: 38.01, y: 55.24), controlPoint1: CGPoint(x: 29.01, y: 47.47), controlPoint2: CGPoint(x: 32.55, y: 50.66))
        pathPath.addCurve(to: CGPoint(x: 25.58, y: 57.68), controlPoint1: CGPoint(x: 32.9, y: 57.25), controlPoint2: CGPoint(x: 28.76, y: 58.06))
        pathPath.addCurve(to: CGPoint(x: 12.93, y: 52.24), controlPoint1: CGPoint(x: 22.41, y: 57.3), controlPoint2: CGPoint(x: 18.19, y: 55.49))
        pathPath.addCurve(to: CGPoint(x: 28.28, y: 65.05), controlPoint1: CGPoint(x: 17.92, y: 59.08), controlPoint2: CGPoint(x: 23.03, y: 63.35))
        pathPath.addCurve(to: CGPoint(x: 40.49, y: 66.19), controlPoint1: CGPoint(x: 29.92, y: 65.59), controlPoint2: CGPoint(x: 36.63, y: 66.79))
        pathPath.addCurve(to: CGPoint(x: 51.51, y: 62.95), controlPoint1: CGPoint(x: 45.14, y: 65.46), controlPoint2: CGPoint(x: 47.2, y: 62.84))
        pathPath.addCurve(to: CGPoint(x: 57.21, y: 66.65), controlPoint1: CGPoint(x: 53.91, y: 63.01), controlPoint2: CGPoint(x: 55.81, y: 64.25))
        pathPath.close()
        
        shapeLayer.path = pathPath.cgPath
        shapeLayer.bounds = pathPath.cgPath.boundingBox
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.strokeEnd = 0
        self.layer.addSublayer(shapeLayer)
        
//        lightSpotView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.light))
//        lightSpotView.bounds = CGRect(x: 0, y: 0, width: 5, height: 5)
//        lightSpotView.layer.cornerRadius = 1
//        lightSpotView.subviews.last?.backgroundColor = UIColor.white.withAlphaComponent(0.7)
//        lightSpotView.isHidden = true
//        self.addSubview(lightSpotView)
        
        lightSpotView = CALayer()//UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.light))
        lightSpotView.bounds = CGRect(x: 0, y: 0, width: 5, height: 5)
        lightSpotView.cornerRadius = 1
        lightSpotView.backgroundColor = UIColor.white.withAlphaComponent(0.7).cgColor
        //lightSpotView.subviews.last?.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        lightSpotView.isHidden = true
        shapeLayer.addSublayer(lightSpotView)
        
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        shapeLayer.position = CGPoint(x: self.mj_w/2, y: self.mj_h/2)
        lightSpotView.position = CGPoint(x: 57.21, y: 66.65)
    }
}
