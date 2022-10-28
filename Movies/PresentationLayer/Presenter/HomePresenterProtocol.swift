import Combine

import Foundation

protocol HomePresenterProtocol {
    func listOfMovies(type: ListType) -> AnyPublisher<[MovieViewModel], Error>
}
