//
//  InputView.swift
//  Spend Smart
//
//  Created by Sandun Kasthuri on 2023-09-08.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let placeholder: String
    var isSecured = false
    var body: some View {
        VStack{
            RoundedRectangle(cornerRadius: 33)
                .stroke(Color(.black), lineWidth: 2)
                .foregroundColor(.white)
                .frame(height: 54)
                .overlay {
                    if isSecured {
                        SecureField(placeholder, text: $text)
                            .padding(.leading, 20)
                    } else {
                        TextField(placeholder, text: $text)
                            .padding(.leading, 20)
                    }
                }
        }    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(text: .constant(""), placeholder: "")
    }
}
