import Foundation

class CategoryRepository {
    static let shared = CategoryRepository()
    var categories: Categories = load("CategoriesData.json")
    func getCategories() -> Categories {
        return categories
    }
    func getCategoryById(categoryId: String) -> Category? {
        return categories.first(where: { $0.categoryId == categoryId })
    }
    func insertCategory(category: Category) {
        categories.append(category)
    }
}
