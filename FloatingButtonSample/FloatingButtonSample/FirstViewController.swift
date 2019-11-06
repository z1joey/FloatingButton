//
//  FirstViewController.swift
//  FloatingButtonSample
//
//  Created by joey on 11/6/19.
//  Copyright © 2019 TGI Technology. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet var floatThingView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        #if DEBUG
        Test.loadFromNib(onView: self.view)
        #endif
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        floatThingView.frame = CGRect(x: 24, y: 24, width: 200, height: 80)
        view.addSubview(floatThingView)
    }

    @IBAction func wasDragged(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        if sender.state == UIGestureRecognizer.State.began || sender.state == UIGestureRecognizer.State.changed {
            if let view = sender.view {
                view.center = CGPoint(x:view.center.x + translation.x,
                y:view.center.y + translation.y)
            }
            sender.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
        }
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

