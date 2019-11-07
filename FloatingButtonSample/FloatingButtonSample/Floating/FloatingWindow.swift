//
//  FloatingWindow.swift
//  FloatingButtonSample
//
//  Created by joey on 11/7/19.
//  Copyright © 2019 TGI Technology. All rights reserved.
//

import UIKit

class FloatingWindow: UIWindow {

    static private let leftToMargin: CGFloat = 8
    
    static let defaultOrigin = CGPoint(x: 10, y: 100)
    static let defaultSize = CGSize(width: 68 + FloatingWindow.leftToMargin, height: 68 + FloatingWindow.leftToMargin)

    init(root: UIViewController) {
        super.init(frame: CGRect(origin: FloatingWindow.defaultOrigin, size: FloatingWindow.defaultSize))
        rootViewController = root
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show() {
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

}

// MARK: - Gesture
extension FloatingWindow {

    @objc fileprivate func panAction(pan: UIPanGestureRecognizer) {
        let translation = pan.translation(in: pan.view)
        let origin = Cal.getOrigin(original: self.frame.origin, translation: translation)

        self.frame = CGRect(origin: origin, size: bounds.size)

        if pan.state == .cancelled || pan.state == .ended || pan.state == .failed {
            transformIfNeeded()
        }

        pan.setTranslation(CGPoint.zero, in: self)
    }

    @objc fileprivate func tapAction(tap: UITapGestureRecognizer) {
        print("tap")
    }

    fileprivate func transformIfNeeded() {

    }

}

// MARK: - Tools
extension FloatingWindow {

    struct Cal {

        static let margin: CGFloat = 10

        static var maxX: CGFloat {
            return UIScreen.main.bounds.size.width - FloatingWindow.defaultSize.width
        }

        static var maxY: CGFloat {
            return UIScreen.main.bounds.size.height - FloatingWindow.defaultSize.height
        }

        static func getOrigin(original: CGPoint, translation: CGPoint) -> CGPoint {
            var origin = CGPoint(x: original.x + translation.x, y: original.y + translation.y)

            if origin.x < 0 {
                origin.x = 0
            }

            if origin.x > maxX {
                origin.x = maxX
            }

            if origin.y < 0 {
                origin.y = 0
            }

            if origin.y > maxY {
                origin.y = maxY
            }

            return origin
        }

    }

}

// MARK: -
extension UIViewController {

    func startFloating() {
        self.view.layer.masksToBounds = true

        UIView.animate(withDuration: 0.5, animations: {
            self.view.layer.cornerRadius = FloatingWindow.defaultSize.height / 2
            self.view.frame = CGRect.init(origin: FloatingWindow.defaultOrigin, size: FloatingWindow.defaultSize)
            self.view.layoutIfNeeded()
        }) { _ in
            self.dismiss(animated: false, completion: nil)
            FloatingControl.shared.activeFloatingWindow(onRoot: self)
        }
    }

}
