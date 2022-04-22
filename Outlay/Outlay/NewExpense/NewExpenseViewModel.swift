import Foundation

class NewExpenseViewModel {
    init(title: String?, price: String?, categoryId: String?, creationDate: String?) {
        self.title = title
        self.price = price
        self.categoryId = categoryId
        self.creationDate = creationDate
    }
    private let title: String?
    private let price: String?
    private let categoryId: String?
    private let creationDate: String?
    func insertData() -> String {
        if let title = title,
           !title.isEmpty,
           let price = price,
           !price.isEmpty,
           let categoryId = categoryId,
           !categoryId.isEmpty,
           let creationDate = creationDate,
           !creationDate.isEmpty {
                let date: String
                let dateManager = DateManager()
                if creationDate == dateManager.getCurrentDateDMMYYYY() {
                    date = dateManager.getCurrentDateUTC()
                } else {
                        date = creationDate + "'T'23:59:59Z"
                        }
            ExpenseRepository.shared.insertExpense(expense: Expense(id: UUID().uuidString,
                                                                    title: title,
                                                                    price: Double(price)!,
                                                                    categoryId: Int(categoryId),
                                                                    creationDate: date))
            return "Ok"
        }
        return "Bad"
    }
}
