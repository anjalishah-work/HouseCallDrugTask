//
//  SignupView.swift
//  HouseCallDrugTask
//
//  Created by Anjali Shah on 21/04/25.
//

import SwiftUI

struct SignupView: View {
  
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @ObservedObject var authViewModel: AuthViewModel
    @EnvironmentObject private var appManager: AppCoordinator

    var body: some View {
        VStack {
            // MARK: - Fields Section
            VStack(spacing: 20) {
                FloatingTextField(title: "Name", text: $name)
                FloatingTextField(title: "Email", text: $email)
                FloatingTextField(title: "Create Password", text: $password, isSecure: true)

                if let errorMessage = authViewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                        .padding(.top, 4)
                }
            }
            .padding(.top, 60)
            .padding(.horizontal)

            Spacer()

            // MARK: - Create Account Button
            Button(action: {
                authViewModel.signUp(email: email, password: password)
                {
                    appManager.popToRoot()
                }
            }) {
                if authViewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .frame(maxWidth: .infinity)
                        .padding()
                } else {
                    Text("Create Account")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
            }
            .background(authViewModel.isLoading ? Color.gray : Color.blue)
            .cornerRadius(14)
            .disabled(authViewModel.isLoading)
            .padding(.horizontal)
            .padding(.bottom, 30)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Create New Account")
                    .font(.headline)
                    .foregroundColor(.blue)
            }
        }
    }
}
