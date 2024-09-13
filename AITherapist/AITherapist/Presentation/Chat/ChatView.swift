//
//  ChatView.swift
//  AITherapist
//
//  Created by Shirin-Yan on 08.08.2024.
//

import SwiftUI

struct ChatView: View {
    @StateObject var vm: ChatVM
    @State private var message = ""
    @State private var showSafari = false
    
    var body: some View {
        VStack {
            ScrollView{
                LazyVStack(spacing: 10) {
                    ForEach(vm.data.enumeratedArray(), id: \.offset) { ind, i in
                        VStack {
                            TextMsgItem(data: i.text, isOwn: i.isSenderMe)
                        }.scaleEffect(x: 1, y: -1)
                    }
                }.padding(.horizontal, 20)
            }.scaleEffect(x: 1, y: -1)
                .scrollDismissesKeyboard(.interactively)
                .padding(.vertical, 10)
            HStack(alignment: .bottom) {
                TextField(LocalizedStringKey("enter_message"), text: $message, axis: .vertical)
                    .textFieldStyle(.plain)
                    .lineLimit(10, reservesSpace: false)
                    .padding(14)
                    .frame(minHeight: 60)
                
                Button {
                    let canSend = vm.sendMsg(data: message)
                    if canSend {
                        message = ""
                    } else {
                        showSafari = true
                    }
                } label: {
                    Image("send")
                }.frame(width: 40, height: 40)
                    .padding(10)
                    .disabled(message.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || vm.inProgress)
            }.frame(minHeight: 60)
                .background(Color.cardBgColor)
                .cornerRadius(12)
                .padding(.horizontal, 20)
            
            Text("This app does not give Medical advice. AI therapist are not real therapist. Read our \(Text("Discliamer").underline().foregroundColor(.blue))")
                .font(.inter(12, fontWeight: .regular))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
                .tint(.blue)
                .onTapGesture {
                    showSafari.toggle()
                }.sheet(isPresented: $showSafari, content: {
                    SafariView(url: .constant(URL(string: "https://")!))
                        .ignoresSafeArea()
                })
        }
    }
}
