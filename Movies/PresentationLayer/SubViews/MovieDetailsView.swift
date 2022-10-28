import Foundation
import UIKit

class MovieDetailsView: UIView {

    let coverImageView = UIImageView()
    let coverImageGradient = UIView()
    let posterImageView = UIImageView()
    let posterMagnifierView = UIImageView(image: UIImage(systemName: "magnifyingglass.circle.fill"))
    let titleLabel = UILabel()
    let overviewLabel = UILabel()
    let releaseDateLabel = UILabel()
    let genresLabel = UILabel()
    let scrollView = UIScrollView()
    let similarMoviesLabel = UILabel()
    var collectionView: UICollectionView!

    var viewModel: MovieDetailsViewModel? {
        didSet {
            posterImageView.kf.setImage(with: URL(string: viewModel?.detailedPosterURL ?? ""))
            coverImageView.kf.setImage(with: URL(string: viewModel?.coverURL ?? ""))
            titleLabel.text = viewModel?.title
            genresLabel.text = viewModel?.genres
            releaseDateLabel.text = viewModel?.releaseDate
            overviewLabel.text = viewModel?.overview
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        setupSubViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        coverImageGradient.applyGradientIfNeeded(colors: [.white.withAlphaComponent(0.3), .black.withAlphaComponent(0.85)])
    }

    func addGestureRecognizerToPosterImage(_ gestureRecognizer: UIGestureRecognizer) {
        posterImageView.isUserInteractionEnabled = true
        posterImageView.addGestureRecognizer(gestureRecognizer)
    }

    func getPosterImage() -> UIImage? {
        return posterImageView.image
    }

    func setupSubViews() {
        backgroundColor = .white
        addSubviews()
        setupPosterAndCoverImage()
        setupPosterMagnifierView()
        setupLabels()
        setupSimilarMoviesComponents()
        similarMoviesLabel.isHidden = true
    }

    func addSubviews() {
        addSubview(coverImageView)
        addSubview(coverImageGradient)
        addSubview(posterImageView)
        addSubview(posterMagnifierView)
        addSubview(titleLabel)
        addSubview(releaseDateLabel)
        addSubview(genresLabel)
        addSubview(scrollView)
    }
}
