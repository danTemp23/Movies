import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {

    public static let identifier = "MovieCollectionViewCell"

    private let posterView = UIImageView()
    private let titleLabel = UILabel()

    var viewModel: MovieViewModel? = nil {
        didSet {
            guard let viewModel = self.viewModel else { return }
            self.posterView.kf.setImage(with: URL(string: viewModel.posterURL))
            self.titleLabel.text = viewModel.title
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterView)
        contentView.addSubview(titleLabel)
        setupSubViews()
    }

    private func setupSubViews() {
        contentView.backgroundColor = .darkGray
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8
        posterView.clipsToBounds = true
        posterView.contentMode = .scaleAspectFill
        titleLabel.numberOfLines = 2
        titleLabel.font = .systemFont(ofSize: 13, weight: .medium)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.8
        setContraints()
    }

    private func setContraints() {
        posterView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(6)
            make.top.equalTo(posterView.snp.bottom).offset(6)
        }
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        posterView.image = nil
        titleLabel.text = nil
    }
}
