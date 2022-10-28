import Foundation
import SceneKit

class PosterNode: SCNNode {
    private let posterImage: UIImage?

    init(posterImage: UIImage) {
        self.posterImage = posterImage
        super.init()
        self.geometry = SCNBox(width: 2, height: 3, length: 2, chamferRadius: 0)
        self.geometry?.firstMaterial?.diffuse.contents = posterImage
        self.geometry?.firstMaterial?.ambient.contents = UIColor.black

        self.geometry?.firstMaterial?.specular.contents = posterImage
        self.geometry?.firstMaterial?.shininess = 25
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
