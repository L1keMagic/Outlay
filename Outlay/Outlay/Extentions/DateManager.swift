import Foundation

class DateManager {
    func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter.string(from: Date())
    }
    func getFormattedDate(_ date: String) -> String {
        return date.toDateString(inputDateFormat: "yyyy-MM-dd'T'HH:mm:ssZ", ouputDateFormat: "d.MM.yyyy")
    }
}

extension String {
    func toDateString( inputDateFormat inputFormat: String,
                       ouputDateFormat outputFormat: String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = outputFormat
        return dateFormatter.string(from: date!)
    }
}
