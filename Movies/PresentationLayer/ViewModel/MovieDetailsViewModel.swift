import Foundation

struct MovieDetailsViewModel {
    let id: Int
    let overview: String?
    let title: String
    let posterURL: String?
    let detailedPosterURL: String?
    let coverURL: String?
    let genres: String
    let releaseDate: String

    init(movieDetails: MovieDetails) {
        id = movieDetails.id
        overview = movieDetails.overview
        title = movieDetails.title
        posterURL = movieDetails.posterURL
        detailedPosterURL = movieDetails.detailedPosterURL
        coverURL = movieDetails.coverURL
        genres = MovieDetailsViewModel.getGenresText(genres: movieDetails.genres)
        releaseDate = MovieDetailsViewModel.getEUFormattedDate(usaFormatedDate: movieDetails.releaseDate)
    }

    static func getEUFormattedDate(usaFormatedDate: String) -> String {
        let originalFormatter = DateFormatter()
        originalFormatter.dateFormat = "yyyy-MM-dd"
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "dd.MM.yyyy"
        return displayFormatter.string(from: originalFormatter.date(from: usaFormatedDate) ?? .now)
    }

    static func getGenresText(genres: [Genre]) -> String {
        var text: String = ""
        genres.enumerated().forEach { (index, genre) in
            if index > 0 {
                text += ", "
            }
            text += genre.name
        }
        return text
    }
}
