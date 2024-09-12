//
//  TherapistList.swift
//  AITherapist
//
//  Created by Shirin-Yan on 12.09.2024.
//

import SwiftUI

struct TherapistList: View {
    @State var data: [Therapist]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 14) {
                ForEach(data) { data in
                    ChatlistItemView(data: data)
                }
            }
        }
    }
}
