//
//  LaunchView.swift
//  CryptBro
//
//  Created by karma on 6/22/22.
//

import SwiftUI

struct LaunchView: View {
    @State private var loadingText: [String] = "Loading...".map({String($0)})
    @State private var showLoading: Bool = false
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    @Binding var showLaunchView: Bool
    
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.launch.background
                .ignoresSafeArea()
            Image("logo-transparent")
                .resizable()
                .frame(width: 100, height: 100)
            ZStack {
                if showLoading {
                    HStack(spacing:0) {
                        ForEach(loadingText.indices) {index in
                            Text(loadingText[index])
                                .font(.headline)
                                .foregroundColor(.launch.accent)
                                .fontWeight(.heavy)
                                .offset(y: counter == index ? -10 : 0)
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeIn))
                }
            }
            .offset(y:70)
            
        }
        .onAppear {
            showLoading.toggle()
        }
        .onReceive(timer) { _ in
            withAnimation(.spring()) {
                let last = loadingText.count - 1
                if counter == last {
                    counter = 0
                    loops += 1
                    if loops >= 2 {
                        showLaunchView = false
                    }
                } else {
                    counter += 1
                }
            }
        }
        
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunchView: .constant(true))
    }
}