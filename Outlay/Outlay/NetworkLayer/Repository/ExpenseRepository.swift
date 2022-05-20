import Foundation

class ExpenseRepository {
    static let shared = ExpenseRepository()
    private var expenses: Expenses = loadExpenses()
    func getExpenses() -> Expenses {
        return expenses
    }
    func getExpensesByCategorId(categoryId: String) -> Expenses {
        return expenses.filter { $0.categoryId == categoryId }
    }
    func insertExpense(expense: ExpenseRaw) {
        // additionally send request to write data
        expenses.append(convertExpenseToDto(expense: expense))
    }
}
