import Foundation

enum RequestError: Int, Error {
    case clientError
    case serverError
    case noDataError
    case decodingError
    case invalidURLError
}
