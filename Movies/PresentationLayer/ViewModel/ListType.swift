import Foundation

enum ListType: CaseIterable {
    case popular
    case topRated

    var name: String {
        switch self {
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        }
    }

    static func typeFromIndex(_ index: Int) -> ListType {
        return index == 0 ? .popular : .topRated
    }
}
