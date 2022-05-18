import Foundation

class ExpenseRepository {
    static let shared = ExpenseRepository()
    var expenses: Expenses = load("ExpensesData.json")
    func getExpenses() -> Expenses {
        return expenses
    }
    func getExpensesByCategorId(categoryId: String) -> Expenses {
        return expenses.filter { $0.categoryId == categoryId }
    }
    func insertExpense(expense: Expense) {
        expenses.append(expense)
    }
}
