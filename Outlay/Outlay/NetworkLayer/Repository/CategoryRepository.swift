import Foundation

class CategoryRepository {
    static let shared = CategoryRepository()
    var categories: Categories = []
    func getCategories() -> Categories {
        return categories
    }
    func getCategoryById(id: String) -> Category? {
        return categories.first(where: { $0.id == id })
    }
    func insertCategory(category: Category) {
        categories.append(category)
    }
}
