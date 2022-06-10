//
//  DetailScreen.swift
//  CryptBro
//
//  Created by karma on 6/10/22.
//

import SwiftUI

struct DetailLoadingView: View {
    @Binding var coin: CoinModel?
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailScreen(coin: coin)
            }
            
        }
    }
}

struct DetailScreen: View {
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        print("initing for detail view for \(coin.name)")
    }
    var body: some View {
        Text(coin.name)
    }
}

struct DetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailScreen(coin: dev.coin)
    }
}
