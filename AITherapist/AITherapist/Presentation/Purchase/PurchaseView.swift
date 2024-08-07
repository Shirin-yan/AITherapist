//
//  PurchaseView.swift
//  AITherapist
//
//  Created by Shirin-Yan on 07.08.2024.
//

import SwiftUI

struct PurchaseView: View {
    
    @State var selectedInd = 0

    var onboardTitles = ["purchase_1", "purchase_2", "purchase_3"]
    
    var body: some View {
        VStack {
            HStack {
                Text(LocalizedStringKey("AI Therapist Pro"))
                    .font(.inter(24, fontWeight: .medium))
                    .foregroundColor(.textColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                
                Button {
                    
                } label: {
                    Image(systemName: "xmark")
                        .imageScale(.large)
                        .foregroundColor(.textColor)
                        .frame(width: 40, height: 40, alignment: .center)
                }
            }.padding(.horizontal, 20)

            ScrollView {
                TabView(selection: $selectedInd, content:  {
                    ForEach(onboardTitles.enumeratedArray(), id: \.offset) { ind, title in
                        VStack(spacing: 20) {
                            Image("purchase-\(ind+1)")
                                .resizable()
                                .scaledToFit()
                            
                            Text(LocalizedStringKey(title))
                                .font(.inter(14, fontWeight: .regular))
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.textColor)
                        }.tag(ind)
                            .padding(.bottom, 50)
                    }
                }).tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .interactive))
                    .frame(height: 200)
                
                VStack {
                    PurchaseItemView()
                    PurchaseItemView()
                    PurchaseItemView()
                }.padding(.horizontal, 20)
                
                Spacer(minLength: 20)

                Button {

                } label: {
                   Text(LocalizedStringKey("buy"))
                       .foregroundColor(.cardBgColor)
                       .font(.inter(20, fontWeight: .regular))
                       .padding(.horizontal, 20)
                       .padding(.vertical, 10)
                       .background(Color.textColor)
                       .cornerRadius(10)
               }
               
               Button {

               } label: {
                   Text(LocalizedStringKey("restore_purchase"))
                       .foregroundColor(.textColor)
                       .font(.inter(16, fontWeight: .regular))
               }
                
                Spacer(minLength: 20)
                
                HStack {
                    Button {
                        
                    } label: {
                        Text(LocalizedStringKey("privacy_policy"))
                            .foregroundColor(.textColor)
                            .font(.inter(16, fontWeight: .regular))
                    }.frame(maxWidth: .infinity)
                    
                    Button {
                        
                    } label: {
                        Text(LocalizedStringKey("terms_of_service"))
                            .foregroundColor(.textColor)
                            .font(.inter(16, fontWeight: .regular))
                    }.frame(maxWidth: .infinity)
                }.padding(.horizontal, 20)
            }
            
        }.background(Color.accentColor.ignoresSafeArea())
    }
}

#Preview {
    PurchaseView()
}
