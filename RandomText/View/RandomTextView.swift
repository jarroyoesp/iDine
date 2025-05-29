// RandomTextView.swift

import SwiftUI

struct RandomTextView: View {
    @StateObject private var viewModel: RandomTextViewModel

    /// Allows injection for previews / tests.
    init(viewModel: @autoclosure @escaping () -> RandomTextViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel())
    }

    var body: some View {
        NavigationView {
            if viewModel.state.isLoading {
                ProgressView("Loading…")
            } else if let error = viewModel.state.error {
                VStack(spacing: 12) {
                    Text(error).foregroundColor(.red)
                    Button("Retry") { viewModel.send(.retry) }
                }
            } else {
                List(viewModel.state.titles, id: \.self, rowContent: Text.init)
            }
        }
        .onAppear { viewModel.send(.onAppear) }
    }
}

#Preview {
    RandomTextView(viewModel: RandomTextViewModel(service: MockRandomTextService()))
}

// *D* note:
//
// Contract:
//      - defines internal communication structure (with states and events)
//      - (foundation for how the ViewModel and View interact)
//
// Service:
//      - fetches the data
//
// ViewModel:
//      - uses the service
//      - updates state
//      - handles events from the view
//
// View:
//      - renders state from the viewModel
//      - sends events (like .onAppear, .retry, etc.) to the viewModel
//
// NOTE:
//      - the view contains an instance of a viewModel which contains an instance of the service
//      - when implementing new screen, we create files in this order:
//          - 1. the contract
//          - 2. the service
//          - 3. the viewModel
//          - 4. the view
