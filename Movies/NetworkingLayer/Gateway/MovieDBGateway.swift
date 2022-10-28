import Foundation
import Combine

class MovieDBGateway: MovieGatewayProtocol {

    private let moviesService: NetworkServiceProtocol
    private let movieImagesBaseURL: String

    public static let shared = MovieDBGateway()

    private init() {
        self.moviesService = NetworkService(baseURL: movieDBsBaseURL, apiKey: movieDBsApiKey)
        self.movieImagesBaseURL = movieDBsImagesBaseURL
    }

    var popularMovies: AnyPublisher<MoviesResponse, Error> {
        let queryParameters = [ "page": "1" ]

        return moviesService.get(path: "/movie/popular", queryParameters: queryParameters)
    }

    var topRatedMovies: AnyPublisher<MoviesResponse, Error> {
        let queryParameters = [ "page": "1" ]

        return moviesService.get(path: "/movie/top_rated", queryParameters: queryParameters)
    }

    func details(for movieId: Int) -> AnyPublisher<MovieDetailsResponse, Error> {
        return moviesService.get(path: "/movie/\(movieId)", queryParameters: nil)
    }

    func similarMovies(for movieId: Int) -> AnyPublisher<MoviesResponse, Error> {
        return moviesService.get(path: "/movie/\(movieId)/similar", queryParameters: nil)
    }

    func getFullImageURL(imagePath: String, size: ImageSize) -> String {
        let sizeURLPath: String
        switch size {
        case .medium:
            sizeURLPath = movieDBsMediumImageSize
        case .original:
            sizeURLPath = movieDBsOriginalImageSize
        }
        return movieImagesBaseURL + sizeURLPath + imagePath
    }
}
