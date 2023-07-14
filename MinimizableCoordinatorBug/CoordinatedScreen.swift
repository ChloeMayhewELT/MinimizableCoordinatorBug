//
//  CoordinatedScreen.swift
//  MinimizableCoordinatorBug
//
//  Created by Chloe Mayhew on 14/07/2023.
//

import ComposableArchitecture

struct CoordinatedScreen: ReducerProtocol {
    enum State: Equatable {
        case minimizable(MinimizableScreen.State)
    }

    enum Action: Equatable {
        case minimizable(MinimizableScreen.Action)
    }

    var body: some ReducerProtocol<State, Action> {
        Scope(state: /State.minimizable, action: /Action.minimizable) {
            MinimizableScreen()
        }
    }
}
