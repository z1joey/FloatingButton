//
//  FloatingThing.swift
//  FloatingButtonSample
//
//  Created by joey on 11/6/19.
//  Copyright © 2019 TGI Technology. All rights reserved.
//

import UIKit

class FloatingThing: UIView {

    @IBOutlet weak var timeButton: UIButton!

    @IBAction func timeButtonTapped(_ sender: UIButton) {
        print("Tick")
    }

}
