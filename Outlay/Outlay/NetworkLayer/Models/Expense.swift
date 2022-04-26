import Foundation

struct Expense: Codable {
    let id: String
    let title: String
    let price: Double
    let categoryId: String
    let expenseDate: String
    let expenseSavingDate: String // date when user clicks "save" button
}

typealias Expenses = [Expense]
