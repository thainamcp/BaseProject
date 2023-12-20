import Foundation

extension Date {
    static func localDate() -> Date {
        let dateFormat = "yyyy-MM-dd HH:mm:ss"
        let now = Date()
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = dateFormat
        return formatter.date(from: now.toCurrentLocal(format: dateFormat)) ?? Date()
    }

    func toCurrentLocal(format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
