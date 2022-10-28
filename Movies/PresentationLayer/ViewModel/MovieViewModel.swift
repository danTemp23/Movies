import Foundation

struct MovieViewModel {
    let id: Int
    let title: String
    let posterURL: String

    init(movie: Movie) {
        self.id = movie.id
        self.title = movie.title
        self.posterURL = movie.posterURL
    }
}
