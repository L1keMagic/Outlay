import Foundation

class ExpenseRepository {
    static let shared = ExpenseRepository()
    var expenses: Expenses = []
    func getExpenses() -> Expenses {
        // this condition will be removed when we add 'add' functionality
        if expenses.isEmpty {
            let dateManager = DateManager()
            expenses.append(Expense(id: 1,
                                    title: "Хлеб",
                                    price: 100,
                                    categoryId: nil,
                                    creationDate: dateManager.getCurrentDate()))
            expenses.append(Expense(id: 2,
                                    title: "Соль",
                                    price: 15000,
                                    categoryId: nil,
                                    creationDate: dateManager.getCurrentDate()))
            expenses.append(Expense(id: 3,
                                    title: "Пицца",
                                    price: 123,
                                    categoryId: nil,
                                    creationDate: dateManager.getCurrentDate()))
        }
        return expenses
    }
}
