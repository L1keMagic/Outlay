import Foundation

class ExpenseRepository {
    static let shared = ExpenseRepository()
    var expenses: Expenses = load("ExpensesData.json")
    func getExpenses() -> ExpensesDto {
        var preparedExpenses: ExpensesDto = []
        expenses.forEach { item in
            preparedExpenses.append(ExpenseDto(expenseId: item.expenseId,
                                               title: item.title,
                                               price: item.price,
                                               categoryTitle: CategoryRepository.shared.getCategoryById(categoryId: item.categoryId)?.title ?? "",
                                               categoryImage: CategoryRepository.shared.getCategoryById(categoryId: item.categoryId)?.image ?? "",
                                               expenseDate: item.expenseDate,
                                               expenseSavingDate: item.expenseSavingDate))
        }
        return preparedExpenses
    }
    func getExpensesByCategorId(categoryId: String) -> Expenses {
        return expenses.filter { $0.categoryId == categoryId }
    }
    func insertExpense(expense: Expense) {
        expenses.append(expense)
    }
}
