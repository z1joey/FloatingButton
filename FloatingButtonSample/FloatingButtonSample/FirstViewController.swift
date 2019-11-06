//
//  FirstViewController.swift
//  FloatingButtonSample
//
//  Created by joey on 11/6/19.
//  Copyright © 2019 TGI Technology. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        testLoadingFromXib()
    }

    func testLoadingFromXib() {
        let floatingThing = UINib(nibName: "FloatingThing", bundle: .main).instantiate(withOwner: self, options: nil).first
        if let floatingThing = floatingThing as? FloatingThing {
            floatingThing.frame = CGRect(x: 100, y: 66, width: 200, height: 80)
            floatingThing.layer.cornerRadius = 40
            view.addSubview(floatingThing)
        }
    }

}

