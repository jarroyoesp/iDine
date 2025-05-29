// RandomTextViewModel.swift

import SwiftUI

class RandomTextViewModel: BaseViewModel<RandomTextContract.Event, RandomTextContract.State> {
    private let service: RandomTextService

    // A mock service can be injected.
    init(service: RandomTextService = RandomTextService()) {
        self.service = service
        super.init(initialState: RandomTextContract.State())
        loadPosts()
    }

    /// Entry point the view uses to drive the state machine.
    override func send(_ event: RandomTextContract.Event) {
        switch event {
            case .onTapRetryButton:
                loadPosts()
        }
    }

    // MARK: – Private helpers

    private func loadPosts() {
        state.isLoading = true
        state.error = nil

        service.fetchPosts { [weak self] result in
            guard let self else { return }
            switch result {
                case .success(let posts):
                    self.state.isLoading = false
                    self.state.titles = posts.map(\.title)
                
                case .failure(let error):
                    self.state.isLoading = false
                    self.state.error = error.localizedDescription
            }
        }
    }
}
