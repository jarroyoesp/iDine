// RandomTextContract.swift

import Foundation

enum RandomTextContract {
    // MARK: - UI State the view renders

    struct State: ViewState {
        var error: String? = nil
        var isLoading = false
        var titles: [String] = []
    }

    // MARK: - Events the view sends to the view-model

    enum Event: ViewEvent {
        case onTapButtonRetry
        case onViewAppear
    }
}
