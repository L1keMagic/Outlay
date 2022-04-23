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
                if creationDate == dateManager.getCurrentDate(dateFormat: Constants.dateFormatDMY) {
                date = dateManager.getCurrentDate(dateFormat: Constants.dateFormatYMDHMS)
                } else {
                    date = dateManager.convertDateFormat(date: creationDate,
                                                         inputFormat: Constants.dateFormatDMY,
                                                         outputFormat: Constants.dateFormatYMD) + " 23:59:59"
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
