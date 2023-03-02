//
//  CoinManager.swift
//  ByteCoin
//
//  Refactored by Bob Taylor March 2023
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

/*
 Protocol goes here
 */
//By convention, Swift protocols are usually written in the file that has the class/struct which will call the
//delegate methods, i.e. the CoinManager.
protocol CoinManagerDelegate {
    
    //Create the method stubs wihtout implementation in the protocol.
    //It's usually a good idea to also pass along a reference to the current class.
    //e.g. func didUpdatePrice(_ coinManager: CoinManager, price: String, currency: String)
    //Check the Clima module for more info on this.
    func didUpdatePrice(price: String, currency: String)
    func didFailWithError(error: Error)
} //protocol CoinManagerDelegate

struct CoinManager {
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "E9C4B782-FD42-4DBE-A9C9-27184537E3BC"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]


    func getCoinPrice(for currency: String) {
        // Step 1: create a URL
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        if let url = URL(string: urlString) {
            // Step 2: create a URLSession
            let session = URLSession(configuration: .default)
            // Step 3: Give URLSession a Task
            // This is a Closure - look for the "in"
            let task = session.dataTask(with: url) { (data, response, error ) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                } //if error
                if let safeData = data {
                    if let bitCoinPrice = self.parseJSON(safeData) {
                        let priceString = String(format: "%.2f", bitCoinPrice)
                        self.delegate?.didUpdatePrice(price: priceString, currency: currency)
                    } //  iif let bitCoinPrice
                } // if let safeData
            } // let task = session (this is a closure)
            // Step 4: Start the task
            task.resume()
        } // if let url = URL
    } //func performRequest
    
    func parseJSON(_ data: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let lastPrice = decodedData.rate
            //let lastPriceString = String(format: "%0.2f", decodedData.rate)
            //print("This is a test of lastPrice: \(lastPriceString)")
            // the following is just debug code
            //let decodedDataString = String(format: "%0.2f", decodedData.rate)
            //print("The rate is: \(decodedDataString)")
            //print("The Time is: \(decodedData.time)")
            //print("The base is: \(decodedData.asset_id_base)")
            //print("The quote is: \(decodedData.asset_id_quote)")
            //**********************************
            return (lastPrice)
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        } //catch
    } //func parseJSON
    
} //struct CoinManager
