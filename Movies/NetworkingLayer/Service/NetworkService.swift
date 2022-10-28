import Foundation
import Combine


class NetworkService: NetworkServiceProtocol {
    private let baseURL: String
    private let apiKey: String

    init(baseURL: String, apiKey: String) {
        self.baseURL = baseURL
        self.apiKey = apiKey
    }

    public func get<T: Decodable>(path: String, queryParameters: [String: String?]? = nil) -> AnyPublisher<T, Error> {
        let urlString = "\(baseURL)\(path)"

        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]

        if let parameters = queryParameters {
            for parameter in parameters {
                urlComponents?.queryItems?.append(URLQueryItem(name: parameter.key, value: parameter.value))
            }
        }

        guard let url = urlComponents?.url else {
            return Fail(error: RequestError.invalidURLError).eraseToAnyPublisher()
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
