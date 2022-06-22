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
    @State private var showDescription: Bool = false
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
                ChartView(coin: vm.coin)
                    .frame(height: 200)
                    .padding(.top, 10)
                overviewTitle
                Divider()
                coinDescription
                overviewGrid
                additionalTitle
                Divider()
                additionalGrid
                websiteSection
            }
            .padding()
        }
        .background(Color.theme.background.ignoresSafeArea())
        .navigationTitle(vm.coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
//                CoinImageView(coin: vm.coin)
                navbarTrailingItems
            }
        }
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
            .padding(10)
    }
    
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(10)
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
        .padding()
        .background(.thinMaterial)
        .cornerRadius(10)
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
        .padding()
        .background(.thinMaterial)
        .cornerRadius(10)
    }
    
    private var navbarTrailingItems: some View {
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
            .foregroundColor(.theme.secondaryText)
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }
    
    private var coinDescription: some View {
        ZStack {
            if let coinDescription = vm.coinDescription, !coinDescription.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .lineLimit(showDescription ? nil : 3)
                        .font(.callout)
                        .foregroundColor(.theme.secondaryText)
                    Button {
                        withAnimation(.easeIn) {
                            showDescription.toggle()
                        }
                    } label: {
                        Text(showDescription ? "Less" :"Read More...")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical, 4)
                    }
                    .tint(.blue)
                    

                }
                
            }
        }
        .padding()
        .background(.thinMaterial)
        .cornerRadius(10)
    }
    
    private var websiteSection: some View {
        VStack(alignment: .leading, spacing: 10){
            if let websiteString = vm.websiteUrl,
               let url = URL(string: websiteString){
                Link("Website",destination: url)
            }
            if let redditString = vm.redditUrl,
               let url = URL(string: redditString) {
                Link("Reddit", destination: url)
            }
        }
        .font(.headline)
        .frame(maxWidth: .infinity, alignment: .leading)
        .tint(.blue)
    }
        
    
}
