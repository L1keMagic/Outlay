import Foundation

class DateManager {
    func getCurrentDateUTC() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter.string(from: Date())
    }
    func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d.MM.yyyy"
        return formatter.string(from: Date())
    }
    func getFormattedDate(_ dateToFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: dateToFormat)
        dateFormatter.dateFormat = "d.MM.yyyy"
        return dateFormatter.string(from: date!)
    }
}
