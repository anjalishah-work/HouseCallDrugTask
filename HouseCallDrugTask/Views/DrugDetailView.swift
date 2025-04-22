//
//  DrugDetailView.swift
//  HouseCallDrugTask
//
//  Created by Anjali Shah on 21/04/25.
//

import SwiftUI
import RealmSwift

struct DrugDetailView: View {
    let drug: DrugModel
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 16) {
                    Image("img_Pill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.orange)
                        .padding(.top)
                    
                    Text(drug.name)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Text("Generic Name")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("""
Tablet:
• Adult: 1–2 tablets every 4–6 hours up to a maximum of 4 gm/day.
• Children (6–12 years): ½ to 1 tablet 3 to 4 times daily.

Extended Release Tablet:
• Adults & Children over 12 years: Two tablets, swallowed whole, every 6 to 8 hours (max 6/day).

Syrup/Suspension:
• Children under 3 months: 10 mg/kg body weight (reduce to 5 mg/kg if needed).
""")
                        .font(.body)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    Spacer(minLength: 32)
                }
            }
            
            // Sticky Add Button
            Button(action: {
                addDrugToRealm(drug)
                AppCoordinator.shared.popToRoot()
            }) {
                Text("Add Medication to List")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .padding(.bottom, 16)
            }
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func addDrugToRealm(_ drug: DrugModel) {
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
