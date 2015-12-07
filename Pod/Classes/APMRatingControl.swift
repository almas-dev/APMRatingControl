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

        backgroundColor = UIColor.clearColor()
    }

    override public func drawRect(rect: CGRect) {
        let spacing: CGFloat = 5
        let maximumValue: CGFloat = 5
        let value: CGFloat = 3.33

        let availableWidth = rect.size.width - (spacing * (maximumValue - 1)) - 2
        let cellWidth = (availableWidth / maximumValue)
        let starSide = (cellWidth <= rect.size.height) ? cellWidth : rect.size.height - 2
        for var idx: CGFloat = 0; idx < maximumValue; idx++ {
            let center = CGPointMake(cellWidth * idx + cellWidth / 2 + spacing * idx + 1, rect.size.height / 2)
            let frame = CGRectMake(center.x - starSide / 2, center.y - starSide / 2, starSide, starSide)
            drawStarShapeWithFrame(frame, tintColor: UIColor.whiteColor(), progress: value - idx)
        }
    }

    func drawStarShapeWithFrame(frame: CGRect, tintColor: UIColor, progress: CGFloat) {
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
        tintColor.setFill()
        starShapePath.fill()

        CGContextRestoreGState(UIGraphicsGetCurrentContext())
        tintColor.setStroke()
        starShapePath.stroke()
    }
}
