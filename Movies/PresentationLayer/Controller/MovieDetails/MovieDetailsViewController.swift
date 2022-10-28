import Foundation
import UIKit
import Combine
import SnapKit

class MovieDetailsViewController: UIViewController {
    private let movieId: Int
    private let detailsPresenter: MovieDetailsPresenterProtocol
    private var disposables = Set<AnyCancellable>()
    weak var router: MoviesRouterProtocol?

    private(set) var similarMovies: [MovieViewModel] = [] {
        didSet {
            movieDetailsView?.collectionView.reloadData()
            if similarMovies.count > 0 {
                movieDetailsView?.similarMoviesScrollView.isHidden = false
            }
        }
    }

    var movieDetailsView: MovieDetailsView? {
        guard let view = view as? MovieDetailsView else { fatalError() }
        return view
    }

    init(for movieId: Int, detailsPresenter: MovieDetailsPresenterProtocol, router: MoviesRouterProtocol) {
        self.movieId = movieId
        self.detailsPresenter = detailsPresenter
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    @objc func onPosterClick() {
        guard let posterImage = movieDetailsView?.getPosterImage() else { return }
        router?.presentMoviePoster(posterImage: posterImage)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view = MovieDetailsView(frame: .zero)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(onPosterClick))
        movieDetailsView?.addGestureRecognizerToPosterImage(tap)
        movieDetailsView?.collectionView.delegate = self
        movieDetailsView?.collectionView.dataSource = self
        detailsPresenter.details(for: movieId)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] movieDetails in
                    DispatchQueue.main.async {
                        guard let movieDetailsView = self?.movieDetailsView else { return }
                        movieDetailsView.viewModel = movieDetails
                    }
                }
            ).store(in: &disposables)

        detailsPresenter.similarMovies(for: movieId)
                    .sink(
                        receiveCompletion: { _ in },
                        receiveValue: { [weak self] movies in
                            DispatchQueue.main.async {
                                self?.similarMovies = movies
                            }
                        })
                    .store(in: &disposables)
    }
}
