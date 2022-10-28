import Foundation
import Combine

class HomePresenter: HomePresenterProtocol {
    private let moviesUseCase: MoviesUseCaseProtocol

    init(moviesUseCase: MoviesUseCaseProtocol) {
        self.moviesUseCase = moviesUseCase
    }

    func listOfMovies(type: ListType) -> AnyPublisher<[MovieViewModel], Error> {
        switch type {
        case .popular:
            return moviesUseCase.popularMovies.map { $0.map { MovieViewModel(movie: $0) } }.eraseToAnyPublisher()
        case .topRated:
            return moviesUseCase.topRatedMovies.map { $0.map { MovieViewModel(movie: $0) } }.eraseToAnyPublisher()
        }
    }
}
