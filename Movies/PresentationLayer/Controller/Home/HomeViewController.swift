import UIKit
import SnapKit
import Combine

class HomeViewController: UIViewController {

    private let homePresenter: HomePresenterProtocol
    weak var router: MoviesRouterProtocol?
    private lazy var optionSegment: UISegmentedControl = createMovieListTypeSegmentedControl()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    private let selectedSegmentIndexSubject = PassthroughSubject<Int, Never>()
    private var disposables = Set<AnyCancellable>()

    private(set) var movieViewModels: [MovieViewModel] = [] {
        didSet { collectionView.reloadData() }
    }

    var selectedListType: AnyPublisher<ListType, Never> {
        selectedSegmentIndexSubject
            .removeDuplicates()
            .map { ListType.typeFromIndex($0) }
            .eraseToAnyPublisher()
    }

    init(homePresenter: HomePresenterProtocol, router: MoviesRouterProtocol) {
        self.homePresenter = homePresenter
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        selectedListType
            .map { [weak self] selectedSegmentIndex -> AnyPublisher<[MovieViewModel], Error>? in
                self?.homePresenter.listOfMovies(type: selectedSegmentIndex)
            }
            .compactMap {$0}
            .switchToLatest()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] movies in
                    DispatchQueue.main.async {
                        self?.movieViewModels = movies
                    }
                })
            .store(in: &disposables)
        selectedSegmentIndexSubject.send(optionSegment.selectedSegmentIndex)
    }

    @objc func didSelectListType() {
        selectedSegmentIndexSubject.send(optionSegment.selectedSegmentIndex)
    }

    private func setupView() {
        view.backgroundColor = .white
        navigationItem.titleView = optionSegment
        navigationController?.navigationBar.barTintColor = .white
        setupCollectionView()
        setConstraints()
    }

    private func createMovieListTypeSegmentedControl() -> UISegmentedControl {
        let segmented = UISegmentedControl(items: ListType.allCases.map { $0.name })
        segmented.selectedSegmentIndex = 0
        segmented.backgroundColor = .lightGray.withAlphaComponent(0.5)
        segmented.selectedSegmentTintColor = .darkGray.withAlphaComponent(0.5)
        segmented.addTarget(self, action: #selector(didSelectListType), for: .valueChanged)
        return segmented
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
    }

    private func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(12)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(12)
        }
    }
}
