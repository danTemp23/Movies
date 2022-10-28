import Foundation

enum Result<SuccessData, Failure> where SuccessData: Decodable, Failure: Error {
    case success(SuccessData)
    case failure(Failure)
}
