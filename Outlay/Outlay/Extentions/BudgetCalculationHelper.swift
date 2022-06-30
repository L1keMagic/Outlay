import Foundation

class BudgetCalculationHelper {
    func getBudget(period: Period) -> Double {
        let budget: Double
        switch period {
        case .today:
            budget = 42000/31
        case .week:
            budget = 42000/31*7
        case .month:
            budget = 42000
        }
        return budget
    }
    func getMoneySpentAmountForPeriod(period: Calendar.Component, expenses: Expenses) -> Double {
        var totalAmount: Double = 0
        let dateInterval = Calendar.current.dateInterval(of: period, for: Date())
        for date in stride(from: dateInterval!.start, to: Date(), by: Constants.strideDayIncrement) {
            let dailyExpenses = expenses.filter { $0.expenseDateParsed == date }
            let spent = dailyExpenses.reduce(0) { $0 + $1.price }
            totalAmount += spent
        }
        return totalAmount
    }
}
