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

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "E9C4B782-FD42-4DBE-A9C9-27184537E3BC"
    
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    /*
     This is the test API call for BTC to USD
     https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=E9C4B782-FD42-4DBE-A9C9-27184537E3BC
     */
    func getCoinPrice ( for currency: String){
        fetchCurrencyType(currencyType: currency)
       print(currency)
    } //func getCoinPrice
    
    func fetchCurrencyType (currencyType: String){
        let urlString = "\(baseURL)/\(currencyType)?apikey=\(apiKey)"
        print(urlString)
        performRequest(urlString: urlString)
    } //func fetchCurrencyType
    
    // Step 1: create a URL
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            // Step 2: create a URLSession
            let session = URLSession(configuration: .default)
            // Step 3: Give URLSession a Task
            // This is a Closure - look for the "in"
            let task = session.dataTask(with: url) { (data, response, error ) in
                if error != nil {
                    print(error!)
                    return
                } //if error
                if let safeData = data {
                    self.parseJSON(coinData: safeData)
                    let dataString = String(data: safeData, encoding: .utf8)
                    print(dataString ?? "error")
                } // if let safeData
            } // let task = session
            // Step 4: Start the task
            task.resume()
        } // if let url = URL
    } //func performRequest

    func parseJSON(coinData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            // the following is just debug code
            let decodedDataString = String(format: "%0.2f", decodedData.rate)
            print("The rate is: \(decodedDataString)")
            print("The Time is: \(decodedData.time)")
            print("The base is: \(decodedData.asset_id_base)")
            print("The quote is: \(decodedData.asset_id_quote)")
            //**********************************
        } catch {
            print(error)
        }
    } //func parseJSON
    
} //struct CoinManager
