//
//  CircleButtonView.swift
//  CryptBro
//
//  Created by karma on 5/31/22.
//

import SwiftUI

struct CircleButtonView: View {
    let iconName: String
    @State var isShow = true
    var body: some View {
        ZStack {
          //  button
            Image(systemName: iconName)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
                .frame(width: 50, height: 50)
                .background(
                Circle()
                    .foregroundColor(Color.theme.background)
                )
                .shadow(
                    color: Color.theme.accent.opacity(0.25),
                    radius: 10,
                    x: 0,
                    y: 0)
                .padding()
        }
    }
    
    @ViewBuilder
    var button : some  View {
        if isShow {
            Rectangle().foregroundColor(Color.red)
        }
    }
    
    @ViewBuilder
    func create(isShow: Bool) -> some View {
        if isShow {
            Rectangle().foregroundColor(Color.red)
        }
        
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleButtonView(iconName: "info")
                .previewLayout(.sizeThatFits)
            CircleButtonView(iconName: "plus")
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
        
    }
    
}
