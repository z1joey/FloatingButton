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

    private var windows: [FloatingWindow] = []

    lazy var floatingThing: FloatingThing = {
        let floatingNib = UINib(nibName: "FloatingThing", bundle: .main).instantiate(withOwner: self, options: nil).first
        if let floatingThing = floatingNib as? FloatingThing {
            return floatingThing
        }
        return FloatingThing()
    }()

    func activeFloatingWindow(onRoot root: UIViewController) {
        let control = FloatingControl.shared
        control.windows.removeAll()

        let window = FloatingWindow(root: root)
        window.show()
        control.windows.append(window)
    }

}
