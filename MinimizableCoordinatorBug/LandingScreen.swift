//
//  LandingScreen.swift
//  MinimizableCoordinatorBug
//
//  Created by Chloe Mayhew on 14/07/2023.
//

import ComposableArchitecture
import SwiftUI
import TCACoordinators

struct LandingScreen: ReducerProtocol {

    struct State: Equatable {
        var content: Minimizable<MultiScreenCoordinator>.State?
    }

    enum Action: Equatable {
        case content(Minimizable<MultiScreenCoordinator>.Action)
        case createContent
    }

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .createContent where state.content == nil:
                state.content = Minimizable<MultiScreenCoordinator>.State(
                    isMinimized: false,
                    child: MultiScreenCoordinator.State(
                        routes: [
                            Route<CoordinatedScreen.State>.root(
                                CoordinatedScreen.State.minimizable(
                                    MinimizableScreen.State(
                                        color: .random,
                                        isMinimized: false
                                    )
                                ),
                                embedInNavigationView: true
                            )
                        ]
                    )
                )
                return .none
            case .createContent:
                return .none
            case .content(.child(.routeAction(_, action: .minimizable(.binding(.set(\.$isMinimized, true)))))):
                state.content?.isMinimized = true
                return .none
            case .content:
                return .none
            }
        }
        .ifLet(\.content, action: /Action.content) {
            Minimizable<MultiScreenCoordinator>(child: MultiScreenCoordinator.init)
        }
        ._printChanges()
    }
}

struct LandingScreenView: View {

    let store: StoreOf<LandingScreen>

    var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                VStack {
                    Spacer()
                    Button("Display content") {
                        viewStore.send(.createContent)
                    }
                    Spacer()
                }
                IfLetStore(
                    store.scope(state: \.content, action: LandingScreen.Action.content),
                    then: { store in
                        WithViewStore(store) { viewStore in
                            ZStack {
                                Color.clear
                                    .frame(maxWidth: .infinity, maxHeight: 0)
                                    .fullScreenCover(isPresented: viewStore.binding(\.$isMinimized).inverted()) {
                                        MultiScreenCoordinatorView(
                                            store: store.scope(
                                                state: \.child,
                                                action: Minimizable<MultiScreenCoordinator>.Action.child
                                            )
                                        )
                                    }
                            }
                            VStack {
                                Spacer()
                                Button {
                                    viewStore.send(.binding(.set(\.$isMinimized, false)))
                                } label: {
                                    Rectangle()
                                        .frame(height: 60)
                                        .frame(maxWidth: .infinity)
                                        .overlay {
                                            Text("Tap to maximize")
                                                .foregroundColor(.white)
                                        }
                                }
                            }
                            .hidden(viewStore.$isMinimized.inverted())
                        }
                    }
                )
            }
        }
    }
}
