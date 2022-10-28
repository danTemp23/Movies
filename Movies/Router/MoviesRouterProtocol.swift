import Foundation
import UIKit

protocol MoviesRouterProtocol: AnyObject {
    func showMovieDetails(movieId: Int)
    func goBack()

    func presentMovieDetails(movieId: Int)
    func presentMoviePoster(posterImage: UIImage)
    func dismiss()
}
