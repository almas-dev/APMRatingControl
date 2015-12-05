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

        view.backgroundColor = UIColor.magentaColor()

        ratingControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ratingControl)
        view.addConstraints([
                NSLayoutConstraint(item: ratingControl, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: ratingControl, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1.0, constant: 30),
                NSLayoutConstraint(item: ratingControl, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1.0, constant: -30),
                NSLayoutConstraint(item: ratingControl, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 44)
        ])
    }
}

