import Foundation
import Combine

protocol MovieDetailsPresenterProtocol {
    func details(for movieId: Int) -> AnyPublisher<MovieDetailsViewModel, Error>
    func similarMovies(for movieId: Int) -> AnyPublisher<[MovieViewModel], Error>
}
