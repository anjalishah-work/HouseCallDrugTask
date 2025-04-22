//
//  RootView.swift
//  HouseCallDrugTask
//
//  Created by Anjali Shah on 21/04/25.
//

import SwiftUI

struct RootView: View {
    @StateObject var authViewModel = AuthViewModel()
    @StateObject var coordinator = AppCoordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            ZStack {
                if authViewModel.isAuthenticated {
                    MyMedicationsView(authViewModel: authViewModel)
                } else {
                    OnboardingView()
                }
            }
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .Onboarding:
                    OnboardingView()
                case .login:
                    LoginView(authViewModel: authViewModel)
                case .signup:
                    SignupView(authViewModel: authViewModel)
                case .search:
                    SearchView()
                case .drugDetail(let drug, let isFromSearch):
                    DrugDetailView(drug: drug, isFromSearch: isFromSearch)
                }
            }
        }
        .environmentObject(coordinator)
    }
}
