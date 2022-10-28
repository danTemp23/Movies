import Foundation
import UIKit

extension MovieDetailsView {
    func setupPosterAndCoverImage() {
        posterImageView.contentMode = .scaleAspectFit
        posterImageView.layer.borderWidth = 2
        posterImageView.layer.borderColor = UIColor.black.cgColor
        posterImageView.backgroundColor = .lightGray
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.clipsToBounds = true
        coverImageView.backgroundColor = .lightGray

        coverImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }

        coverImageGradient.snp.makeConstraints { make in
            make.edges.equalTo(coverImageView)
        }

        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(130)
            make.leading.equalToSuperview().offset(12)
            make.width.equalTo(150)
            make.height.equalTo(150 / CGFloat.posterAspectRatio)
        }
    }

    func setupPosterMagnifierView() {
        posterMagnifierView.tintColor = .systemYellow
        posterMagnifierView.clipsToBounds = true
        posterMagnifierView.contentMode = .scaleAspectFit
        posterMagnifierView.isUserInteractionEnabled = false

        posterMagnifierView.snp.makeConstraints { make in
            make.trailing.equalTo(posterImageView.snp.trailing).offset(-10)
            make.bottom.equalTo(posterImageView.snp.bottom).offset(-10)
            make.height.width.equalTo(30)
        }
    }

    func setupLabels() {
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.numberOfLines = 2
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textColor = .black

        sutupLightLabel(label: overviewLabel)
        sutupLightLabel(label: genresLabel)
        sutupLightLabel(label: releaseDateLabel)

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(coverImageView.snp.bottom).offset(10)
            make.leading.equalTo(posterImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        releaseDateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(posterImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        genresLabel.snp.makeConstraints { make in
            make.top.equalTo(releaseDateLabel.snp.bottom).offset(10)
            make.leading.equalTo(posterImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(12)
        }
    }

    func sutupLightLabel(label: UILabel) {
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 0
        label.textColor = .black
    }

    func setupSimilarMoviesComponents() {
        similarMoviesScrollView.addSubview(similarMoviesLabel)
        similarMoviesScrollView.addSubview(collectionView)
        similarMoviesScrollView.backgroundColor = .clear

        similarMoviesLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        similarMoviesLabel.numberOfLines = 1
        similarMoviesLabel.adjustsFontSizeToFitWidth = true
        similarMoviesLabel.textColor = .black
        similarMoviesLabel.text = "Similar movies"
        
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.clipsToBounds = true
        collectionView.backgroundColor = .clear
        
        similarMoviesScrollView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(overviewLabel.snp.bottom).offset(24)
            make.bottom.equalToSuperview()
        }

        similarMoviesLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(12)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(similarMoviesLabel.snp.bottom).offset(6)
            make.leading.trailing.equalTo(self).inset(12)
            make.height.equalTo(200)
        }
    }
}
