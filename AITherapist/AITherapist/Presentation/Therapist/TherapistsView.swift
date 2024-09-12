//
//  TherapistsView.swift
//  AITherapist
//
//  Created by Shirin-Yan on 12.09.2024.
//

import SwiftUI

struct TherapistsView: View {
    @State var data: [Therapist] = FirestoreManager.shared.therapists
    
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
                FirestoreManager.shared.getTherapists { list in
                    data = list
                }
            }.background(Color.white.ignoresSafeArea())
    }
}

#Preview {
    TherapistsView()
}
