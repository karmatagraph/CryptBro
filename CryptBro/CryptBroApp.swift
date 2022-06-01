//
//  CryptBroApp.swift
//  CryptBro
//
//  Created by karma on 5/31/22.
//

import SwiftUI

@main
struct CryptBroApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
