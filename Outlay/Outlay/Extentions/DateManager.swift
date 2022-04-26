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
}
