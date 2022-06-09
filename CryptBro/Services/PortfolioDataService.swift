//
//  PortfolioDataService.swift
//  CryptBro
//
//  Created by karma on 6/9/22.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    @Published var savedEntities: [PortfolioEntity] = []
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("error loading core data-----", error.localizedDescription)
            }
            self.getPortfolio()
        }
    }
    
    // MARK: - Public Methods
    // check if coin is already in portfolio
    func updatePortfolio(coin: CoinModel, amount: Double) {
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    
    // MARK: - Private Methods
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
            
        } catch let error  {
            print("error fetching portfolio entities------", error.localizedDescription)
        }
    }
    
    private func add(coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
            getPortfolio()
        } catch let error {
            print("error saving data", error.localizedDescription)
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
    
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
}
