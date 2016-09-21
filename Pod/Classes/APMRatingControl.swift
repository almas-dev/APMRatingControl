//
//  Created by Alexander Maslennikov on 12/03/2015.
//  Copyright (c) 2015 Alexander Maslennikov. All rights reserved.
//

import UIKit

open class APMRatingControl: UIControl {
    open var rating: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    open var maximumValue: UInt = 5
    open var canRate: Bool = false
    open var stepRate: CGFloat = 0
    open var borderWidth: CGFloat = 2
    open var borderColor: UIColor?
    open var fillColor: UIColor?

    required public init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.clear
    }

    override open func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        if canRate {
            handleTouch(touch)
            return true
        } else {
            return false
        }
    }

    override open func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        handleTouch(touch)
        return true
    }

    override open func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        sendActions(for: .valueChanged)
    }

    func handleTouch(_ touch: UITouch) {
        let starPlaceWidth = bounds.size.width / CGFloat(maximumValue)
        let location = touch.location(in: self)
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

    func updateRating(_ rating: CGFloat) {
        if rating != self.rating && rating >= 0 && rating <= CGFloat(maximumValue) {
            self.rating = rating
        }
    }

    override open func draw(_ rect: CGRect) {
        let starZone = ((rect.size.width - borderWidth * 2) / CGFloat(maximumValue))
        let starHeight = (starZone <= rect.size.height) ? starZone : rect.size.height - borderWidth * 2
        for idx in  0 ..< maximumValue {
            let center = CGPoint(x: starZone * CGFloat(idx) + starZone / 2 + borderWidth, y: rect.size.height / 2)
            let frame = CGRect(x: center.x - starHeight / 2, y: center.y - starHeight / 2, width: starHeight, height: starHeight)
            drawStarShapeWithFrame(frame, borderColor: borderColor ?? tintColor, fillColor: fillColor ?? tintColor, progress: rating - CGFloat(idx))
        }
    }

    func drawStarShapeWithFrame(_ frame: CGRect, borderColor: UIColor, fillColor: UIColor, progress: CGFloat) {
        let starShapePath = starBezierPath(frame, lineWidth: borderWidth)

        let rightRectOfStar = CGRect(x: frame.minX + progress * frame.width, y: frame.minY, width: frame.width - progress * frame.width, height: frame.height)
        let clipPath = UIBezierPath(rect: CGRect.infinite)
        clipPath.append(UIBezierPath(rect: rightRectOfStar))
        clipPath.usesEvenOddFillRule = true
        if borderWidth == 0 {
            borderColor.setFill()
            starShapePath.fill()
        }
        UIGraphicsGetCurrentContext()!.saveGState()
        clipPath.addClip()
        fillColor.setFill()
        starShapePath.fill()

        UIGraphicsGetCurrentContext()!.restoreGState()
        borderColor.setStroke()
        starShapePath.stroke()
    }

    // MARK: - Private methods

    fileprivate func starBezierPath(_ frame: CGRect, lineWidth: CGFloat) -> UIBezierPath {
        let bezierPath = UIBezierPath()
        bezierPath.lineJoinStyle = .round
        bezierPath.lineWidth = lineWidth
        bezierPath.move(to: CGPoint(x: frame.minX + 0.50000 * frame.width, y: frame.minY + 0.0000 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.68750 * frame.width, y: frame.minY + 0.28261 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 1.00000 * frame.width, y: frame.minY + 0.36957 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.79167 * frame.width, y: frame.minY + 0.65217 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.81250 * frame.width, y: frame.minY + 1.00000 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.50000 * frame.width, y: frame.minY + 0.86957 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.18750 * frame.width, y: frame.minY + 1.00000 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.20833 * frame.width, y: frame.minY + 0.65217 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.00000 * frame.width, y: frame.minY + 0.36957 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.31250 * frame.width, y: frame.minY + 0.28261 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.50000 * frame.width, y: frame.minY + 0.00000 * frame.height))
        bezierPath.close()
        return bezierPath
    }
}
