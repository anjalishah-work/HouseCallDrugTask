//
//  FloatingTextField.swift
//  HouseCallDrugTask
//
//  Created by Anjali Shah on 22/04/25.
//

import SwiftUI

struct FloatingTextField: View {
    let title: String
    @Binding var text: String
    var isSecure: Bool = false

    @FocusState private var isFocused: Bool

    private var shouldFloat: Bool {
        isFocused || !text.isEmpty
    }

    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray5))
                .frame(height: 65)

            Text(title)
                .foregroundColor(.gray)
                .background(Color(.systemGray5))
                .padding(.horizontal, 8)
                .scaleEffect(shouldFloat ? 0.85 : 1.0, anchor: .leading)
                .offset(y: shouldFloat ? -20 : 0)
                .padding(.leading, 16)
                .animation(.easeInOut(duration: 0.2), value: shouldFloat)

            Group {
                if isSecure {
                    SecureField("", text: $text)
                        .focused($isFocused)
                        .padding(.leading, 8)

                } else {
                    TextField("", text: $text)
                        .focused($isFocused)
                        .padding(.leading, 8)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, shouldFloat ? 14 : 0)
            .frame(height: 65)
        }
        .frame(height: 65)
        .animation(.easeInOut(duration: 0.2), value: shouldFloat)
    }
}
