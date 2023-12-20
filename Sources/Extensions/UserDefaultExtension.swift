import UIKit

extension UserDefaults {
    func safeSet<T: CustomStringConvertible>(_ value: T, for key: String) {
        let str = String(describing: value)
        self.safeSet(str, for: key)
    }

    func safeSet(_ str: String, for key: String) {
        let encrypted = str.aesEncrypt()
        self.set(encrypted, forKey: key)
    }

    func safeSet(_ value: Date, for key: String, dateFormatter: DateFormatter = UserDefaults.defaultDateFormatter) {
        let str = dateFormatter.string(from: value)
        self.safeSet(str, for: key)
    }

    func safeDate(for key: String, dateFormatter: DateFormatter = UserDefaults.defaultDateFormatter) -> Date? {
        guard
            let value = self.string(forKey: key),
            let decodedString = value.aesDecrypt()
        else { return nil }

        return dateFormatter.date(from: decodedString)
    }

    func safeString(forKey: String) -> String {
        guard
            let value = self.string(forKey: forKey),
            let decrypted = value.aesDecrypt()
        else { return "" }
        return decrypted
    }

    func safeInt(forKey: String, defaultVal: Int = 0) -> Int {
        guard let value = Int(self.safeString(forKey: forKey)) else { return defaultVal }
        return value
    }

    static var defaultDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter
    }
}
