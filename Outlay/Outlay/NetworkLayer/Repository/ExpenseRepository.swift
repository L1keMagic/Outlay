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

func loadExpenses() -> Expenses {
    var expenses: Expenses = []
    let expensesRaw: ExpensesRaw = load("ExpensesData.json")
    expensesRaw.forEach { item in
        expenses.append(convertExpenseToDto(expense: item))
    }
    return expenses
}

private func convertExpenseToDto(expense: ExpenseRaw) -> Expense {
    return Expense(expenseId: expense.expenseId,
                   title: expense.title,
                   price: expense.price,
                   categoryId: expense.categoryId,
                   categoryTitle: CategoryRepository.shared.getCategoryById(categoryId:
                                                                                expense.categoryId)?.title ?? "",
                   categoryImage: CategoryRepository.shared.getCategoryById(categoryId:
                                                                                expense.categoryId)?.image ?? "",
                   expenseDate: expense.expenseDate, expenseSavingDate: expense.expenseSavingDate)
}
