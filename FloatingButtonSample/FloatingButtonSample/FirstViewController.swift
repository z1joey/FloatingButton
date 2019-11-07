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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touched")
    }

}

#if DEBUG
struct Test {

    static func loadFromNib(onView view: UIView) {
        let floatingThing = UINib(nibName: "FloatingThing", bundle: .main).instantiate(withOwner: self, options: nil).first
        if let floatingThing = floatingThing as? FloatingThing {
            floatingThing.frame = CGRect(x: 100, y: 66, width: 200, height: 80)
            floatingThing.layer.cornerRadius = 40
            view.addSubview(floatingThing)
        }
    }

    static func addViewOnWindow() {
        let nib = UINib(nibName: "FloatingThing", bundle: .main).instantiate(withOwner: self, options: nil).first
        if let floatingThing = nib as? FloatingThing {
            floatingThing.frame = CGRect(x: 24, y: 466, width: 200, height: 80)
            floatingThing.layer.cornerRadius = 40

            if let window = UIApplication.shared.keyWindow {
                window.addSubview(floatingThing)
            }
        }
    }

}
#endif

