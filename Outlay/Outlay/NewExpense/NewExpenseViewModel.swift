import Foundation

class NewExpenseViewModel {
    init(title: String?, price: String?, categoryId: String?, expenseDate: String?) {
        self.title = title
        self.price = price
        self.categoryId = categoryId
        self.expenseDate = expenseDate
    }
    private let title: String?
    private let price: String?
    private let categoryId: String?
    private let expenseDate: String?
    func insertData() -> Response {
        if let title = title,
           !title.isEmpty,
           let price = price,
           !price.isEmpty,
           let categoryId = categoryId,
           !categoryId.isEmpty,
           let expenseDate = expenseDate,
           !expenseDate.isEmpty {
            let dateManager = DateManager()
            let expenseSavingDate: String = dateManager.getCurrentDate(dateFormat: Constants.dateFormatYMDHMS)
            ExpenseRepository.shared.insertExpense(expense: Expense(id: UUID().uuidString,
                                                                    title: title,
                                                                    price: Double(price)!,
                                                                    categoryId: categoryId,
                                                                    expenseDate: expenseDate,
                                                                    expenseSavingDate: expenseSavingDate))
            return Response.ok
        }
        return Response.badRequest
    }
}
