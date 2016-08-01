//
//  ViewController.swift
//  APMRatingControl
//
//  Created by Alexander Maslennikov on 12/03/2015.
//  Copyright (c) 2015 Alexander Maslennikov. All rights reserved.
//

import UIKit
import APMRatingControl

class ViewController: UIViewController {
    let fixedRating = APMRatingControl()
    let ratingControl = APMRatingControl()
    let floatRatingControl = APMRatingControl()
    let twoColorsRatingControl = APMRatingControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(white: 0.23, alpha: 1.0)


        fixedRating.rating = 3.33
        fixedRating.maximumValue = 8
        fixedRating.borderWidth = 0.5
        fixedRating.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fixedRating)
        view.addConstraints([
                NSLayoutConstraint(item: fixedRating, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: fixedRating, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 0.25, constant: 0),
                NSLayoutConstraint(item: fixedRating, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 132),
                NSLayoutConstraint(item: fixedRating, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 20)
        ])


        ratingControl.canRate = true
        ratingControl.stepRate = 0.5
        ratingControl.borderColor = UIColor.whiteColor()
        ratingControl.fillColor = UIColor.whiteColor()
        ratingControl.addTarget(self, action: #selector(ViewController.ratingControlChangeValueAction(_:)), forControlEvents: .ValueChanged)
        ratingControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ratingControl)
        view.addConstraints([
                NSLayoutConstraint(item: ratingControl, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: ratingControl, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 0.75, constant: 0),
                NSLayoutConstraint(item: ratingControl, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 132),
                NSLayoutConstraint(item: ratingControl, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 20)
        ])


        floatRatingControl.canRate = true
        floatRatingControl.borderWidth = 1
        floatRatingControl.borderColor = UIColor.whiteColor()
        floatRatingControl.fillColor = UIColor.whiteColor()
        floatRatingControl.addTarget(self, action: #selector(ViewController.ratingControlChangeValueAction(_:)), forControlEvents: .ValueChanged)
        floatRatingControl.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
        floatRatingControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(floatRatingControl)
        view.addConstraints([
                NSLayoutConstraint(item: floatRatingControl, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: floatRatingControl, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1.25, constant: 0),
                NSLayoutConstraint(item: floatRatingControl, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 264),
                NSLayoutConstraint(item: floatRatingControl, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 30)
        ])


        twoColorsRatingControl.rating = 3
        twoColorsRatingControl.canRate = true
        twoColorsRatingControl.borderWidth = 0
        twoColorsRatingControl.stepRate = 1
        twoColorsRatingControl.borderColor = UIColor(red: 224 / 255, green: 232 / 255, blue: 236 / 255, alpha: 1)
        twoColorsRatingControl.fillColor = UIColor(red: 255 / 255, green: 180 / 255, blue: 57 / 255, alpha: 1)
        twoColorsRatingControl.addTarget(self, action: #selector(ViewController.ratingControlChangeValueAction(_:)), forControlEvents: .ValueChanged)
        twoColorsRatingControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(twoColorsRatingControl)
        view.addConstraints([
                NSLayoutConstraint(item: twoColorsRatingControl, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: twoColorsRatingControl, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1.75, constant: 0),
                NSLayoutConstraint(item: twoColorsRatingControl, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 132),
                NSLayoutConstraint(item: twoColorsRatingControl, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 20)
        ])
    }

    func ratingControlChangeValueAction(sender: APMRatingControl) {
        print("\(sender.rating)")
    }
}

