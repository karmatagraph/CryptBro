//
//  CoinDataService.swift
//  CryptBro
//
//  Created by karma on 6/2/22.
//

import Foundation
import Combine

class CoinDataService {
    
    // this makes it a publisher
    @Published var allCoins: [CoinModel] = []
    
    var coinSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    func getCoins() {
        coinSubscription = NetworkingManager.download(url: Endpoints.market.url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion:NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
                print("---------------API CALLED-------------------")
            })
    }
    
}
