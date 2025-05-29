// RandomTextViewModel.swift

import Foundation

@MainActor
final class RandomTextViewModel: ObservableObject {
    // Published UI state (single source of truth)
    @Published private(set) var state = RandomTextContract.State()

    private let service: RandomTextService

    // A mock service can be injected.
    init(service: RandomTextService = RandomTextService()) {
        self.service = service
    }

    /// Entry point the view uses to drive the state machine.
    func send(_ event: RandomTextContract.Event) {
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
