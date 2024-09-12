//
//  OnboardingView.swift
//  AITherapist
//
//  Created by Shirin-Yan on 07.08.2024.
//

import SwiftUI

struct OnboardingView: View {
    
    @State var selectedInd = 0

    
    var body: some View {
        VStack(spacing: 20) {
            Text("AI Therapist")
                .font(.inter(42, fontWeight: .regular))
                .foregroundColor(.textColor)
            
            TabView(selection: $selectedInd, content:  {
                
                OnboardingItemView(img: "onboard-1", title: "onboard_1")
                    .tag(0)
                
                OnboardingItemView(img: "onboard-2", title: "onboard_2")
                    .tag(1)
                
                OnboardingItemView(img: "onboard-3", title: "onboard_3")
                    .tag(2)
            }).tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
            Button {
                if selectedInd > 1 {
                    skipOnboarding()
                } else {
                    withAnimation {
                        selectedInd += 1
                    }
                }
            } label: {
                Text("continue".uppercased())
                    .foregroundColor(.textColor)
                    .font(.inter(20, fontWeight: .regular))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.primaryColor)
                    .cornerRadius(10)
            }
            
            Button {
                skipOnboarding()
            } label: {
                Text("skip".uppercased())
                    .foregroundColor(.textColor)
                    .font(.inter(20, fontWeight: .regular))
            }
        }.padding(.vertical, 20)
    }
    
    func skipOnboarding(){
        Defaults.onboardingShown = true
    }
}

#Preview {
    OnboardingView()
}
