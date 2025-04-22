//
//  SearchView.swift
//  HouseCallDrugTask
//
//  Created by Anjali Shah on 21/04/25.
//

import SwiftUI
import RealmSwift
import Foundation

struct SearchView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText: String = ""
    @State private var searchResults: [Drug] = []
    @State private var isLoading = false
    @State private var selectedDrug: DrugModel? = nil

    var body: some View {
        VStack(spacing: 16) {
            TextField("Search Medication", text: $searchText)
                .padding(12)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)

            Button(action: {
                Task {
                    await performSearch()
                }
            }) {
                Text("Search")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }

            if isLoading {
                ProgressView()
                    .padding()
            }

            List(searchResults) { drug in
                Button(action: {
                    let drugModel = DrugModel()
                    drugModel.rxcui = drug.rxcui
                    drugModel.name = drug.name
                    selectedDrug = drugModel
                    AppCoordinator.shared.push(.drugDetail(drugModel, true))
                }) {
                    HStack {
                        Image("img_Pill")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .foregroundColor(.orange)
                        Text(drug.name)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                }
            }
            .listStyle(PlainListStyle())

            Spacer()
        }
        .navigationTitle("Search Medication")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func performSearch() async {
        guard !searchText.isEmpty else { return }

        isLoading = true
        do {
           searchResults = try await DrugSearchService.searchDrugs(query: searchText)
        } catch {
            print("Error fetching drugs: \(error)")
        }
        isLoading = false
    }

    private func addDrugToRealm(_ drug: Drug) {
        let realmDrug = DrugModel()
        realmDrug.rxcui = drug.rxcui
        realmDrug.name = drug.name

        do {
            let realm = try Realm()
            try realm.write {
                realm.add(realmDrug, update: .modified)
            }
        } catch {
            print("Error saving drug to Realm: \(error)")
        }
    }
}
