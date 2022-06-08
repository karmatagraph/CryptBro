//
//  CoinImageViewModel.swift
//  CryptBro
//
//  Created by karma on 6/8/22.
//

import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let coin: CoinModel
    private let dataService: CoinImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.addSubscriber()
        self.isLoading = true
    }
    
    private func getImage() {
        
    }
    
    private func addSubscriber() {
        dataService.$image
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
//                self?.isLoading = false
//                print(returnedImage?.description,"--------------this is hte image in vm")
            }
            .store(in: &cancellables)

    }
}
