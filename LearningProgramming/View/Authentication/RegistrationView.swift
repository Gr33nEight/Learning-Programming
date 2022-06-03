//
//  RegistrationView.swift
//  LearningProgramming
//
//  Created by Natanael  on 01/12/2021.
//

import SwiftUI

import SwiftUI

struct RegistrationView: View {
    
    @State var email = ""
    @State var password = ""
    @State var fullname = ""
    @State var username = ""
    
    @Environment(\.presentationMode) var mode
    @EnvironmentObject var viewModel : AuthViewModel
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading){
                    Text("Zaczynajmy")
                        .foregroundColor(Color.ui.darkestBlue)
                        .font(Font.custom("Sofia Pro Bold", size: 35))
                    Text("Stwórz konto")
                        .foregroundColor(Color.ui.blue)
                        .font(Font.custom("Sofia Pro Bold", size: 35))
                }
                Spacer()
            }.padding(.top, 40)
            .padding()
            VStack(spacing: 50){
                CustomTextField(placeholder: Text("Email address"), image: "envelope.fill", text: $email)
                CustomTextField(placeholder: Text("Username"), image: "person.fill", text: $username)
                CustomTextField(placeholder: Text("Full name"), image: "person.fill", text: $fullname)
                CustomSecureField(placeholder: Text("Password"), image: "lock.fill", text: $password)
            }.padding(.horizontal)
                .padding(.top, 30)
            Spacer()
            VStack{
                Button {
                    viewModel.register(withEmail: email, password: password, fullname: fullname, username: username)
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.ui.blue)
                        Text("Zarejestruj się")
                            .foregroundColor(Color.ui.pastel)
                            .font(Font.custom("Sofia Pro Bold", size: 20))
                    }.frame(width: screenW - 50, height: 80)
                        
                }
                HStack{
                    Text("Masz już konto?")
                        .foregroundColor(Color.ui.darkestBlue)
                        .font(Font.custom("Sofia Pro Bold", size: 17))
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Text("Zaloguj się")
                            .foregroundColor(Color.ui.blue)
                            .font(Font.custom("Sofia Pro Bold", size: 17))
                    }
                }.padding()
            }.padding()
        }.background(Color.ui.pastel)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}
