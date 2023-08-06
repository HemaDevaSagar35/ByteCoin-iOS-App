//
//  PickerDataModel.swift
//  ByteCoin
//
//  Created by user236150 on 8/5/23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation


struct CoinExchangeDataModel{
    let base : String
    let target : String
    let rate: Double
    
    var rateString : String{
        return String(format: "%.2f", rate)
    }
    
}
