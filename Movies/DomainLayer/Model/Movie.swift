import Foundation

struct Movie {
    let id: Int
    let overview: String
    let title: String
    let posterURL: String

    init(movieResponse: MovieResponse, movieGateway: MovieGatewayProtocol) {
        id = movieResponse.id
        overview = movieResponse.overview
        title = movieResponse.title
        posterURL = movieGateway.getFullImageURL(imagePath: movieResponse.posterPath, size: .medium)
    }
}
