//
//  ZYTextRefreshAnimat.swift
//  ZYRefreshAnimate
//
//  Created by yu zhou on 28/09/2018.
//  Copyright © 2018 yu zhou. All rights reserved.
//

import Foundation
import MJRefresh
import ZYShimmer

class ZYTextRefreshAnimat: MJRefreshHeader {
    var containerView: UIView = UIView()
    var shapeLayer: CAShapeLayer = CAShapeLayer()
    var shimmerView: ZYShimmerView = ZYShimmerView()
    override var state: MJRefreshState{
        didSet{
            if state == .refreshing {
                shimmerView.shimmering = true
            }
        }
    }
    override var pullingPercent: CGFloat {
        didSet{
            let percent = pullingPercent > 0 ? (pullingPercent > 1 ? 1 : pullingPercent) : 0
            if shimmerView.shimmering == false {
                shapeLayer.strokeEnd = pow(percent, 4)
            }else{
                CATransaction.begin()
                CATransaction.setAnimationDuration(0.7)
                //动画完成后将属性复原
                CATransaction.setCompletionBlock({
                    self.shimmerView.shimmering = false
                    self.shapeLayer.transform = CATransform3DMakeScale(1, 1, 1)
                    self.shapeLayer.strokeEnd = 0
                })
                shapeLayer.transform = CATransform3DMakeScale(0.3, 0.3, 1)
                CATransaction.commit()
            }
        }
    }
    override func prepare() {
        super.prepare()
        containerView = UIView()
        shapeLayer = CAShapeLayer()
        shapeLayer.frame = containerView.bounds
        shapeLayer.isGeometryFlipped = true
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 2.0
        shapeLayer.lineJoin = kCALineJoinRound
        containerView.layer.addSublayer(shapeLayer)
        
        let path = UIBezierPath(text: "RefreshAnimat", attrs: [NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue) : UIFont.systemFont(ofSize: 28)])
        shapeLayer.bounds = path.cgPath.boundingBox
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.orange.cgColor
        shapeLayer.removeAllAnimations()
        shapeLayer.strokeEnd = 0
        
        shimmerView = ZYShimmerView()
        self.addSubview(shimmerView)
        shimmerView.contentView = containerView
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        shimmerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 54)
        containerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 54)
        shapeLayer.position = CGPoint(x: containerView.bounds.width/2, y: 27)
    }
    
}


// MARK: - UIBezierPath
extension UIBezierPath {
    
    /// 使用String生成bezier曲线
    ///
    /// - Parameters:
    ///   - text: 文本
    ///   - attrs: 文本样式
    convenience init(text:String,attrs:[NSAttributedStringKey : Any]) {
        let attrStr = NSAttributedString(string: text, attributes: attrs as [NSAttributedStringKey : Any])
        let paths = CGMutablePath()
        let line  = CTLineCreateWithAttributedString(attrStr)
        let runArray = CTLineGetGlyphRuns(line)
        for i in 0..<CFArrayGetCount(runArray) {
            let run = unsafeBitCast(CFArrayGetValueAtIndex(runArray, i), to: CTRun.self)
            let key = Unmanaged.passRetained(kCTFontAttributeName).autorelease().toOpaque()
            let dic =  CTRunGetAttributes(run)
            let runFont = unsafeBitCast(CFDictionaryGetValue(dic, key), to: CTFont.self)
            for runGlyphIndex in 0..<CTRunGetGlyphCount(run) {
                let glyphRange = CFRangeMake(runGlyphIndex, 1)
                var glyph: CGGlyph = CGGlyph()
                var position: CGPoint = CGPoint()
                CTRunGetGlyphs(run, glyphRange, &glyph)
                CTRunGetPositions(run, glyphRange, &position)
                
                let path = CTFontCreatePathForGlyph(runFont, glyph, nil)
                if path == nil {
                    continue
                }
                let t = CGAffineTransform(translationX: position.x, y: position.y)
                paths.addPath(path!, transform: t)
            }
        }
        self.init()
        self.move(to: CGPoint.zero)
        self.append(UIBezierPath(cgPath: paths))
    }
}
