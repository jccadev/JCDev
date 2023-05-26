//
//  EmailTextField.swift
//  JCDev
//
//  Created by Mia Mawby on 26/4/2023.
//

import SwiftUI

struct EmailTextField: View {
    @State private var email = ""

    var body: some View {
        TextField("example@example.com", text: $email)
            .keyboardType(.emailAddress)
            .frame(width: 300)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
            .autocapitalization(.none)
    }
}

struct EmailTextField_Previews: PreviewProvider {
    static var previews: some View {
        EmailTextField()
    }
}


