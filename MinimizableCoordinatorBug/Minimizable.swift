//
//  Minimizable.swift
//  MinimizableCoordinatorBug
//
//  Created by Chloe Mayhew on 14/07/2023.
//

import ComposableArchitecture

public struct Minimizable<T: ReducerProtocol>: ReducerProtocol where T.State: Equatable, T.Action: Equatable {

    let child: () -> T

    public init(child: @escaping () -> T) {
        self.child = child
    }

    public struct State: Equatable {
        @BindingState public var isMinimized: Bool
        public var child: T.State

        public init(isMinimized: Bool, child: T.State) {
            self.isMinimized = isMinimized
            self.child = child
        }
    }

    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case child(T.Action)
    }

    public var body: some ReducerProtocol<State, Action> {
        BindingReducer()
        Scope(state: \.child, action: /Action.child) {
            child()
        }
        core
    }

    @ReducerBuilder<State, Action> var core: some ReducerProtocol<State, Action> {
        EmptyReducer()
    }
}

