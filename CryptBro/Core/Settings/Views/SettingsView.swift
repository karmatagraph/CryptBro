//
//  SettingsView.swift
//  CryptBro
//
//  Created by karma on 6/14/22.
//

import SwiftUI

struct SettingsView: View {
    let defaultUrl = URL(string: "https://www.google.com")!
    let youtubeUrl = URL(string: "https://www.youtube.com")!
    let coffeeUrl = URL(string: "https://www.buymeacoffee.com")!
    let coingecko = URL(string: "https://www.coingecko.com")!
    let personal = URL(string: "https://www.instagram.com/mildcrash")!
    
    var body: some View {
        NavigationView{
            ZStack {
                //background
                Color.theme.background.ignoresSafeArea()
                
                // content
                List{
//                    Text("hell")
                    swiftfulthinkingSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    coinGeckoSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    developerSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    applicationSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                }
                .listStyle(GroupedListStyle())
                .navigationTitle("Settings")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Image(systemName: "xmark")
                            .font(.headline)
                            .onTapGesture {
                                
                            }
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

extension SettingsView {
    
    private var swiftfulthinkingSection: some View {
        Section(header: Text("Swiftful Thinking")) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was made by following @Swiftfulthinking on youtube, it uses MVVM architecture, Combine and Core Data")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.theme.accent)
            }
            .padding(.vertical)
            Link("Subscribe on youtube", destination: youtubeUrl)
            Link("support his coffee addiction ", destination: coffeeUrl)
            
        }
        .tint(.blue)
    }
    
    private var coinGeckoSection: some View {
        Section(header: Text("Coin Gecko")) {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .frame(height: 100)
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("The crypto currency data is retrieved from this api, which is coin gecko api")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.theme.accent)
            }
            .padding(.vertical)
            Link("Visit coin gecko", destination: coingecko)
        }
        .tint(.blue)
    }
    
    private var developerSection: some View {
        Section(header: Text("Header")) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100 ,height: 100)
//                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("develop using swift and the project benefits from multiple threads cuz we used background threads")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.theme.accent)
            }
            .padding(.vertical)
            Link("Visit profile", destination: personal)
        }
        .tint(.blue)
    }

    private var applicationSection: some View {
        Section(header: Text("Application")) {
            Link("Terms of Service", destination: defaultUrl)
            Link("Privacy Policy", destination: defaultUrl)
            Link("Company Website", destination: defaultUrl)
            Link("Learn more", destination: defaultUrl)
        }
        .tint(.blue)
    }
    
}
