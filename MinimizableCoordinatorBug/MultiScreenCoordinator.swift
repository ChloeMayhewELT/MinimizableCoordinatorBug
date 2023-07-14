//
//  MultiScreenCoordinator.swift
//  MinimizableCoordinatorBug
//
//  Created by Chloe Mayhew on 14/07/2023.
//

import ComposableArchitecture
import SwiftUI
import TCACoordinators

struct MultiScreenCoordinator: ReducerProtocol {

    struct State: IndexedRouterState, Equatable {
        var routes: [Route<CoordinatedScreen.State>]
    }

    enum Action: IndexedRouterAction, Equatable {
        case routeAction(Int, action: CoordinatedScreen.Action)
        case updateRoutes([Route<CoordinatedScreen.State>])
    }

    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .routeAction(let index, action: .minimizable(.binding(.set(\.$isMinimized, true)))):
                for i in state.routes.indices where i < index {
                    if case .minimizable(var childState) = state.routes[i].screen {
                        childState.isMinimized = true
                        state.routes[i].screen = .minimizable(childState)
                    }
                }
                return .none
            case .routeAction(let index, action: .minimizable(.binding(.set(\.$isMinimized, false)))):
                for i in state.routes.indices where i < index {
                    if case .minimizable(var childState) = state.routes[i].screen {
                        childState.isMinimized = false
                        state.routes[i].screen = .minimizable(childState)
                    }
                }
                return .none
            case .routeAction(_, action: .minimizable(.createContent)):
                state.routes.push(.minimizable(.init(color: .random, isMinimized: false)))
                return .none
            case .routeAction:
                return .none
            case .updateRoutes:
                return .none
            }
        }
            .forEachRoute { () -> CoordinatedScreen in
                CoordinatedScreen()
            }
    }
}

struct MultiScreenCoordinatorView: View {
    let store: StoreOf<MultiScreenCoordinator>

    var body: some View {
        TCARouter(store) { screen in
            SwitchStore(screen) {
                CaseLet(
                    state: /CoordinatedScreen.State.minimizable,
                    action: CoordinatedScreen.Action.minimizable,
                    then: MinimizableScreenView.init
                )
            }
        }
    }
}
