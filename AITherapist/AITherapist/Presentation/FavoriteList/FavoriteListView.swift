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
            if !data.isEmpty {
                TherapistList(data: data)
            } else {
                VStack(spacing: 16) {
                    Image(systemName: "tray.full")
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                        .foregroundColor(.textColor)

                    Text("No favorited therpaists")
                        .foregroundColor(.textColor)
                        .font(.inter(20, fontWeight: .medium))
                        .frame(maxWidth: .infinity, alignment: .center)
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white.ignoresSafeArea())
            .onAppear {
                data = FirestoreManager.shared.getFavTherapists()
            }
    }
}

#Preview {
    FavoriteListView()
}
