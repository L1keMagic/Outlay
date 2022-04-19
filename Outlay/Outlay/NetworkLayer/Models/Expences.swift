import Foundation

struct Expence: Codable {
    let id: String
    let title: String
    let price: Float
    let categoryId: Int?
    let creationDate: String
}

typealias Expences = [Expence]
