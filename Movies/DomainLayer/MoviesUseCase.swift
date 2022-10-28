import Foundation
import Combine

class MoviesUseCase: MoviesUseCaseProtocol {

    private let gateWay: MovieGatewayProtocol

    init(gateWay: MovieGatewayProtocol) {
        self.gateWay = gateWay
    }

    var popularMovies: AnyPublisher<[Movie], Error> {
        return gateWay.popularMovies
            .map { $0.results.map { Movie(movieResponse: $0, movieGateway: self.gateWay) } }
            .eraseToAnyPublisher()
    }

    var topRatedMovies: AnyPublisher<[Movie], Error> {
        return gateWay.topRatedMovies
            .map { $0.results.map { Movie(movieResponse: $0, movieGateway: self.gateWay) } }
            .eraseToAnyPublisher()
    }

    func details(for movieId: Int) -> AnyPublisher<MovieDetails, Error> {
        return gateWay.details(for: movieId)
            .map { MovieDetails(movieDetailsResponse: $0, movieGateway: self.gateWay) }
            .eraseToAnyPublisher()
    }

    func similarMovies(for movieId: Int) -> AnyPublisher<[Movie], Error> {
        gateWay.similarMovies(for: movieId)
            .map { $0.results.map { Movie(movieResponse: $0, movieGateway: self.gateWay) } }
            .eraseToAnyPublisher()
    }
}
