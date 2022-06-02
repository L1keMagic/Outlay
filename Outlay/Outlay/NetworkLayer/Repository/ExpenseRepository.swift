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
        Logger.information(message: "Attempt to group expenses")
        let groupedExpensesByCertainDate = Dictionary(grouping: expenses) { (expense) -> Date in
            return dateManager.convertDateFormat(date: expense.expenseDate, outputFormat: Constants.dateFormatDMY)

        }
        let keyDates = groupedExpensesByCertainDate.keys.sorted(by: >)
        keyDates.forEach({
            groupedExpenses.append(groupedExpensesByCertainDate[$0]!)
        })
        return groupedExpenses
    }
    func clearGroupedExpenses() {
        groupedExpenses.removeAll()
    }
}
