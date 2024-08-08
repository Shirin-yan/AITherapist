//
//  ChatlistItemView.swift
//  AITherapist
//
//  Created by Shirin-Yan on 08.08.2024.
//

import SwiftUI

struct ChatlistItemView: View {

    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Image(systemName: "person.fill")
                    .foregroundColor(.textColor)
                    .imageScale(.large)
                    .frame(width: 70, height: 70, alignment: .center)
                    .background(Color.accentColor)
                    .cornerRadius(40)
                
                VStack {
                    HStack {
                        Text("Emily Williams")
                            .foregroundColor(.textColor)
                            .font(.inter(20, fontWeight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Button {
                            
                        } label: {
                            Image(systemName: "heart")
                                .foregroundColor(.red)
                                .imageScale(.large)
                                .frame(width: 40, height: 40, alignment: .center)
                        }
                    }
                    
                    Text("Emily is a dedicated therapist specializing in cognitive behavioral therapy.")
                        .foregroundColor(.textColor)
                        .font(.inter(12, fontWeight: .medium))
                        .lineLimit(2)
                    
                }
            }
            
            HStack {
                Spacer()
                
                NavigationLink {
                    ChatView()
                } label: {
                    Text(LocalizedStringKey("chat_now"))
                        .foregroundColor(.textColor)
                        .font(.inter(12, fontWeight: .regular))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 6)
                        .background(Color.accentColor)
                        .cornerRadius(20)
                    
                }
            }
        }.padding()
            .background(Color.white.opacity(0.5))
            .cornerRadius(12)
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.blueColor.opacity(0.5), lineWidth: 1))
            .padding(.horizontal, 20)
    }
}

#Preview {
    ChatlistItemView()
}
