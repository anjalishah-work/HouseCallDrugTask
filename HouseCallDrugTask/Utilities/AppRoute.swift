//
//  AppRoute.swift
//  HouseCallDrugTask
//
//  Created by Anjali Shah on 22/04/25.
//
import SwiftUI

enum AppRoute: Hashable {
    case Onboarding
    case login
    case signup
    case search
    case drugDetail(DrugModel, Bool)
}


final class AppCoordinator: ObservableObject {
    static let shared = AppCoordinator()

    @Published var path = NavigationPath()

    private init() {}

    func push(_ route: AppRoute) {
        path.append(route)
    }

    func pop() {
        path.removeLast()
    }

    func popToRoot(_ route: AppRoute = .login) {
        if route != .login {
            path.removeLast(path.count)
            AppCoordinator.shared.resetTo(.Onboarding)
        }else {
            path.removeLast(path.count)
        }
    }
    
    func resetTo(_ route: AppRoute) {
        path = NavigationPath()
        path.append(route)
    }
}

