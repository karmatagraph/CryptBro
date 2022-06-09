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
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscriber()
    }
    
    func addSubscriber() {
        // Updates all coins
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] filteredCoins in
                self?.allCoins = filteredCoins
            }
            .store(in: &cancellables)
        
        // Updates the portfolio coins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinstoPortfolio)
            .sink { [weak self] returnedCoins in
                self?.portfolioCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // Listen for Market Data and updates it
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStat in
                guard let self = self else { return }
                self.statistics = returnedStat
            }
            .store(in: &cancellables)
        
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    private func mapAllCoinstoPortfolio(coinModels: [CoinModel], portfolioEntities: [PortfolioEntity]) -> [CoinModel] {
        coinModels.compactMap { currentCoin -> CoinModel? in
            guard let entity = portfolioEntities.first(where: { $0.coinID == currentCoin.id }) else { return nil}
            return currentCoin.updateHoldings(amount: entity.amount)
        }
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
    
    private func mapGlobalMarketData(data: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        guard let data = data else { return stats}
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap,percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24H Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominace)
        let portfolioValue =
        portfolioCoins
            .map({$0.currentHoldingsValue})
            .reduce(0,+)
        let previousValue = portfolioCoins
            .map { coin -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = (coin.priceChangePercentage24H) / 100
                let previousValue = currentValue / (1 + percentChange)
                return previousValue
            }
            .reduce(0, +)
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        let portfolio = StatisticModel(
            title: "Portfolio Value",
            value: portfolioValue.asCurrencyWith2Decimals(),
            percentageChange: percentageChange)
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
