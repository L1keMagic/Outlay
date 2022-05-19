import Foundation

struct ExpenseDto: Codable {
    let expenseId: String
    let title: String
    let price: Double
    let categoryTitle: String
    let categoryImage: String
    let expenseDate: String
    let expenseSavingDate: String
}

typealias ExpensesDto = [ExpenseDto]
