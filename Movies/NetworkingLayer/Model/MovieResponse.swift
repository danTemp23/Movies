import Foundation

struct MovieResponse: Decodable {
    let id: Int
    let overview: String
    let title: String
    let posterPath: String

    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case title
        case posterPath = "poster_path"
    }
}
