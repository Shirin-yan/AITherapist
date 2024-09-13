//
//  SettingsView.swift
//  AITherapist
//
//  Created by Shirin-Yan on 04.09.2024.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var subscriptionService: SubscriptionService
    @State private var showSafari = false
    @State private var safariURL = URL(string: "https://")!
    
    var body: some View {
        VStack {
            Text(LocalizedStringKey("Settings"))
                .font(.inter(20, fontWeight: .medium))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 20)
            
            List {
                VStack(spacing: 10) {
                    Text("Hi, \(FirestoreManager.shared.user?.name ?? FirestoreManager.shared.user?.email ?? "")")
                        .foregroundColor(.black)
                        .font(.inter(20, fontWeight: .medium))
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    VStack (spacing: 4) {
                        Text("You have \(FirestoreManager.shared.user?.leftMessage ?? 0) messages remaining")
                            .foregroundColor(.black)
                            .font(.inter(20, fontWeight: .medium))
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        Text("You get 10 free messages every 12 hours.")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Text("Subscription Plan:")
                            .foregroundColor(.black)
                            .font(.inter(16, fontWeight: .medium))
                        
                        Text(subscriptionService.isPremium() ? "Pro" : "Free")
                            .foregroundColor(.accentColor)
                            .font(.inter(16, fontWeight: .medium))
                    }
                    
                    if !subscriptionService.isPremium() {
                        Button {
                            subscriptionService.showPaywallView()
                        } label: {
                            Text("Upgrade to Pro")
                                .padding()
                                .foregroundColor(.white)
                                .font(.inter(16, fontWeight: .medium))
                                .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.pink]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(25)
                                .padding(.trailing, 20)
                        }.padding()
                    }
                }
                
                Button {
                    safariURL = URL(string: "https://")!
                    showSafari.toggle()
                } label: {
                    Text("Terms of Service")
                        .foregroundColor(.black)
                        .font(.inter(16, fontWeight: .medium))
                }
                
                Button {
                    safariURL = URL(string: "https://example.com")!
                    showSafari.toggle()
                } label: {
                    Text("Privacy Policy")
                        .foregroundColor(.black)
                        .font(.inter(16, fontWeight: .medium))
                }
                
                Button {
                    safariURL = URL(string: "https://")!
                    showSafari.toggle()
                } label: {
                    Text("Disclaimer")
                        .foregroundColor(.black)
                        .font(.inter(16, fontWeight: .medium))
                }
                
                Button {
                    Defaults.token = ""
                } label: {
                    Text("Signout")
                        .foregroundColor(.black)
                        .font(.inter(16, fontWeight: .medium))
                }
                
                Button {
                    FirestoreManager.shared.deleteUser()
                    Defaults.token = ""
                } label: {
                    Text("Delete Account")
                        .foregroundColor(.red)
                        .font(.inter(16, fontWeight: .medium))
                }
            }.listStyle(PlainListStyle())
                .sheet(isPresented: $showSafari) {
                    SafariView(url: $safariURL)
                        .ignoresSafeArea()
                }
        }
    }
}

#Preview {
    SettingsView(subscriptionService: SubscriptionService())
}
