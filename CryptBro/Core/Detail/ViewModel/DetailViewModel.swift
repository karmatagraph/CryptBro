//
//  DetailViewModel.swift
//  CryptBro
//
//  Created by karma on 6/10/22.
//

import Foundation
import Combine

class DetailViewModel:ObservableObject {
//    @Published var
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        coinDetailService = CoinDetailDataService(coin: coin)
        addSubscriber()
    }
    
    private func addSubscriber() {
        coinDetailService.$coinDetails
            .sink { returnedCoinDetails in
                print("success ")
            }
            .store(in: &cancellables)
    }
    
    
}
