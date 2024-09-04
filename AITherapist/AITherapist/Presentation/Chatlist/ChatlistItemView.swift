//
//  ChatlistItemView.swift
//  AITherapist
//
//  Created by Shirin-Yan on 08.08.2024.
//

import SwiftUI

struct ChatlistItemView: View {
    var data: Therapist
    @State var isFavorited: Bool
    
    init(data: Therapist, isFavorited: Bool = false) {
        self.data = data
        self.isFavorited = Defaults.favoritedTherapists.contains(data.id)
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                AsyncImage(url: URL(string: data.avatar)) { _ in
                    
                } placeholder: {
                    Image(systemName: "person.fill")
                        .imageScale(.large)
                }.foregroundColor(.textColor)
                    .frame(width: 70, height: 70, alignment: .center)
                    .background(Color.accentColor)
                    .cornerRadius(40)
                
                VStack {
                    HStack {
                        Text(data.name)
                            .foregroundColor(.textColor)
                            .font(.inter(20, fontWeight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Button {
                            if Defaults.favoritedTherapists.contains(data.id) {
                                Defaults.favoritedTherapists.removeAll(where: {$0 == data.id})
                                isFavorited = false
                            } else {
                                Defaults.favoritedTherapists.append(data.id)
                                isFavorited = true
                            }
                        } label: {
                            Image(systemName: isFavorited ? "heart.fill" : "heart")
                                .foregroundColor(.red)
                                .imageScale(.large)
                                .frame(width: 40, height: 40, alignment: .center)
                        }
                    }
                    
                    Text(data.about)
                        .foregroundColor(.textColor)
                        .multilineTextAlignment(.leading)
                        .font(.inter(12, fontWeight: .medium))
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, alignment: .leading)

                }
            }
            
            HStack {
                Spacer()
                
                NavigationLink {
                    ChatView(vm: ChatVM(threadId: data.id))
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
