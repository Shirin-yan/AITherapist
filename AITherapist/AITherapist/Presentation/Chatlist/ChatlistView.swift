//
//  ContentView.swift
//  AITherapist
//
//  Created by Shirin-Yan on 03.08.2024.
//

import SwiftUI

struct ChatlistView: View {
    @State var data: [Therapist] = FirestoreManager.shared.getThreads()
    
    var body: some View {
        VStack(spacing: 20) {
            Text(LocalizedStringKey("find_your_therapist"))
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

                    Text("No chats")
                        .foregroundColor(.textColor)
                        .font(.inter(20, fontWeight: .medium))
                        .frame(maxWidth: .infinity, alignment: .center)
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                data = FirestoreManager.shared.getThreads()
            }.background(Color.white.ignoresSafeArea())
    }
}

#Preview {
    ChatlistView()
}


