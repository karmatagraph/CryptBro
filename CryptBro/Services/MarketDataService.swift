//
//  MarketDataService.swift
//  CryptBro
//
//  Created by karma on 6/9/22.
//

import Foundation
import Combine

class MarketDataService {
    
    // this makes it a publisher
    @Published var marketData: MarketDataModel? = nil
    
    var marketDataSubscription: AnyCancellable?
    
    init() {
        getData()
    }
    
    private func getData() {
        marketDataSubscription = NetworkingManager.download(url: Endpoints.globals.url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion:NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedCoins in
                self?.marketData = returnedCoins.data
                self?.marketDataSubscription?.cancel()
            })
    }
}
