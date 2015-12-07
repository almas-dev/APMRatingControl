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
    let ratingControl = APMRatingControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(white: 0.23, alpha: 1.0)

        ratingControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ratingControl)
        view.addConstraints([
                NSLayoutConstraint(item: ratingControl, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: ratingControl, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: ratingControl, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 132),
                NSLayoutConstraint(item: ratingControl, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 20)
        ])
    }
}

