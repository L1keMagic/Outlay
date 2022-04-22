import Foundation

class DateManager {
    func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d.MM.yyyy"
        return formatter.string(from: Date())
    }
}
