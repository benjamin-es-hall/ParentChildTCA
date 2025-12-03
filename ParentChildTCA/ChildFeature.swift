//
//  ChildFeature.swift
//  ParentChildTCA
//
//  Created by Ben Hall on 03/12/2025.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct ChildFeature {
    @ObservableState
    struct State: Equatable {
        var count: Int = 0
    }
    
    @CasePathable
    enum Action {
        case increment
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .increment:
            state.count += 1
            return .none
        }
    }
}

extension ChildFeature {
    struct View: SwiftUI.View {
        let store: StoreOf<ChildFeature>
        
        var body: some SwiftUI.View {
            Text("Count: \(store.count)")
        }
    }
}
