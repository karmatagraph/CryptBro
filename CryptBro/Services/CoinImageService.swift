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
    private let fileManager = LocalFileManager.instance
    private let folderName = "Coin_Images"
    private let imageName: String
    private var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
//            print("Retrieved image from file manager")
        } else {
            downloadCoinImage()
//            print("downloading image from file manager")
        }
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        //        print("------------------THIS IS THE URL OF THE COIN IMAGE", url)
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
        //            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion:NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImages in
                guard
                    let self = self,
                    let downloadedImage = returnedImages
                else { return }
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
    
}
