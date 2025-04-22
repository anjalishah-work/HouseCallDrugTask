//
//  WelcomeView.swift
//  HouseCallDrugTask
//
//  Created by Anjali Shah on 22/04/25.
//


import SwiftUI

struct OnboardingView: View {
    @State private var flipped = false
    @State private var flipCount = 0
    let maxFlips = 2
    @EnvironmentObject private var appManager: AppCoordinator

    var body: some View {
        VStack {
            Spacer()
            
            Image("Catalog")
                .resizable()
                .frame(width: 120, height: 120)
                .rotation3DEffect(.degrees(flipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
                .animation(.easeInOut(duration: 0.8), value: flipped    )
                .onAppear {
                    startFlipping()
                }
            Spacer()
            
            Button(action: {
                appManager.push(to: .signup)
            }) {
                Text("Create New Account")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
            
            Button(action: {
                appManager.push(to: .login)
            }) {
                Text("I already have an account")
                    .foregroundColor(Color.blue)
                    .font(.subheadline)
                    .padding(.top, 8)
            }
            
            Spacer().frame(height: 40)
        }
        .background(Color(red: 0.92, green: 0.95, blue: 1.0))
        .edgesIgnoringSafeArea(.all)
    }
    
    private func startFlipping() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if flipCount >= maxFlips {
                timer.invalidate()
            } else {
                flipped.toggle()
                flipCount += 1
            }
        }
    }
}
