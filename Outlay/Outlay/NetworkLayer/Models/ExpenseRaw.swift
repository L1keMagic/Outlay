import Foundation

struct ExpenseRaw: Codable {
    let expenseId: String
    let title: String
    let price: Double
    let categoryId: String
    let expenseDate: String
    let expenseSavingDate: String // date when user clicks "save" button
    let isDeleted: Bool
}

typealias ExpensesRaw = [ExpenseRaw]
