import Foundation
import Combine

class MovieDetailsPresenter: MovieDetailsPresenterProtocol {

    private let moviesUseCase: MoviesUseCaseProtocol

    init(moviesUseCase: MoviesUseCaseProtocol) {
        self.moviesUseCase = moviesUseCase
    }

    func details(for movieId: Int) -> AnyPublisher<MovieDetailsViewModel, Error> {
        return moviesUseCase.details(for: movieId).map { MovieDetailsViewModel(movieDetails: $0) }.eraseToAnyPublisher()
    }

    func similarMovies(for movieId: Int) -> AnyPublisher<[MovieViewModel], Error> {
        return moviesUseCase.similarMovies(for: movieId).map { $0.map { MovieViewModel(movie: $0) } }.eraseToAnyPublisher()
    }
}
