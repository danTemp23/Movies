import Foundation

struct MoviesResponse: Decodable {
    let results: [MovieResponse]
    let page: Int
}
