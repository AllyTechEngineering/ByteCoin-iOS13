//
//  CoinData.swift
//  ByteCoin
//
//  Created by Bobby Taylor on 3/1/23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation
/*
 Uses the Protocol Decodable
 */
struct CoinData: Decodable {
    let time: String
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
    
} //struct CoinData
