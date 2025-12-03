//
//  ParentChildTCATests.swift
//  ParentChildTCATests
//
//  Created by Ben Hall on 03/12/2025.
//

import ComposableArchitecture
import Testing

@testable import ParentChildTCA

@MainActor
struct ParentChildTCATests {

    @Test func example() async throws {
        let store = TestStoreOf<AppFeature>(
            initialState: .init(),
            reducer: AppFeature.init
        )
        
        // 1.
        // Update child state from parent by sending child action directly
        await store.send(\.view.sendDirectChildActionToIncrement)
        // Receive child event and state incremented
        await store.receive(\.child.increment) {
            $0.child.count = 1
        }
        
        
        // 2. More performant Parent-Child state update
        // Reduce child action effect into state
        // State updated directly as
        await store.send(\.view.reduceStateOnChildAction) {
            $0.child.count = 2
        }
        // Child action not sent in as reduce
        // run directly on state with the action. This reduces iterations through
        // reducer
        // UNCOMMENT TO SEE TEST FAIL
//        await store.receive(\.child.increment)
    }
}
