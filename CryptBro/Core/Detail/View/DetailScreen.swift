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
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    private let spacing: CGFloat = 30
    
    init(coin: CoinModel) {
        self._vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("initing for detail view for \(coin.name)")
    }
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("about")
                    .frame(height: 150)
                overviewTitle
                Divider()
                overviewGrid
                additionalTitle
                Divider()
                additionalGrid
            }
            .padding()
        }
        .navigationTitle(vm.coin.name)
    }
}

struct DetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            DetailScreen(coin: dev.coin)
        }
    }
}

extension DetailScreen {
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overviewGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(vm.overviewStatistics){stat in
                    StatisticView(stat: stat)
                }     
            })
    }
    
    private var additionalGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(vm.additionalStatistics){ stat in
                    StatisticView(stat: stat)
                }
            })
    }
    
}
