//
//  FavoriteListView.swift
//  AITherapist
//
//  Created by Shirin-Yan on 04.09.2024.
//

import SwiftUI

struct FavoriteListView: View {
    @State var data: [Therapist] = []
    
    var body: some View {
        VStack(spacing: 20) {
            Text(LocalizedStringKey("Favorited Therapists"))
                .font(.inter(20, fontWeight: .medium))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 20)

            ScrollView {
                LazyVStack {
                    ForEach(data) { data in
                        ChatlistItemView(data: data, isFavorited: true)
                    }
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.accentColor.opacity(0.5).ignoresSafeArea())
            .onAppear {
                data = FirestoreManager.shared.getFavTherapists()
            }
    }
}

#Preview {
    FavoriteListView()
}
