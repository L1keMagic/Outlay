import Foundation

struct Category: Codable {
    let categoryId: String
    let title: String
    let categorySavingDate: String
    let isFavourite: Bool
    let color: String
    let isDeleted: Bool
}

typealias Categories = [Category]
