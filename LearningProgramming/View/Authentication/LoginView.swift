//
//  LoginView.swift
//  LearningProgramming
//
//  Created by Natanael  on 01/12/2021.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var viewModel : AuthViewModel
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    VStack(alignment: .leading){
                        Text("Witaj w")
                            .foregroundColor(Color.ui.darkestBlue)
                            .font(Font.custom("Sofia Pro Bold", size: 35))
                        Text(appName)
                            .foregroundColor(Color.ui.blue)
                            .font(Font.custom("Sofia Pro Bold", size: 35))
                    }
                    Spacer()
                }.padding(.top, 40)
                .padding()
                VStack(spacing: 50){
                    CustomTextField(placeholder: Text("Email address"), image: "envelope.fill", text: $email)
                    CustomSecureField(placeholder: Text("Password"), image: "lock.fill", text: $password)
                }.padding(.horizontal)
                    .padding(.top, 30)
                Spacer()
                VStack{
                    Button {
                        viewModel.login(withEmail: email, password: password)
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.ui.blue)
                            Text("Zaloguj się")
                                .foregroundColor(Color.ui.pastel)
                                .font(Font.custom("Sofia Pro Bold", size: 20))
                        }.frame(width: screenW - 50, height: 80)
                            
                    }
                    HStack{
                        Text("Nie masz jeszcze konta?")
                            .foregroundColor(Color.ui.darkestBlue)
                            .font(Font.custom("Sofia Pro Bold", size: 17))
                        NavigationLink {
                            RegistrationView()
                        } label: {
                            Text("Zarejestruj się")
                                .foregroundColor(Color.ui.blue)
                                .font(Font.custom("Sofia Pro Bold", size: 17))
                        }

                    }.padding()
                }.padding()
            }.background(Color.ui.pastel)
            .navigationBarHidden(true)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
