import Foundation
import UIKit
import SceneKit
import SnapKit

class PosterViewController: UIViewController {
    private let posterImage: UIImage
    private let sceneView = SCNView()
    private var cameraNode: SCNNode?
    private var didZoomIn = false
    weak var router: MoviesRouterProtocol?

    init(posterImage: UIImage, router: MoviesRouterProtocol) {
        self.posterImage = posterImage
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Poster 3D Viewer"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: "xmark.circle"), style: .done, target: self, action: #selector(onClose))
        view.backgroundColor = .white
        view.addSubview(sceneView)
        setupScene()
        setupSceneView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !didZoomIn {
            let zoomAction = SCNAction.move(by: .init(x: 0, y: 0, z: -5.5), duration: 0.2)
            cameraNode?.runAction(zoomAction)
            didZoomIn = true
        }
    }

    @objc func onClose() {
        router?.dismiss()
    }

    private func setupScene() {
        let scene = SCNScene()

        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 11)
        scene.rootNode.addChildNode(cameraNode)

        let lightNode1 = SCNNode()
        lightNode1.light = SCNLight()
        lightNode1.light?.type = .omni
        lightNode1.position = SCNVector3(x: 50, y: 0, z: 50)
        scene.rootNode.addChildNode(lightNode1)

        let lightNode2 = SCNNode()
        lightNode2.light = SCNLight()
        lightNode2.light?.type = .omni
        lightNode2.position = SCNVector3(x: -50, y: 0, z: -50)
        scene.rootNode.addChildNode(lightNode2)

        let posterNode = PosterNode(posterImage: posterImage)
        posterNode.position = SCNVector3(x: 0, y: 0, z: 0)
        scene.rootNode.addChildNode(posterNode)

        let tableNode = TableNode()
        tableNode.position = SCNVector3(x: 0, y: -1.5, z: 0)
        scene.rootNode.addChildNode(tableNode)

        self.cameraNode = cameraNode
        sceneView.scene = scene
    }

    func setupSceneView() {
        sceneView.backgroundColor = UIColor.black
        sceneView.allowsCameraControl = true
        view.addSubview(sceneView)
        setConstraints()
    }

    private func setConstraints() {
        sceneView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
