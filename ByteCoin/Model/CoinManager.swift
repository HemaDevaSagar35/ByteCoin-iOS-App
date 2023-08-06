//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation


protocol CoinManagerDelegate{
    func didFindExchangeRate(_ exchangeData: CoinExchangeDataModel)
    func didFailedToFetch(error : Error)
}

struct CoinManager {
    
    var delegate : CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "APIKEY-DC998C21-82AF-4E5C-81A1-0DA7EB5321C4"
    // https://rest.coinapi.io/v1/exchangerate/BTC/USD/APIKEY-DC998C21-82AF-4E5C-81A1-0DA7EB5321C4
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func fetchValue(row: Int){
        let urlString = "\(baseURL)/\(currencyArray[row])/\(apiKey)"
        fetchJSON(urlString : urlString)
    }
    
    func fetchJSON(urlString: String){
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    self.delegate?.didFailedToFetch(error: error!)
                    return
                }
                if let safeData = data{
                    if let exchangeData = self.performDecoding(safeData){
                        self.delegate?.didFindExchangeRate(exchangeData)
                    }
                }
            }
            task.resume()
        }
        
    }
    
    func performDecoding(_ exchangeRate : Data) -> CoinExchangeDataModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinExchangeData.self, from: exchangeRate)

            let exchangeData = CoinExchangeDataModel(base: decodedData.asset_id_base, target: decodedData.asset_id_quote, rate: decodedData.rate)
            return exchangeData
        }catch{
            self.delegate?.didFailedToFetch(error: error)
            return nil
        }
    }
                  
    
}
