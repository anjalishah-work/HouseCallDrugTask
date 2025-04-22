//
//  AuthViewModel.swift
//  HouseCallDrugTask
//
//  Created by Anjali Shah on 21/04/25.
//

import FirebaseAuth
import Combine
import RealmSwift

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var errorMessage: String?
    @Published var isLoading = false

    private var realm: Realm

    init() {
        realm = try! Realm()
        if let session = realm.objects(UserSession.self).first {
            isAuthenticated = session.isAuthenticated
        }
    }

    func updateSession(_ authenticated: Bool) {
        DispatchQueue.main.async {
            if let session = self.realm.objects(UserSession.self).first {
                try? self.realm.write {
                    session.isAuthenticated = authenticated
                }
            } else {
                let session = UserSession()
                session.isAuthenticated = authenticated
                try? self.realm.write {
                    self.realm.add(session)
                }
            }
            self.isAuthenticated = authenticated
        }
    }

    func signUp(email: String, password: String, completion: (() -> Void)? = nil) {
        isLoading = true
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                } else {
                    self?.updateSession(true)
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
        }
    }

    func signIn(email: String, password: String, completion: (() -> Void)? = nil) {
        isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                } else {
                    self?.updateSession(true)
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
        }
    }

    func signOut(completion: (() -> Void)? = nil) {
        do {
            try Auth.auth().signOut()
            updateSession(false)
            DispatchQueue.main.async {
                completion?()
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}


class UserSession: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var isAuthenticated: Bool
}
