//
//  FloatingControl.swift
//  FloatingButtonSample
//
//  Created by joey on 11/7/19.
//  Copyright © 2019 TGI Technology. All rights reserved.
//

import UIKit

final class FloatingControl: NSObject {

    static let shared = FloatingControl()

    private override init() {}

    private var window: FloatingWindow?

    func activeFloatingWindow(onRoot root: UIViewController) {
        let control = FloatingControl.shared
        control.window = nil

        let window = FloatingWindow(root: root)

        window.show()
        control.window = window
    }

}

// MARK: -
extension UIViewController {

    func activeFloatingWindow() {
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

