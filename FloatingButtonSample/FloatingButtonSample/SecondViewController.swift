//
//  SecondViewController.swift
//  FloatingButtonSample
//
//  Created by joey on 11/6/19.
//  Copyright © 2019 TGI Technology. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.activeFloatingWindow()
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
