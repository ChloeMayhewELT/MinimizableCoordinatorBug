//
//  Extensions.swift
//  MinimizableCoordinatorBug
//
//  Created by Chloe Mayhew on 14/07/2023.
//

import SwiftUI

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

extension Binding where Value == Bool {

    func inverted() -> Binding<Bool> {
        .init(
            get: { !wrappedValue },
            set: { wrappedValue = !$0 }
        )
    }
}

extension View {

    @ViewBuilder
    func hidden(
        _ binding: Binding<Bool>,
        removeFromViewHierarchy: Bool = false
    ) -> some View {
        modifier(
            HiddenViewModifier(
                isHidden: binding,
                removeFromViewHierarchy: removeFromViewHierarchy
            )
        )
    }
}

private struct HiddenViewModifier: ViewModifier {

    @Binding var isHidden: Bool
    let removeFromViewHierarchy: Bool

    func body(content: Content) -> some View {
        if isHidden {
            if removeFromViewHierarchy {
                // No content
            } else {
                content.hidden()
            }
        } else {
            content
        }
    }
}
