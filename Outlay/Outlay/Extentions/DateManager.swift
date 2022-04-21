import Foundation

class DateManager {
    func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm"
        return formatter.string(from: Date())
    }
}
