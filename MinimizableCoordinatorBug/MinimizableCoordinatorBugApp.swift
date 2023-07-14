//
//  MinimizableCoordinatorBugApp.swift
//  MinimizableCoordinatorBug
//
//  Created by Chloe Mayhew on 14/07/2023.
//

import ComposableArchitecture
import SwiftUI


@main
struct MinimizableCoordinatorBugApp: App {
    var body: some Scene {
        WindowGroup {
            LandingScreenView(
                store: StoreOf<LandingScreen>(
                    initialState: LandingScreen.State(),
                    reducer: LandingScreen.init
                )
            )
            .onAppear {
                let coloredAppearance = UINavigationBarAppearance()
                coloredAppearance.configureWithTransparentBackground()
                coloredAppearance.backgroundColor = .white
                coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
                coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
                UINavigationBar.appearance().standardAppearance = coloredAppearance
                UINavigationBar.appearance().compactAppearance = coloredAppearance
                UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
            }
        }
    }
}
