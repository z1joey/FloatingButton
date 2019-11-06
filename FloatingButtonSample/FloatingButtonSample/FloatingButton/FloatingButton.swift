//
//  FloatingButton.swift
//  FloatingButtonSample
//
//  Created by joey on 11/6/19.
//  Copyright © 2019 TGI Technology. All rights reserved.
//

import UIKit

class FloatingButton: UIView {

    @IBOutlet var contentView: UIView!

    @IBOutlet weak var centralButton: UIButton!

    var cornerRadius: CGFloat = 0.0 {
        didSet {
            contentView.layer.cornerRadius = cornerRadius
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("FloatingButton", owner: self, options: nil)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame = contentView.frame

        addSubview(contentView)
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }

}
