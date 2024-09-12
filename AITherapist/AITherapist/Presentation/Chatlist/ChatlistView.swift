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
            
            TherapistList(data: data)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                data = FirestoreManager.shared.getThreads()
            }.background(Color.white.ignoresSafeArea())
    }
}

#Preview {
    ChatlistView()
}


