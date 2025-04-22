//
//  MyDrugsViewModel.swift
//  HouseCallDrugTask
//
//  Created by Anjali Shah on 21/04/25.
//

import Foundation
import RealmSwift

class MyDrugsViewModel: ObservableObject {
    @Published var drugs: [Drug] = []

    init() {
        loadDrugs()
    }

    func loadDrugs() {
    }

    func deleteDrug(at offsets: IndexSet) {
    }
}

struct DrugSearchService {
    static func searchDrugs(query: String) async throws -> [Drug] {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return []
        }
        
        let urlString = "https://rxnav.nlm.nih.gov/REST/drugs.json?name=\(encodedQuery)&expand=psn"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode(RxNormDrugResponse.self, from: data)
        let allDrugs = decoded.drugGroup.conceptGroup?.flatMap { $0.conceptProperties ?? [] } ?? []
        
        let filtered = allDrugs
            .filter { $0.tty == "SBD" }
            .prefix(10)
            .map { Drug(rxcui: $0.rxcui, name: $0.name) }
        
        return Array(filtered)
    }
}
