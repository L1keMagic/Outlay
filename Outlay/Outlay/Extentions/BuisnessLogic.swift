import Foundation

func getBudget(period: Period) -> Int {
    let budget: Int
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
//func getMoneySpentAmountForPeriod(period: Period, expenses: Expenses) -> Double {
//    var summ = Double(0)
//    switch period {
//    case .today: do {
//        let dateInterval = Calendar.current.dateInterval(of: .day, for: Date())
//        for date in stride(from: dateInterval!.start, to: Date(), by: 60*60*24) {
//            let dailyExpenses = expenses.filter { $0.expenseDateParsed == date }
//            let spent = dailyExpenses.reduce(0) { $0 + $1.price }
//            summ += spent
//        }
//    }
//    case .week:
//        let dateInterval = Calendar.current.dateInterval(of: .weekOfMonth, for: Date())
//        for date in stride(from: dateInterval!.start, to: Date(), by: 60*60*24) {
//            let dailyExpenses = expenses.filter { $0.expenseDateParsed == date }
//            let spent = dailyExpenses.reduce(0) { $0 + $1.price }
//            summ += spent
//        }
//    case .month:
//        let dateInterval = Calendar.current.dateInterval(of: .month, for: Date())
//        for date in stride(from: dateInterval!.start, to: Date(), by: 60*60*24) {
//            let dailyExpenses = expenses.filter { $0.expenseDateParsed == date }
//            let spent = dailyExpenses.reduce(0) { $0 + $1.price }
//            summ += spent
//        }
//    }
//    return summ
// }
//
func getMoneySpentAmountForPeriod(period: Calendar.Component, expenses: Expenses) -> Double {
    var summ = Double(0)
    let dateInterval = Calendar.current.dateInterval(of: period, for: Date())
    for date in stride(from: dateInterval!.start, to: Date(), by: 60*60*24) {
        let dailyExpenses = expenses.filter { $0.expenseDateParsed == date }
        let spent = dailyExpenses.reduce(0) { $0 + $1.price }
        summ += spent
    }
    return summ
}
