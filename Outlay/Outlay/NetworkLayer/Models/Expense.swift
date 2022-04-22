import Foundation

struct Expense: Codable {
    let id: String
    let title: String
    let price: Double
    let categoryId: Int?
    let creationDate: String
}

typealias Expenses = [Expense]
