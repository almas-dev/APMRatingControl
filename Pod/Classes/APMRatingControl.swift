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
        let spacing: CGFloat = 5

        let availableWidth = rect.size.width - (spacing * (CGFloat(maximumValue) - 1)) - 2
        let cellWidth = (availableWidth / CGFloat(maximumValue))
        let starSide = (cellWidth <= rect.size.height) ? cellWidth : rect.size.height - 2
        for var idx: CGFloat = 0; idx < CGFloat(maximumValue); idx++ {
            let center = CGPointMake(cellWidth * idx + cellWidth / 2 + spacing * idx + 1, rect.size.height / 2)
            let frame = CGRectMake(center.x - starSide / 2, center.y - starSide / 2, starSide, starSide)
            drawStarShapeWithFrame(frame, borderColor: borderColor ?? tintColor, fillColor: fillColor ?? tintColor, progress: rating - idx)
        }
    }

    func drawStarShapeWithFrame(frame: CGRect, borderColor: UIColor, fillColor: UIColor, progress: CGFloat) {
        let minX = CGRectGetMinX(frame)
        let minY = CGRectGetMinY(frame)
        let width = CGRectGetWidth(frame)
        let height = CGRectGetHeight(frame)

        let starShapePath = UIBezierPath()
        starShapePath.lineJoinStyle = .Round
        starShapePath.lineWidth = 2
        starShapePath.moveToPoint(CGPointMake(minX + 0.50000 * width, minY + 0.0000 * height))
        starShapePath.addLineToPoint(CGPointMake(minX + 0.68750 * width, minY + 0.28261 * height))
        starShapePath.addLineToPoint(CGPointMake(minX + 1.00000 * width, minY + 0.36957 * height))
        starShapePath.addLineToPoint(CGPointMake(minX + 0.79167 * width, minY + 0.65217 * height))
        starShapePath.addLineToPoint(CGPointMake(minX + 0.81250 * width, minY + 1.00000 * height))
        starShapePath.addLineToPoint(CGPointMake(minX + 0.50000 * width, minY + 0.86957 * height))
        starShapePath.addLineToPoint(CGPointMake(minX + 0.18750 * width, minY + 1.00000 * height))
        starShapePath.addLineToPoint(CGPointMake(minX + 0.20833 * width, minY + 0.65217 * height))
        starShapePath.addLineToPoint(CGPointMake(minX + 0.00000 * width, minY + 0.36957 * height))
        starShapePath.addLineToPoint(CGPointMake(minX + 0.31250 * width, minY + 0.28261 * height))
        starShapePath.addLineToPoint(CGPointMake(minX + 0.50000 * width, minY + 0.00000 * height))
        starShapePath.closePath()

        let rightRectOfStar = CGRectMake(minX + progress * width, minY, width - progress * width, height)
        let clipPath = UIBezierPath(rect: CGRectInfinite)
        clipPath.appendPath(UIBezierPath(rect: rightRectOfStar))
        clipPath.usesEvenOddFillRule = true
        CGContextSaveGState(UIGraphicsGetCurrentContext())
        clipPath.addClip()
        fillColor.setFill()
        starShapePath.fill()

        CGContextRestoreGState(UIGraphicsGetCurrentContext())
        borderColor.setStroke()
        starShapePath.stroke()
    }
}
