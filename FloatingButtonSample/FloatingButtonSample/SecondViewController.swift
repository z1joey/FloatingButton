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

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
