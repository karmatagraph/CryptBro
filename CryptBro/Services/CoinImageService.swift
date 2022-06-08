//
//  CoinImageService.swift
//  CryptBro
//
//  Created by karma on 6/8/22.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage() {
        guard let url = URL(string: coin.image) else { return }
//        print("------------------THIS IS THE URL OF THE COIN IMAGE", url)
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
//            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion:NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImages in
                self?.image = returnedImages
                self?.imageSubscription?.cancel()
            })
    }
    
}
