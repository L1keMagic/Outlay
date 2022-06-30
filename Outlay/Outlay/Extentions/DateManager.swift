import Foundation

class DateManager {
    func getCurrentDate(dateFormat: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: Date())
    }
    func convertDateFormat(date: Date, outputFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = outputFormat
        return dateFormatter.string(from: date)
    }
    func convertDateFormat(date: String, outputFormat: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = outputFormat
        return dateFormatter.date(from: date)!
    }
}
enum Period {
    case today, week, month
}
extension Date: Strideable {
}
