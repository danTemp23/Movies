import Foundation
import Combine

protocol MoviesUseCaseProtocol {
    var popularMovies: AnyPublisher<[Movie], Error> { get }
    var topRatedMovies: AnyPublisher<[Movie], Error> { get }

    func details(for movieId: Int) -> AnyPublisher<MovieDetails, Error>
    func similarMovies(for movieId: Int) -> AnyPublisher<[Movie], Error>
}
