//
//  CoinExchangeData.swift
//  ByteCoin
//
//  Created by user236150 on 8/5/23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct CoinExchangeData: Codable{
    
    let rate : Double
    let asset_id_base : String
    let asset_id_quote : String
}
