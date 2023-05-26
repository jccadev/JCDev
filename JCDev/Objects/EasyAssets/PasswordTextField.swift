//
//  EmailTextField.swift
//  JCDev
//
//  Created by Mia Mawby on 26/4/2023.
//

import SwiftUI

struct PasswordTextField: View {
    @State private var password = ""

    var body: some View {
        SecureField("Password", text: $password)
            .keyboardType(.emailAddress)
            .frame(width: 300)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
            .autocapitalization(.none)
    }
}

struct PasswordTextField_Previews: PreviewProvider {
    static var previews: some View {
        PasswordTextField()
    }
}



