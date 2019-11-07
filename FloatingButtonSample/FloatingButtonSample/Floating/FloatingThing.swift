//
//  FloatingThing.swift
//  FloatingButtonSample
//
//  Created by joey on 11/7/19.
//  Copyright © 2019 TGI Technology. All rights reserved.
//

import UIKit

class FloatingThing: UIView {

    static let margin: CGFloat = 8.0
    
    fileprivate let contentWidth: CGFloat = 60
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!

    var alignMode: AlignMode = .left {
        didSet {
            switch alignMode {
            case .left:
                leadingConstraint.constant = FloatingThing.margin
            case .right:
                let constant = bounds.width - FloatingThing.margin - contentWidth
                leadingConstraint.constant = constant
            }
        }
    }

    enum AlignMode {
        case left, right
    }

}
