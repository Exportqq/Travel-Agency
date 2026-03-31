import Foundation

protocol CategoriesViewViewModelInputProtocol: AnyObject {
    var categoriesTitle: String { get }
}

final class CategoriesViewViewModel: CategoriesViewViewModelInputProtocol {
    var categoriesTitle: String = "Categories"
}

