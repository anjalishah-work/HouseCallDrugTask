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

    @Published var path : [AppRoute] = []

     func push(to route: AppRoute) {
        path.append(route)
    }
    
     func popTo() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    public func popToRoot() {
        path.removeAll()
    }
    
    public func popToRootAndPush(to route: AppRoute) {
        path.removeAll()
        path.append(route)
    }
    public func popToUntil(_ route: AppRoute) {
        guard let index = path.firstIndex(of: route) else { return }
        path = Array(path[0...index])
    }
    public func popToRouteIndex(_ index: Int) {
        if path.count > index {
            path.removeLast(index)
        }
    }
}

