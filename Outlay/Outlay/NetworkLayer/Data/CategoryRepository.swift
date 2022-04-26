import Foundation

class CategoryRepository {
    static let shared = CategoryRepository()
    var categories: Categories = []
    func getCategories() -> Categories {
        return categories
    }
    func insertCategory(category: Category) {
        categories.append(category)
    }
}
