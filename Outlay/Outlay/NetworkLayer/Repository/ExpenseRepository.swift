import Foundation

class ExpenseRepository {
    static let shared = ExpenseRepository()
    private var expenses: Expenses = loadExpenses()
    private var groupedExpenses = [Expenses]()
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
    func getExpensesByDate(expenseDate: String) -> Expenses {
        return (expenses.filter { $0.expenseDate == expenseDate }).sorted {
            $0.expenseSavingDate < $1.expenseSavingDate
        }
    }
    func getGroupedExpenses() -> [Expenses] {
        let dateManager = DateManager()
        print("attempt to group expenses")
        let groupedByDate = Dictionary(grouping: expenses) { (expense) -> Date in
            return dateManager.convertDateFormat(date: expense.expenseDate, outputFormat: Constants.dateFormatDMY)

        }
        let keys = groupedByDate.keys.sorted(by: >)
        keys.forEach({
            groupedExpenses.append(groupedByDate[$0]!)
        })
        return groupedExpenses
    }
    func clearGroupedExpenses() {
        groupedExpenses = [Expenses]()
    }
}
