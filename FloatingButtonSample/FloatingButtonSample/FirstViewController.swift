//
//  FirstViewController.swift
//  FloatingButtonSample
//
//  Created by joey on 11/6/19.
//  Copyright © 2019 TGI Technology. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    var isFloatingButtonHidden: Bool = true {
        didSet {
            switch isFloatingButtonHidden {
            case true:
                print("True")
            case false:
                print("False")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

