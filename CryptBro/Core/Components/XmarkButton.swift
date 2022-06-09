//
//  XmarkButton.swift
//  CryptBro
//
//  Created by karma on 6/9/22.
//

import SwiftUI

struct XmarkButton: View {
    var presentationMode: Binding<PresentationMode>
    var body: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
        }
    }
}

//struct XmarkButton_Previews: PreviewProvider {
//    static var previews: some View {
//        XmarkButton(presentationMode: )
//    }
//}
