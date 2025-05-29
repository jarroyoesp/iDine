//
//  MockRandomTextService.swift
//  iDine
//
//  Created by Danijel Lasic on 27.05.25.
//

import Foundation

final class MockRandomTextService: RandomTextService {
    override func fetchPosts(
        completion: @escaping (Result<[Post], Error>) -> ()
    ) {
        let sample = (1...5).map {
            Post(
                id: $0,
                title: "Sample title \($0)",
                body: ""
            )
        }

        // Simulate a short network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            completion(.success(sample))
        }
    }
}
