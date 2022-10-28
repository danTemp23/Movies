import Foundation

struct MovieDetailsResponse: Decodable {
    let id: Int
    let overview: String?
    let title: String
    let posterPath: String?
    let backdropPath: String?
    let genres: [GenreResponse]
    let voteAverage: Double
    let runtime: Int
    let releaseDate: String

    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case title
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case genres
        case voteAverage = "vote_average"
        case runtime
        case releaseDate = "release_date"
    }
}

struct GenreResponse: Decodable {
    let id: Int
    let name: String
}
