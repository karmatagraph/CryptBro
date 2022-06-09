//
//  MarketDataModel.swift
//  CryptBro
//
//  Created by karma on 6/9/22.
//

import Foundation

// JSON Reference for Market data
/*
 
 URL: https://api.coingecko.com/api/v3/global

 
 {
   "data": {
     "active_cryptocurrencies": 13399,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 637,
     "total_market_cap": {
       "btc": 42797775.501718834,
       "eth": 720263322.8922105,
       "ltc": 21066745731.29065,
       "bch": 7339812740.193875,
       "bnb": 4490192340.292953,
       "eos": 1032394139701.7355,
       "xrp": 3229757505889.3955,
       "xlm": 9263110777445.791,
       "link": 150115993173.75928,
       "dot": 143035015591.01755,
       "yfi": 174479857.52164802,
       "usd": 1294016722640.4036,
       "aed": 4753052823930.472,
       "ars": 157138427693465.84,
       "aud": 1803595331949.3015,
       "bdt": 120359646303503.61,
       "bhd": 487844304435.4323,
       "bmd": 1294016722640.4036,
       "brl": 6340681940937.952,
       "cad": 1625589097566.167,
       "chf": 1265905503357.7603,
       "clp": 1063358241829750,
       "cny": 8653866234329.964,
       "czk": 29807547098366.098,
       "dkk": 8974629687571.51,
       "eur": 1206576130641.4226,
       "gbp": 1032207377265.6266,
       "hkd": 10155766743462.557,
       "huf": 477570423727575.7,
       "idr": 18832731176291640,
       "ils": 4303990200672.5425,
       "inr": 100608955192371.16,
       "jpy": 173693276646575.94,
       "krw": 1628495398306428,
       "kwd": 396551424653.151,
       "lkr": 464218976578180.7,
       "mmk": 2397557187120948.5,
       "mxn": 25337080352309.156,
       "myr": 5685909479281.931,
       "ngn": 537386428254681.3,
       "nok": 12264594739948.262,
       "nzd": 2007893398103.046,
       "php": 68444427804635.625,
       "pkr": 259309434468305.12,
       "pln": 5535426980589.35,
       "rub": 77673355070506.97,
       "sar": 4854297986326.572,
       "sek": 12720346135645.47,
       "sgd": 1781660454483.8264,
       "thb": 44682397432772.914,
       "try": 22242982847138.113,
       "twd": 38267697735300.08,
       "uah": 38231300926942.36,
       "vef": 129569894437.9833,
       "vnd": 30009665868254708,
       "zar": 19797634155779.29,
       "xdr": 939043349302.4087,
       "xag": 58615127246.11138,
       "xau": 697927919.3561023,
       "bits": 42797775501718.836,
       "sats": 4279777550171883.5
     },
     "total_volume": {
       "btc": 2296712.616655541,
       "eth": 38652426.24431138,
       "ltc": 1130532139.7133431,
       "bch": 393885904.7385612,
       "bnb": 240963023.8549833,
       "eos": 55402707692.57601,
       "xrp": 173322672161.22473,
       "xlm": 497098345477.86804,
       "link": 8055869526.912756,
       "dot": 7675873829.428786,
       "yfi": 9363339.225566436,
       "usd": 69442500181.62997,
       "aed": 255069247417.14536,
       "ars": 8432723551963.653,
       "aud": 96788678983.155,
       "bdt": 6459016034381.349,
       "bhd": 26179822568.47451,
       "bmd": 69442500181.62997,
       "brl": 340268250889.98553,
       "cad": 87236099215.6699,
       "chf": 67933931307.684074,
       "clp": 57064374524254.34,
       "cny": 464403664214.66864,
       "czk": 1599601116876.3254,
       "dkk": 481617210044.6913,
       "eur": 64750062116.85664,
       "gbp": 55392685217.38191,
       "hkd": 545002102050.4779,
       "huf": 25628481963334.863,
       "idr": 1010645314893388,
       "ils": 230970616579.11267,
       "inr": 5399109043169.094,
       "jpy": 9321127914379.82,
       "krw": 87392063807280.16,
       "kwd": 21280654180.66047,
       "lkr": 24911985912800.8,
       "mmk": 128663225512566.69,
       "mxn": 1359696653206.3464,
       "myr": 305130345798.082,
       "ngn": 28838465909108.19,
       "nok": 658170877976.475,
       "nzd": 107752191469.33055,
       "php": 3673022231549.456,
       "pkr": 13915658998147.018,
       "pln": 297054808009.4597,
       "rub": 4168286142844.8403,
       "sar": 260502498073.85583,
       "sek": 682628457097.9438,
       "sgd": 95611559162.57631,
       "thb": 2397849531271.671,
       "try": 1193654079872.0532,
       "twd": 2053609169371.3044,
       "uah": 2051655960168.695,
       "vef": 6953277543.186592,
       "vnd": 1610447678956343.5,
       "zar": 1062426156791.3228,
       "xdr": 50393102974.30531,
       "xag": 3145539708.427306,
       "xau": 37453812.47296216,
       "bits": 2296712616655.541,
       "sats": 229671261665554.12
     },
     "market_cap_percentage": {
       "btc": 44.540705157057566,
       "eth": 16.821920112673087,
       "usdt": 5.600396367327209,
       "usdc": 4.157727750381646,
       "bnb": 3.6399928520529437,
       "ada": 1.6698998318566007,
       "xrp": 1.4986212439118025,
       "busd": 1.3897760512244646,
       "sol": 1.0310750288111485,
       "doge": 0.8181859471250266
     },
     "market_cap_change_percentage_24h_usd": -1.823136498178898,
     "updated_at": 1654745920
   }
 }
 
 */

// MARK: - Response model
struct GlobalData: Codable {
    let data: MarketDataModel?
}

// MARK: - MarketDataModel
struct MarketDataModel: Codable {
//    let activeCryptocurrencies,  ongoingIcos, endedIcos: Int?
//    let markets: Int?
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]?
    let marketCapChangePercentage24HUsd: Double?
//    let updatedAt: Int?
    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
//        if let item = totalMarketCap?.first(where: { key, value in
//            return key == "usd"
//        }) {
//            return "\(item.value)"
//        }
        
        if let item = totalMarketCap?.first(where: {$0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volume: String {
        if let item = totalVolume?.first(where: {$0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominace: String {
        if let item = marketCapPercentage?.first(where: {$0.key == "btc"}) {
            return item.value.asPercentString()
        }
        return ""
    }
}

