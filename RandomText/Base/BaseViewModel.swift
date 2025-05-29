//
//  BaseViewModel.swift
//
//  Created by Javier Arroyo on 29/5/25.
//

import SwiftUI

public protocol ViewEvent {}
public protocol ViewState {}

@MainActor
open class BaseViewModel<UiEvent: ViewEvent, UiState: ViewState>: ObservableObject {
    @Published public var state: UiState

    public init(initialState: UiState) {
        state = initialState
    }

    open func send(_: UiEvent) {
        fatalError("Subclasses must implement send(event:)")
    }

    open func onUiEvent(event: UiEvent) {
        send(event)
    }
}
