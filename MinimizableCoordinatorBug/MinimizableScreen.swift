//
//  MinimizableScreen.swift
//  MinimizableCoordinatorBug
//
//  Created by Chloe Mayhew on 14/07/2023.
//

import ComposableArchitecture
import SwiftUI
import TCACoordinators

struct MinimizableScreen: ReducerProtocol {

    struct State: Equatable {
        let color: Color
        @BindingState public var isMinimized: Bool
    }

    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case createContent
    }

    public var body: some ReducerProtocol<State, Action> {
        BindingReducer()
    }
}

struct MinimizableScreenView: View {
    let store: StoreOf<MinimizableScreen>

    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                Spacer()
                Button("Push another view") {
                    viewStore.send(.createContent)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(viewStore.color)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(
                        action: {
                            viewStore.send(.binding(.set(\.$isMinimized, true)))
                        },
                        label: {
                            HStack(alignment: .center, spacing: 0) {
                                Spacer(minLength: 0)
                                Image(systemName: "chevron.down")
                            }
                            .frame(width: 44, height: 44)
                        }
                    )
                    .padding(.zero)
                }
            }
        }
    }
}
