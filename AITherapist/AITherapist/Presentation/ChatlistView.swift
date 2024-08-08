//
//  ContentView.swift
//  AITherapist
//
//  Created by Shirin-Yan on 03.08.2024.
//

import SwiftUI

struct ChatlistView: View {
    @State var showPurchase = false
    
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)

            Text("Hello, world!")
            
        }.onAppear {
            showPurchase.toggle()
        }.fullScreenCover(isPresented: $showPurchase, content: {
            PurchaseView(isPresented: $showPurchase)
        })
    }
}

#Preview {
    ChatlistView()
}
