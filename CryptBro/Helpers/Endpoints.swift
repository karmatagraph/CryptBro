//
//  Endpoints.swift
//  CryptBro
//
//  Created by karma on 6/2/22.
//

import Foundation

struct API {
    static let url = "https://api.coingecko.com/api/v3/"
    //    markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h
}

protocol Endpoint {
    var path: String { get }
    var url: URL { get }
}

enum Endpoints {
    case market
    case globals
    case coinDetails(id: String?)
}

extension Endpoints: Endpoint {
    
    var path: String{
        switch self {
        case .market:
            return "coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h"
        case .globals:
            return "global"
        case .coinDetails(let id):
            return "coins/\(id == nil ? "" : "\(id ?? "")")?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false"
        }
    
    }
    
    var url: URL {
        return URL(string: "\(API.url)\(path)")!
    }
    
}
