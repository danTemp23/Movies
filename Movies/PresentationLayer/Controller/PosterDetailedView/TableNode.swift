import Foundation
import SceneKit

class TableNode: SCNNode {
    override init() {
        super.init()
        let tableTopGeometry = SCNBox(width: 3, height: 0.2, length: 3, chamferRadius: 0.05)
        tableTopGeometry.firstMaterial?.diffuse.contents = UIColor.brown
        let tableTopNode = SCNNode(geometry: tableTopGeometry)
        tableTopNode.position = SCNVector3(x: 0, y: -0.1, z: 0)
        addChildNode(tableTopNode)

        let tableLegsLocations: [SCNVector3] = [
            .init(x: -1.5 + 0.2, y: -0.5 - 0.1, z: 1.5 - 0.2),
            .init(x: -1.5 + 0.2, y: -0.5 - 0.1, z: -1.5 + 0.2),
            .init(x: 1.5 - 0.2, y: -0.5 - 0.1, z: 1.5 - 0.2),
            .init(x: 1.5 - 0.2, y: -0.5 - 0.1, z: -1.5 + 0.2)
        ]
        let tableLegNodes = tableLegsLocations.map { createTableLegNode(position: $0) }
        for legNode in tableLegNodes {
            addChildNode(legNode)
        }
    }

    private func createTableLegNode(position: SCNVector3) -> SCNNode {
        let legGeometry = SCNCylinder(radius: 0.1, height: 1)
        legGeometry.firstMaterial?.diffuse.contents = UIColor.brown
        let legNode = SCNNode(geometry: legGeometry)
        legNode.position = position
        return legNode
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
