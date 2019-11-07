//
//  FloatingWindow.swift
//  FloatingButtonSample
//
//  Created by joey on 11/7/19.
//  Copyright © 2019 TGI Technology. All rights reserved.
//

import UIKit

class FloatingWindow: UIWindow {

    static var defaultOrigin = CGPoint(x: 10, y: 100)
    static var defaultSize = CGSize(width: 200, height: 80)

    init(root: UIViewController) {
        super.init(frame: CGRect(origin: FloatingWindow.defaultOrigin, size: FloatingWindow.defaultSize))
        rootViewController = root
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show() {
        backgroundColor = .clear
        windowLevel = UIWindow.Level.alert - 1
        screen = .main
        isHidden = false

        let floatingThing = FloatingControl.shared.floatingThing
        floatingThing.frame = bounds
        floatingThing.layer.cornerRadius = FloatingWindow.defaultSize.height / 2
        floatingThing.layer.masksToBounds = true

        addSubview(floatingThing)

        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(panAction(pan:)))
        self.addGestureRecognizer(pan)

        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction(tap:)))
        self.addGestureRecognizer(tap)
    }

    @objc fileprivate func panAction(pan: UIPanGestureRecognizer) {
        if pan.state == .began || pan.state == .changed {
            let translation = pan.translation(in: pan.view)
            if let view = pan.view {
                view.center = CGPoint(x:view.center.x + translation.x,
                y:view.center.y + translation.y)
            }
            pan.setTranslation(CGPoint(x: 0, y: 0), in: pan.view)
        }
    }

    @objc fileprivate func tapAction(tap: UITapGestureRecognizer) {
        print("tap")
    }

}

extension UIViewController {

    func floating() {
        self.view.layer.masksToBounds = true

        UIView.animate(withDuration: 0.25, animations: {
            self.view.layer.cornerRadius = FloatingWindow.defaultSize.height / 2
            self.view.frame = CGRect.init(origin: FloatingWindow.defaultOrigin, size: FloatingWindow.defaultSize)
            self.view.layoutIfNeeded()
        }) { _ in
            self.navigationController?.popViewController(animated: false)
            FloatingControl.shared.activeFloatingWindow(root: self)
        }
    }

}
