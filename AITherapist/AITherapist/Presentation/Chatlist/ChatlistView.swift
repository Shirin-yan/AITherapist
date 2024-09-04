//
//  ContentView.swift
//  AITherapist
//
//  Created by Shirin-Yan on 03.08.2024.
//

import SwiftUI

struct ChatlistView: View {
    @StateObject var vm = ChatlistVM()

    @State var showPurchase = false
    let m = FirestoreManager()

    var body: some View {
        VStack(spacing: 20) {
            Text(LocalizedStringKey("find_your_therapist"))
                .font(.inter(20, fontWeight: .medium))
                .foregroundColor(.textColor)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 20)

            ScrollView {
                LazyVStack {
                    ChatlistItemView()
                    ChatlistItemView()
                    ChatlistItemView()
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.accentColor.opacity(0.5).ignoresSafeArea())
            .onAppear {
                showPurchase.toggle()
            }.fullScreenCover(isPresented: $showPurchase, content: {
                PurchaseView(isPresented: $showPurchase)
            })
    }
}

#Preview {
    ChatlistView()
}


