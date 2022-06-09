//
//  HomeViewModel.swift
//  CryptBro
//
//  Created by karma on 6/1/22.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    // fake data
    /*
        StatisticModel(title: "title", value: "13.4 Tr", percentageChange: 13.4),
        StatisticModel(title: "title", value: "13.4 Tr"),
        StatisticModel(title: "title", value: "13.4 Tr"),
        StatisticModel(title: "title", value: "13.4 Tr", percentageChange: -12.4)
    */
    
    @Published var statistics: [StatisticModel] = []
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    @Published var marketData: MarketDataModel? = nil
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscriber()
    }
    
    func addSubscriber() {
//        dataService.$allCoins
//            .sink { [weak self] returnedCoins in
//                self?.allCoins = returnedCoins
//            }
//            .store(in: &cancellables)
        
        
        // Updates all coins
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] filteredCoins in
                self?.allCoins = filteredCoins
            }
            .store(in: &cancellables)
        
        // Listen for Market Data and updates it
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStat in
                guard let self = self else { return }
                self.statistics = returnedStat
            }
            .store(in: &cancellables)
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel]{
        guard !text.isEmpty else {
            return coins
        }
        let lowercaseText = text.lowercased()
        return coins.filter { coin in
            return
            coin.name.lowercased().contains(lowercaseText) ||
            coin.symbol.lowercased().contains(lowercaseText) ||
            coin.id.lowercased().contains(lowercaseText)
        }
    }
    
    private func mapGlobalMarketData(data: MarketDataModel?) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        guard let data = data else { return stats}
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap,percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24H Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominace)
        let portfolio = StatisticModel(title: "Portfolio Value", value: "$0.00", percentageChange: 0.0)
        stats.append(contentsOf:[
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        return stats
    }
    
//    func addSearchTextSubscriber() {
//        $searchText
//            .debounce(for: , scheduler: <#T##Scheduler#>)
//    }
    
    
}
