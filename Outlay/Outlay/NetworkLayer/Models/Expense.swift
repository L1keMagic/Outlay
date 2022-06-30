import Foundation
let dateManager = DateManager()
struct Expense: Codable {
    let expenseId: String
    let title: String
    let price: Double
    let categoryId: String
    let categoryTitle: String
    let categoryImage: String
    let expenseDate: String
    let expenseSavingDate: String
    var expenseDateParsed: Date {
        dateManager.convertDateFormat(date: expenseDate, outputFormat: Constants.dateFormatDMY)
    }
}

typealias Expenses = [Expense]
