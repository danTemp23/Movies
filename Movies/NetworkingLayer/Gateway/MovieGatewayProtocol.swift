import Foundation
import Combine

protocol MovieGatewayProtocol {
    var popularMovies: AnyPublisher<MoviesResponse, Error> { get }
    var topRatedMovies: AnyPublisher<MoviesResponse, Error> { get }

    func similarMovies(for movieId: Int) -> AnyPublisher<MoviesResponse, Error>
    func details(for movieId: Int) -> AnyPublisher<MovieDetailsResponse, Error>
    func getFullImageURL(imagePath: String, size: ImageSize) -> String
}
