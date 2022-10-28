import Foundation
import UIKit

class Router: AppRouterProtocol, MoviesRouterProtocol {

    private let moviesUseCase: MoviesUseCaseProtocol
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController, moviesUseCase: MoviesUseCaseProtocol) {
        self.navigationController = navigationController
        self.moviesUseCase = moviesUseCase
    }

    func start(in window: UIWindow) {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        showHomeScreen()
    }

    func showHomeScreen() {
        let homePresenter = HomePresenter(moviesUseCase: moviesUseCase)
        let homeViewController = HomeViewController(homePresenter: homePresenter, router: self)
        navigationController.navigationBar.tintColor = .black
        navigationController.setViewControllers([homeViewController], animated: false)
    }

    func showMovieDetails(movieId: Int) {
        let detailsPresenter = MovieDetailsPresenter(moviesUseCase: moviesUseCase)
        let detailsViewController = MovieDetailsViewController(for: movieId,
                                                               detailsPresenter: detailsPresenter, router: self)
        navigationController.pushViewController(detailsViewController, animated: true)
    }

    func goBack() {
        navigationController.popViewController(animated: true)
    }

    func presentMovieDetails(movieId: Int) {
        let detailsPresenter = MovieDetailsPresenter(moviesUseCase: moviesUseCase)
        let detailsViewController = MovieDetailsViewController(for: movieId,
                                                               detailsPresenter: detailsPresenter, router: self)
        detailsViewController.modalPresentationStyle = .pageSheet
        if let sheet = detailsViewController.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
        }
        let containerNavigationController = UINavigationController()
        containerNavigationController.navigationBar.tintColor = .black
        containerNavigationController.setViewControllers([detailsViewController], animated: false)
        navigationController.present(containerNavigationController, animated: true)
    }

    func presentMoviePoster(posterImage: UIImage) {
        let posterViewController = PosterViewController(posterImage: posterImage, router: self)
        posterViewController.modalPresentationStyle = .pageSheet
        if let sheet = posterViewController.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
        }
        let containerNavigationController = UINavigationController()
        containerNavigationController.navigationBar.tintColor = .black
        containerNavigationController.setViewControllers([posterViewController], animated: false)
        navigationController.present(containerNavigationController, animated: true)
    }

    func dismiss() {
        navigationController.dismiss(animated: true)
    }

}
