//
//  PurchaseItemView.swift
//  AITherapist
//
//  Created by Shirin-Yan on 07.08.2024.
//

import SwiftUI

struct PurchaseItemView: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("lifetime")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.inter(14, fontWeight: .regular))
                .foregroundColor(.textColor)
            
            Text("$120 for life")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.inter(18, fontWeight: .medium))
                .foregroundColor(.textColor)
                .padding(.bottom, 10)
            
            Text("10000 Chat Messages per month for Life")
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.inter(14, fontWeight: .medium))
                .foregroundColor(.textColor)
        }.frame(maxWidth: .infinity)
            .padding()
            .background(Color.cardBgColor)
            .cornerRadius(12)
//            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.textColor, lineWidth: 1))

    }
}

#Preview {
    PurchaseItemView()
}
