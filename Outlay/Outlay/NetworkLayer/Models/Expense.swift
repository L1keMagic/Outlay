import Foundation

struct Expense: Codable {
    let id: Int
    let title: String
    let price: Float
    let categoryId: Int?
    let creationDate: String
}

typealias Expenses = [Expense]
