//
//  MyDrugsView.swift
//  HouseCallDrugTask
//
//  Created by Anjali Shah on 21/04/25.
//

import SwiftUI
import RealmSwift

struct MyMedicationsView: View {
    @ObservedResults(DrugModel.self) var medications
    @State private var showSignOutAlert = false
    @ObservedObject var authViewModel: AuthViewModel
    @EnvironmentObject private var appManager: AppCoordinator

    var body: some View {
        VStack {
            List {
                ForEach(medications) { med in
                    Button {
                        appManager.push(to: .drugDetail(med,false))
                    } label: {
                        HStack {
                            Image("img_Pill")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .foregroundColor(.orange)
                            Text(med.name)
                        }
                    }
                }
                .onDelete(perform: deleteMedication)
            }
            .listStyle(PlainListStyle())
            
            Spacer()
            
            Button(action: {
                appManager.push(to: .search)
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Search Medications")
                }
                .foregroundColor(.blue)
                .padding()
            }
        }
        .navigationTitle("My Medications")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showSignOutAlert.toggle()
                }) {
                    Text("Sign Out")
                        .foregroundColor(.red)
                }
            }
        }
        .alert(isPresented: $showSignOutAlert) {
            Alert(
                title: Text("Are you sure?"),
                message: Text("Do you really want to sign out?"),
                primaryButton: .destructive(Text("Sign Out")) {
                    signOut()
                },
                secondaryButton: .cancel()
            )
        }
    }
    
    private func deleteMedication(at offsets: IndexSet) {
        $medications.remove(atOffsets: offsets)
    }
    
    private func signOut() {
        authViewModel.signOut()
    }
}
