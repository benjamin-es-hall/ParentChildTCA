//
//  AppFeature.swift
//  ParentChildTCA
//
//  Created by Ben Hall on 03/12/2025.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct AppFeature {
    struct State: Equatable {
        var child = ChildFeature.State(count: 0)
    }
    
    @CasePathable
    enum Action: ViewAction {
        case view(ViewAction)
        case child(ChildFeature.Action)
        
        @CasePathable
        enum ViewAction {
            case sendDirectChildActionToIncrement
            case reduceStateOnChildAction
        }
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.child, action: \.child) {
            ChildFeature()
        }
        
        Reduce<AppFeature.State, AppFeature.Action> { state, action in
            switch action {
            case .view(.sendDirectChildActionToIncrement):
                return .send(.child(.increment))
                
            case .view(.reduceStateOnChildAction):
                return reduce(into: &state, action: .child(.increment))
                
            case .child:
                return .none
            }
        }
        ._printChanges()
    }
}

extension AppFeature {
    @ViewAction(for: Self.self)
    struct View: SwiftUI.View {
        let store: StoreOf<AppFeature>
        
        var body: some SwiftUI.View {
            VStack {
                ChildFeature.View(
                    store: store.scope(state: \.child, action: \.child)
                )
                
                Button(".send(.child(.increment))") {
                    send(.sendDirectChildActionToIncrement)
                }
                
                Button("reduce(into: &state, action: .child(.increment))") {
                    send(.reduceStateOnChildAction)
                }
            }
        }
    }
}
