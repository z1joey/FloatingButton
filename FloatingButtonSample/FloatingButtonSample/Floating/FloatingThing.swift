//
//  FloatingThing.swift
//  FloatingButtonSample
//
//  Created by joey on 11/6/19.
//  Copyright © 2019 TGI Technology. All rights reserved.
//

import UIKit

class FloatingThing: UIView {

    static let defaultSize = CGSize(width: 200.0, height: 80.0)

    @IBOutlet weak var timeButton: UIButton!

    @IBAction func timeButtonTapped(_ sender: UIButton) {
        print("Tick")
    }

}
