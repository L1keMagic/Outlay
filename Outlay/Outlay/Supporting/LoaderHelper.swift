import Foundation

func loadExpenses() -> Expenses {
    var expenses: Expenses = []
    let expensesRaw: ExpensesRaw = load("ExpensesData.json")
    expensesRaw.forEach { item in
        expenses.append(convertExpenseToDto(expense: item))
    }
    return expenses
}

func convertExpenseToDto(expense: ExpenseRaw) -> Expense {
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
