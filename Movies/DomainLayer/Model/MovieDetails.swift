import Foundation

struct MovieDetails {
    let id: Int
    let overview: String?
    let title: String
    let posterURL: String?
    let detailedPosterURL: String?
    let coverURL: String?
    let genres: [Genre]
    let voteAverage: Double
    let runtime: Int
    let releaseDate: String

    init(movieDetailsResponse: MovieDetailsResponse, movieGateway: MovieGatewayProtocol) {
        id = movieDetailsResponse.id
        overview = movieDetailsResponse.overview
        title = movieDetailsResponse.title
        posterURL = movieGateway.getFullImageURL(imagePath: movieDetailsResponse.posterPath ?? "", size: .medium)
        detailedPosterURL = movieGateway.getFullImageURL(imagePath: movieDetailsResponse.posterPath ?? "", size: .original)
        coverURL = movieGateway.getFullImageURL(imagePath: movieDetailsResponse.backdropPath ?? "", size: .medium)
        genres = movieDetailsResponse.genres.map { Genre(genreRespnse: $0) }
        voteAverage = movieDetailsResponse.voteAverage
        runtime = movieDetailsResponse.runtime
        releaseDate = movieDetailsResponse.releaseDate
    }
}

struct Genre {
    let id: Int
    let name: String

    init(genreRespnse: GenreResponse) {
        id = genreRespnse.id
        name = genreRespnse.name
    }
}
