import Foundation
import Combine

protocol NetworkServiceProtocol {
    func get<T: Decodable>(path: String, queryParameters: [String: String?]?) -> AnyPublisher<T, Error>
}
