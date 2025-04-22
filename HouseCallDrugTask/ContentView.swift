//
//  ContentView.swift
//  HouseCallDrugTask
//
//  Created by Anjali Shah on 21/04/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var authViewModel = AuthViewModel()
    @StateObject var coordinator = AppCoordinator.shared

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            if authViewModel.isAuthenticated {
                MyMedicationsView(authViewModel: authViewModel)
            } else {
                OnboardingView()
            }
        }
    }
}

#Preview {
    ContentView()
}
