import Foundation
import UIKit

protocol AppRouterProtocol: AnyObject {
    func start(in window: UIWindow)
    func showHomeScreen()
}
