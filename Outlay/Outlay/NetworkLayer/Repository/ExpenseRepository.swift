import Foundation

class ExpenseRepository {
    static let shared = ExpenseRepository()
    var expenses: Expenses = []
    func getExpenses() -> Expenses {
        return expenses
    }
    func insertExpense(expense: Expense) {
        expenses.append(expense)
    }
}
