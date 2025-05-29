// RandomTextService.swift

import Foundation

struct Post: Identifiable, Decodable {
    let id: Int
    let title: String
    let body: String
}

class RandomTextService {
    private let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!

    /// Fetch all posts from JSONPlaceholder.
    /// Calls the completion on the **main** queue.
    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> ()) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data else {
                    completion(.failure(NSError(domain: "NoData", code: -1)))
                    return
                }
                do {
                    let posts = try JSONDecoder().decode([Post].self, from: data)
                    completion(.success(posts))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
