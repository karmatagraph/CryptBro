//
//  PortfolioView.swift
//  CryptBro
//
//  Created by karma on 6/9/22.
//

import SwiftUI

struct PortfolioView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var checkMark: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    coinLogoList
                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                }
            }
            .navigationTitle("Portfolio")
            .toolbar() {
                ToolbarItem(placement: .navigationBarLeading){
                    XmarkButton(presentationMode: presentationMode)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                   trailingNavBarButton
                }
            }
        }
    }

}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
//            .preferredColorScheme(.dark)
            .environmentObject(dev.homeVM)
    }
}

extension PortfolioView {
    
    private var coinLogoList: some View {
        ScrollView(.horizontal,showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                selectedCoin = coin
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.green : .clear ,lineWidth: 1)
                        )
                }
            }
            .padding(2)
            .padding(.leading)
        }
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0.0)
        }
        return 0.0
    }
    
    private var portfolioInputSection: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current price \(selectedCoin?.symbol.uppercased() ?? ""):" )
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }
            Divider()
            HStack {
                Text("Amount Holding")
                Spacer()
                TextField("Ex: 1.4",text: $quantityText)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    .frame(width: UIScreen.main.bounds.width / 4)
            }
            Divider()
            HStack {
                Text("Current value: ")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .animation(.none)
        .padding()
        .font(.headline)
    }
    
    private var trailingNavBarButton: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .opacity(checkMark ? 1.0 : 0.0)
            Button {
                saveButtonPressed()
            } label: {
                Text("save".uppercased())
                    .font(.headline)
            }
            .opacity(
                (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0
                )

        }
        .font(.headline)
    }
    
    private func saveButtonPressed() {
        guard let coins = selectedCoin else { return }
        // save to portfolio
        
        // show the checkmark
        withAnimation(.easeIn) {
            checkMark = true
            removeSelectedCoin()
        }
        
        //hide the keyboard
        UIApplication.shared.endEditing()
        
        // hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut) {
                checkMark = false
            }
        }
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }
    
}
