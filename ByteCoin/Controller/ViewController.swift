//
//  ViewController.swift
//  ByteCoin
//
//  Refactored by Bob Taylor March 2023
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
   
    /*
     Create user objects
     */
    let coinManager = CoinManager()
    //********************************************************************
    /*
     Set user variables
     */
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitCoinLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    //********************************************************************
    

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView(currencyPicker, didSelectRow: 0, inComponent: 0)
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        /*
         The following is debug test code - delete when done debugging
         */
       // coinManager.fetchCurrencyType(currencyType: "/USD")
        //*****************************************************************
    } //override func viewDidLoad
    
    /*
     The following are UIPickerView methods
     */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    } // func numberOfComponents
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    } //func pickerView
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    } //func pickerView
    
    /*
     This function gets the UIPickerView user selected currency and passes it to the coinManager struc
     which uses the getCoinPrice method
     This function also uses the currencyArray property in the coinManager struc
     */
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    } //func pickerView
    
} //class ViewController

