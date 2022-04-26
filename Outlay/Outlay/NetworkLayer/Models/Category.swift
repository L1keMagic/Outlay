import Foundation

struct Category: Codable {
    let id: String
    let title: String
    let categorySavingDate: String
    let isFavourite: Bool
    let color: String
}

typealias Categories = [Category]
