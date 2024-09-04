//
//  ContentView.swift
//  AITherapist
//
//  Created by Shirin-Yan on 03.08.2024.
//

import SwiftUI

struct ChatlistView: View {
    @StateObject var vm = ChatlistVM()

    let m = FirestoreManager()

    var body: some View {
        VStack(spacing: 20) {
            Text(LocalizedStringKey("find_your_therapist"))
                .font(.inter(20, fontWeight: .medium))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 20)

            ScrollView {
                LazyVStack {
                    ForEach(vm.data) { data in
                        ChatlistItemView(data: data)
                    }
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.accentColor.opacity(0.5).ignoresSafeArea())
            .fullScreenCover(isPresented: $vm.showPurchase, content: {
                PurchaseView(isPresented: $vm.showPurchase)
            })
    }
}

#Preview {
    ChatlistView()
}


