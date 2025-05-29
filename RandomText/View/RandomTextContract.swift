// RandomTextContract.swift

import Foundation

enum RandomTextContract {
    // MARK: - UI State the view renders

    struct State: ViewState {
        var titles: [String] = []
        var isLoading = false
        var error: String? = nil
    }

    // MARK: - Events the view sends to the view-model

    enum Event: ViewEvent {
        case onAppear
        case retry
    }
}
