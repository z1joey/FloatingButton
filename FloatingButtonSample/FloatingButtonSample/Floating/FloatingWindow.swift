//
//  FloatingWindow.swift
//  FloatingButtonSample
//
//  Created by joey on 11/7/19.
//  Copyright © 2019 TGI Technology. All rights reserved.
//

import UIKit

class FloatingWindow: UIWindow {

    static let defaultFrame = CGRect(x: 10, y: 100, width: 68, height: 68)

    static fileprivate var atSidesWidth: CGFloat = FloatingWindow.defaultFrame.width + 100

    var floatingThing: UIView = UIView()

    init(root: UIViewController) {
        super.init(frame: FloatingWindow.defaultFrame)

        rootViewController = root
        backgroundColor = .white
        layer.cornerRadius = bounds.height / 2

        let floatingNib = UINib(nibName: "FloatingThing", bundle: .main).instantiate(withOwner: self, options: nil).first

        if let thing = floatingNib as? UIView {
            floatingThing = thing
        }

        floatingThing.frame = bounds
        floatingThing.layer.cornerRadius = FloatingWindow.defaultFrame.height / 2
        floatingThing.layer.masksToBounds = true

        addSubview(floatingThing)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show() {
        windowLevel = UIWindow.Level.alert - 1
        screen = .main
        isHidden = false

        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(panAction(pan:)))
        self.addGestureRecognizer(pan)

        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction(tap:)))
        self.addGestureRecognizer(tap)
    }

}

// MARK: - Gesture
fileprivate extension FloatingWindow {

    @objc func panAction(pan: UIPanGestureRecognizer) {
        if pan.state == .began || pan.state == .changed {
            UIView.animate(withDuration: 0.25) {
                self.frame.size = FloatingWindow.defaultFrame.size
                self.floatingThing.frame.origin = .zero
            }

            let translation = pan.translation(in: pan.view)
            let origin = Calculator.Window.getPanOrigin(originalOrigin: frame.origin, translation: translation)

            frame = CGRect(origin: origin, size: bounds.size)
        }

        if pan.state == .cancelled || pan.state == .ended || pan.state == .failed {
            transformIfNeeded()
        }

        pan.setTranslation(CGPoint.zero, in: self)
    }

    @objc func tapAction(tap: UITapGestureRecognizer) {
        print("tap")
    }

    func transformIfNeeded(offset: CGFloat = 24.0) {
        let minX = Calculator.Window.minX + offset
        let maxX = Calculator.Window.maxX - offset

        if frame.origin.x <= minX {
            UIView.animate(withDuration: 0.25) {
                self.frame.origin = Calculator.Window.getSidesOrigin(originalOrigin: self.frame.origin, offset: offset)
                self.frame.size.width = FloatingWindow.atSidesWidth

                self.floatingThing.frame.origin = Calculator.Thing.atRight

                self.layoutIfNeeded()
            }
        }

        else if frame.origin.x >= maxX {
            UIView.animate(withDuration: 0.25) {
                self.frame.origin = Calculator.Window.getSidesOrigin(originalOrigin: self.frame.origin, offset: offset)
                self.frame.size.width = FloatingWindow.atSidesWidth

                self.floatingThing.frame.origin = Calculator.Thing.atLeft

                self.layoutIfNeeded()
            }
        }

        else {
            UIView.animate(withDuration: 0.25) {
                self.frame.size.width = FloatingWindow.defaultFrame.width
                self.floatingThing.frame.origin = .zero
                self.layoutIfNeeded()
            }
        }
    }

}

// MARK: - Tools
extension FloatingWindow {

    struct Calculator {

        struct Window {
            static var minX: CGFloat = 0
            static var minY: CGFloat = 0

            static var maxX: CGFloat {
                return UIScreen.main.bounds.width - FloatingWindow.defaultFrame.width
            }
            static var maxY: CGFloat {
                return UIScreen.main.bounds.height - FloatingWindow.defaultFrame.height
            }

            static func getSidesOrigin(originalOrigin origin: CGPoint, offset: CGFloat) -> CGPoint {
                let minX = Calculator.Window.minX + offset
                let maxX = Calculator.Window.maxX - offset

                var point: CGPoint = origin

                if origin.x <= minX {
                    point.x = FloatingWindow.defaultFrame.width - FloatingWindow.atSidesWidth
                }

                if origin.x >= maxX {
                    point.x = UIScreen.main.bounds.width - FloatingWindow.defaultFrame.width
                }

                return point
            }

            static func getPanOrigin(originalOrigin origin: CGPoint, translation: CGPoint) -> CGPoint {
                var origin = CGPoint(x: origin.x + translation.x, y: origin.y + translation.y)

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

        struct Thing {
            static var atLeft: CGPoint {
                return CGPoint.zero
            }

            static var atRight: CGPoint {
                return CGPoint(x: FloatingWindow.atSidesWidth - FloatingWindow.defaultFrame.width, y: 0)
            }
        }

    }

}

// MARK: -
extension UIViewController {

    func startFloating() {
        self.view.layer.masksToBounds = true

        UIView.animate(withDuration: 0.5, animations: {
            self.view.layer.cornerRadius = FloatingWindow.defaultFrame.height / 2
            self.view.frame = FloatingWindow.defaultFrame
            self.view.layoutIfNeeded()
        }) { _ in
            self.dismiss(animated: false, completion: nil)
            FloatingControl.shared.activeFloatingWindow(onRoot: self)
        }
    }

}
