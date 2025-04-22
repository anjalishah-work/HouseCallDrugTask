//
//  Drug.swift
//  HouseCallDrugTask
//
//  Created by Anjali Shah on 21/04/25.
//

import Foundation
import RealmSwift

struct Drug: Identifiable, Codable {
    var id: String { rxcui }
    let rxcui: String
    let name: String
}

struct RxNormDrugResponse: Codable {
    let drugGroup: DrugGroup
}

struct DrugGroup: Codable {
    let conceptGroup: [ConceptGroup]?
}

struct ConceptGroup: Codable {
    let tty: String?
    let conceptProperties: [ConceptProperty]?
}

struct ConceptProperty: Codable {
    let rxcui: String
    let name: String
    let tty: String
}

class DrugModel: Object, Identifiable {
    @Persisted(primaryKey: true) var rxcui: String
    @Persisted var name: String
}
