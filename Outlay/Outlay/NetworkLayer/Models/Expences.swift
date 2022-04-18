import Foundation

struct Expence: Codable {
    let id: Int?
    let title: String
    let price: Float
    let categoryId: Int?
    let creationDate: Date
}

typealias Expences = [Expence]
