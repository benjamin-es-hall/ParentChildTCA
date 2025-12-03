//
//  ParentChildTCAApp.swift
//  ParentChildTCA
//
//  Created by Ben Hall on 03/12/2025.
//

import SwiftUI
import ComposableArchitecture

@main
struct ParentChildTCAApp: App {
    let store = StoreOf<AppFeature>(
        initialState: .init(),
        reducer: AppFeature.init
    )

    var body: some Scene {
        WindowGroup {
            AppFeature.View(store: store)
        }
    }
}
