////
////  CustomNavigation.swift
////  MinimizableCoordinatorBug
////
////  Created by Chloe Mayhew on 14/07/2023.
////
//
//import ComposableArchitecture
//
//public struct CustomNavigation<Child: ReducerProtocol, BarContent: ReducerProtocol>: ReducerProtocol where BarContent.State: Equatable, BarContent.Action: Equatable {
//
//    public typealias NavBuilder = ReducerBuilder<
//        ReachabilityObservingNavigationBar<BarContent>.State,
//        ReachabilityObservingNavigationBar<BarContent>.Action
//    >
//    public typealias ChildBuilder = ReducerBuilder<Child.State, Child.Action>
//
//    public struct State {
//        public var navigation: ReachabilityObservingNavigationBar<BarContent>.State
//        public var child: Child.State
//
//        public init(
//            navigation: ReachabilityObservingNavigationBar<BarContent>.State,
//            child: Child.State
//        ) {
//            self.navigation = navigation
//            self.child = child
//        }
//    }
//
//    public enum Action {
//        case navigation(ReachabilityObservingNavigationBar<BarContent>.Action)
//        case child(Child.Action)
//    }
//
//    @NavBuilder private let navigation: () -> ReachabilityObservingNavigationBar<BarContent>
//    @ChildBuilder private let child: () -> Child
//
//    public init(
//        @NavBuilder navigation: @escaping () -> ReachabilityObservingNavigationBar<BarContent>,
//        @ChildBuilder child: @escaping () -> Child
//    ) {
//        self.navigation = navigation
//        self.child = child
//    }
//
//    public var body: some ReducerProtocol<State, Action> {
//        Scope(state: \.child, action: /Action.child) {
//            child()
//        }
//        Scope(state: \.navigation, action: /Action.navigation) {
//            navigation()
//        }
//    }
//
//    @ReducerBuilder<State, Action> var core: some ReducerProtocol<State, Action> {
//        Reduce { state, action in
//            return .none
//        }
//    }
//}
