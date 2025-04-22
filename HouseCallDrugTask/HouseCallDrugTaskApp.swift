//
//  HouseCallDrugTaskApp.swift
//  HouseCallDrugTask
//
//  Created by Anjali Shah on 22/04/25.
//

import SwiftUI
import Firebase

@main
struct HouseCallDrugTaskApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
