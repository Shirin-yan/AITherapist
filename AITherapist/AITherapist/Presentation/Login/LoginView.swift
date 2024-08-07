//
//  LoginView.swift
//  AITherapist
//
//  Created by Shirin-Yan on 07.08.2024.
//

import SwiftUI

struct LoginView: View {
    @StateObject var vm = LoginVM()
    
    var body: some View {
        VStack(spacing: 20){
            Spacer()
            
            Text(LocalizedStringKey("welcome"))
                .font(.inter(30, fontWeight: .medium))
                .foregroundColor(.textColor)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)

            Text(LocalizedStringKey("login_to_chat"))
                .font(.inter(22, fontWeight: .medium))
                .foregroundColor(.textColor)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)

            Image("login")
                .resizable()
                .scaledToFit()

            Spacer()

            Button {
                
            } label: {
                HStack {
                    Image("apple")
                        .resizable()
                        .frame(width: 34, height: 34, alignment: .center)
                    
                    Text(LocalizedStringKey("sign_in_apple"))
                        .foregroundColor(.textColor)
                        .font(.inter(22 , fontWeight: .medium))
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                } .padding(20)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(12)
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.textColor, lineWidth: 2))
                    .padding(.horizontal, 20)
            }
                Button {
                    
                } label: {
                    HStack {
                        Image("google")
                            .resizable()
                            .frame(width: 34, height: 34, alignment: .center)
                        
                        Text(LocalizedStringKey("sign_in_google"))
                            .foregroundColor(.textColor)
                            .font(.inter(22 , fontWeight: .medium))
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                    } .padding(20)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(12)
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.textColor, lineWidth: 2))
                        .padding(.horizontal, 20)
                    
                    
                }.padding(.bottom, 60)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 20)
            .background(Color.accentColor.ignoresSafeArea())
    }
}

#Preview {
    LoginView()
}
