//
//  OnboardingItemView.swift
//  AITherapist
//
//  Created by Shirin-Yan on 07.08.2024.
//

import SwiftUI

struct OnboardingItemView: View {
    
    var img = ""
    var title = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Image(img)
                .resizable()
                .scaledToFit()
            
            Text(LocalizedStringKey(title))
                .font(.inter(28, fontWeight: .regular))
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .foregroundColor(.textColor)
            
        }.padding(50)

    }
}

#Preview {
    OnboardingItemView()
}
