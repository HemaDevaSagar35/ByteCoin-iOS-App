//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
       
    @IBOutlet weak var targetValue: UILabel!
    @IBOutlet weak var targetUnit: UILabel!
    @IBOutlet weak var pickerDataField: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerDataField.dataSource = self
        pickerDataField.delegate = self
        coinManager.delegate = self
        
    }
}


//MARK: - PickerViewDataSource
extension ViewController : UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
}


//MARK: - PickerViewDelegate
extension ViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.fetchValue(row: row)

    }
}


//MARK: - CoinManagerDelegate
extension ViewController : CoinManagerDelegate{
    
    func didFindExchangeRate(_ exchangeData: CoinExchangeDataModel) {
        DispatchQueue.main.async {
            self.targetUnit.text = exchangeData.target
            self.targetValue.text = exchangeData.rateString
        }
    }
    
    func didFailedToFetch(error: Error) {
        print(error)
    }
    
}

