// Bytecoin
//
//  Created by Raj Aryan on 15/02/2022.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCoinModel(_ coinManager: CoinManager,coinM: coinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let apiKey = "YOUR_API_KEY_HERE"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        let url = baseURL + "\(currency)?apikey=(key)"
        performRequest(with: url)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {
                (data,response,error) in
                if(error != nil) {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
//         Step 1           let dataString = String(data: safeData, encoding: .utf8)
//                    print(dataString!)   gets us entire data that we get by the url but we do not want entire data so we use parsing
//         Step 2        self.parseJson(coinData: safeData)
                    
//        Step 3 Now we have the safe data -> we have to pass this to parseJson method to get the required information -> then use
//               delegate design pattern to pass this data to view controller
                    
                    if let coin = self.parseJson(coinData: safeData) {
                        self.delegate?.didUpdateCoinModel(self,coinM: coin)
                    }
                
                }
                
            }
            task.resume()
        }
    }
    
    func parseJson(coinData: Data) -> coinModel?{
        let decoder = JSONDecoder()
        do {
             let decodedData = try decoder.decode(CoinData.self,from: coinData)
            let coinModel1 = coinModel(rate: decodedData.rate, asset_id_base: decodedData.asset_id_quote)
            return coinModel1
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
}
