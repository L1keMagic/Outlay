import Foundation

struct Expense: Codable {
    let expenseId: String
    let title: String
    let price: Double
    let categoryId: String
    let categoryTitle: String
    let categoryImage: String
    let expenseDate: String
    let expenseSavingDate: String
}

typealias Expenses = [Expense]
