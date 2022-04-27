import Foundation

class NewExpenseViewModel {
    func insertData(model: NewExpenseModel) -> String {
        if let title = model.title,
           let price = model.price,
           let categoryId = model.categoryId,
           let expenseDate = model.expenseDate,
           !title.isEmpty,
           !price.isEmpty,
           !categoryId.isEmpty,
           !expenseDate.isEmpty {
            let dateManager = DateManager()
            let expenseSavingDate: String = dateManager.getCurrentDate(dateFormat: Constants.dateFormatYMDHMS)
            ExpenseRepository.shared.insertExpense(expense: Expense(expenseId: UUID().uuidString,
                                                                    title: title,
                                                                    price: Double(price)!,
                                                                    categoryId: categoryId,
                                                                    expenseDate: expenseDate,
                                                                    expenseSavingDate: expenseSavingDate,
                                                                    isDeleted: false))
            return "Good"
        }
        return "Bad"
    }
}
