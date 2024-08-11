//
//  TextMsgItem.swift
//  AITherapist
//
//  Created by Shirin-Yan on 08.08.2024.
//

import SwiftUI

struct TextMsgItem: View {
    var data: String = ""
    var isOwn = false
    
    var body: some View {
        HStack(alignment: .bottom) {
            let content = Text(data)
                .padding(12)
                .font(.inter(14, fontWeight: .regular))

            if !isOwn {
                content
                    .foregroundColor(.textColor)
                    .background(Color.cardBgColor)
                    .cornerRadius(12)

                Spacer(minLength: 60)
            } else {
                Spacer(minLength: 60)

                content
                    .foregroundColor(.white)
                    .background(Color.blueColor)
                    .cornerRadius(12)
            }
        }
    }
}

#Preview {
    TextMsgItem()
}

