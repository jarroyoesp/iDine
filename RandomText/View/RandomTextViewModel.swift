// RandomTextViewModel.swift

import SwiftUI

class RandomTextViewModel: BaseViewModel<RandomTextContract.Event, RandomTextContract.State> {
    private let service: RandomTextService

    // A mock service can be injected.
    init(service: RandomTextService = RandomTextService()) {
        self.service = service
        super.init(initialState: RandomTextContract.State())
    }

    /// Entry point the view uses to drive the state machine.
    override func send(_ event: RandomTextContract.Event) {
        switch event {
            case .onAppear, .retry:
                loadPosts()

            case .postsLoaded(let posts):
                state = .init(
                    titles: posts.map(\.title),
                    isLoading: false,
                    error: nil
                )

            case .failed(let error):
                state.isLoading = false
                state.error = error.localizedDescription
        }
    }

    // MARK: – Private helpers

    private func loadPosts() {
        state.isLoading = true
        state.error = nil

        service.fetchPosts { [weak self] result in
            guard let self else { return }
            switch result {
                case .success(let posts): self.send(.postsLoaded(posts))
                case .failure(let error): self.send(.failed(error))
            }
        }
    }
}
