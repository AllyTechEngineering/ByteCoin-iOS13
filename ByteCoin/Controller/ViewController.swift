//
//  ViewController.swift
//  ByteCoin
//
//  Refactored by Bob Taylor March 2023
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coinManager.fetchCurrencyType(currencyType: "/USD")
    } //override func viewDidLoad
    
    
} //class ViewController

