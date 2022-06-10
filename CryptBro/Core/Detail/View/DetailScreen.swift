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
    @StateObject private var vm: DetailViewModel
    
    init(coin: CoinModel) {
        self._vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("initing for detail view for \(coin.name)")
    }
    var body: some View {
        Text("hello")
    }
}

struct DetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailScreen(coin: dev.coin)
    }
}
