//
//  CoinDetailDataService.swift
//  CryptBro
//
//  Created by karma on 6/10/22.
//

import Foundation
import Combine

class CoinDetailDataService {
    
    // this makes it a publisher
    @Published var coinDetails: CoinDetailModel? = nil
    let coin: CoinModel
    
    var coinDetailSubscription: AnyCancellable?
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinDetails()
    }
    
    func getCoinDetails() {
        coinDetailSubscription = NetworkingManager.download(url: Endpoints.coinDetails(id: "\(coin.id)").url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion:NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedCoinDetails in
                self?.coinDetails = returnedCoinDetails
                self?.coinDetailSubscription?.cancel()
                print("---------------API CALLED-------------------")
            })
    }
    
}

