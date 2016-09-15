//
//  Created by Alexander Maslennikov on 12/03/2015.
//  Copyright (c) 2015 Alexander Maslennikov. All rights reserved.
//

import UIKit

public class APMRatingControl: UIControl {
    public var rating: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    public var maximumValue: UInt = 5
    public var canRate: Bool = false
    public var stepRate: CGFloat = 0
    public var borderWidth: CGFloat = 2
    public var borderColor: UIColor?
    public var fillColor: UIColor?

    required public init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.clearColor()
    }

    override public func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        if canRate {
            handleTouch(touch)
            return true
        } else {
            return false
        }
    }

    override public func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        handleTouch(touch)
        return true
    }

    override public func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
        sendActionsForControlEvents(.ValueChanged)
    }

    func handleTouch(touch: UITouch) {
        let starPlaceWidth = bounds.size.width / CGFloat(maximumValue)
        let location = touch.locationInView(self)
        let locRating: CGFloat
        if location.x >= 0 {
            locRating = location.x / starPlaceWidth
        } else {
            locRating = 0
        }

        if stepRate > 0 {
            var roundRating = round(locRating / stepRate) * stepRate
            if roundRating < locRating {
                roundRating += stepRate
            }
            updateRating(roundRating)
        } else {
            updateRating(locRating)
        }
    }

    func updateRating(rating: CGFloat) {
        if rating != self.rating && rating >= 0 && rating <= CGFloat(maximumValue) {
            self.rating = rating
        }
    }

    override public func drawRect(rect: CGRect) {
        let starZone = ((rect.size.width - borderWidth * 2) / CGFloat(maximumValue))
        let starHeight = (starZone <= rect.size.height) ? starZone : rect.size.height - borderWidth * 2
        for idx in  0 ..< maximumValue {
            let center = CGPointMake(starZone * CGFloat(idx) + starZone / 2 + borderWidth, rect.size.height / 2)
            let frame = CGRectMake(center.x - starHeight / 2, center.y - starHeight / 2, starHeight, starHeight)
            drawStarShapeWithFrame(frame, borderColor: borderColor ?? tintColor, fillColor: fillColor ?? tintColor, progress: rating - CGFloat(idx))
        }
    }

    func drawStarShapeWithFrame(frame: CGRect, borderColor: UIColor, fillColor: UIColor, progress: CGFloat) {
        let starShapePath = starBezierPath(frame, lineWidth: borderWidth)

        let rightRectOfStar = CGRectMake(frame.minX + progress * frame.width, frame.minY, frame.width - progress * frame.width, frame.height)
        let clipPath = UIBezierPath(rect: CGRectInfinite)
        clipPath.appendPath(UIBezierPath(rect: rightRectOfStar))
        clipPath.usesEvenOddFillRule = true
        if borderWidth == 0 {
            borderColor.setFill()
            starShapePath.fill()
        }
        CGContextSaveGState(UIGraphicsGetCurrentContext()!)
        clipPath.addClip()
        fillColor.setFill()
        starShapePath.fill()

        CGContextRestoreGState(UIGraphicsGetCurrentContext()!)
        borderColor.setStroke()
        starShapePath.stroke()
    }

    // MARK: - Private methods

    private func starBezierPath(frame: CGRect, lineWidth: CGFloat) -> UIBezierPath {
        let bezierPath = UIBezierPath()
        bezierPath.lineJoinStyle = .Round
        bezierPath.lineWidth = lineWidth
        bezierPath.moveToPoint(CGPointMake(frame.minX + 0.50000 * frame.width, frame.minY + 0.0000 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.68750 * frame.width, frame.minY + 0.28261 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 1.00000 * frame.width, frame.minY + 0.36957 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.79167 * frame.width, frame.minY + 0.65217 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.81250 * frame.width, frame.minY + 1.00000 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.50000 * frame.width, frame.minY + 0.86957 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.18750 * frame.width, frame.minY + 1.00000 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.20833 * frame.width, frame.minY + 0.65217 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.00000 * frame.width, frame.minY + 0.36957 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.31250 * frame.width, frame.minY + 0.28261 * frame.height))
        bezierPath.addLineToPoint(CGPointMake(frame.minX + 0.50000 * frame.width, frame.minY + 0.00000 * frame.height))
        bezierPath.closePath()
        return bezierPath
    }
}
