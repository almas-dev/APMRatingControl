//
//  Created by Alexander Maslennikov on 12/03/2015.
//  Copyright (c) 2015 Alexander Maslennikov. All rights reserved.
//

import UIKit

public class APMRatingControl: UIControl {

    required public init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.blueColor()
    }

    override public func drawRect(rect: CGRect) {
        let starCount = 5
        let spaceBetweenStar: CGFloat = 10
        let starColor = UIColor.yellowColor()
        let starHighlightColor = UIColor.orangeColor()
        var ratedStarIndex: Int = 3 {
            didSet{
                setNeedsDisplay()
            }
        }

        let starSize = rect.width / CGFloat(starCount) - spaceBetweenStar * 2
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, rect.width)
        var xCenter: CGFloat = starSize / 2 + spaceBetweenStar * 1.5
        let yCenter: CGFloat = rect.height / 2

        let r: CGFloat = starSize / 2.0
        let flip: CGFloat = -1.0

        for i in 0...Int(starCount-1) {

            if i > ratedStarIndex-1 {
                CGContextSetFillColorWithColor(context, starColor.CGColor)
                CGContextSetStrokeColorWithColor(context, starColor.CGColor)
            }else {
                CGContextSetFillColorWithColor(context, starHighlightColor.CGColor)
                CGContextSetStrokeColorWithColor(context, starHighlightColor.CGColor)
            }
            let theta: CGFloat = CGFloat(2.0) * CGFloat(M_PI) * (CGFloat(2.0) / CGFloat(5.0)) // 114 degree

            CGContextMoveToPoint(context, xCenter, r*flip+yCenter)

            for k in 0...5 {
                let x: CGFloat = r * sin(CGFloat(k) * theta)
                let y: CGFloat = r * cos(CGFloat(k) * theta)
                CGContextAddLineToPoint(context, x+xCenter, y*flip+yCenter)
            }
            xCenter += starSize + spaceBetweenStar * 1.5
            CGContextClosePath(context)
            CGContextFillPath(context)
        }
    }
}
