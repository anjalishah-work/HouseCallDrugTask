//
//  AuthViewModelTests.swift
//  HouseCallDrugTask
//
//  Created by Anjali Shah on 22/04/25.
//

import XCTest
@testable import HouseCallDrugTask
import RealmSwift
import Firebase

final class AuthViewModelTests: XCTestCase {

    override class func setUp() {
        super.setUp()
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
    }

    func testInitialAuthenticationStatus() {
        let viewModel = AuthViewModel()
        XCTAssertFalse(viewModel.isAuthenticated || viewModel.isLoading)
    }

    func testSignUpWithInvalidCredentialsFails() {
        let viewModel = AuthViewModel()
        let expectation = self.expectation(description: "SignUp fail")

        viewModel.signUp(email: "test123@gmail.com", password: "123") {
            XCTFail("Invalid credentials")
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            XCTAssertNotNil(viewModel.errorMessage)
            XCTAssertFalse(viewModel.isAuthenticated)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5)
    }

    func testSignOutClearsSession() {
        let viewModel = AuthViewModel()
        let expectation = self.expectation(description: "SignOut")

        viewModel.updateSession(true)
        XCTAssertTrue(viewModel.isAuthenticated)

        viewModel.signOut {
            XCTAssertFalse(viewModel.isAuthenticated)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 3)
    }
}
