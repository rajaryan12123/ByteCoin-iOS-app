// Bytecoin
//
//  Created by Raj Aryan on 15/02/2022.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDataSource {
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
        
    }
}

//MARK: - UIPickerViewDelegate

extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.getCoinPrice(for: coinManager.currencyArray[row])
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

//MARK: - CoinManagerDelegate

extension ViewController: CoinManagerDelegate {
    
    func didUpdateCoinModel(_ coinManager: CoinManager,coinM: coinModel) {
        //        print(coinM.rate)
        //        print(coinM.asset_id_base)
        DispatchQueue.main.async {
            self.bitcoinLabel.text = coinM.rateString
            self.currencyLabel.text = coinM.asset_id_base
        }
        
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}
