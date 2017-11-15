import Foundation

extension DateFormatter {
    static let ISO8601Formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        let enUSPOSIXLocale = Locale(identifier: "en_US_POSIX")
        dateFormatter.locale = enUSPOSIXLocale
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        return dateFormatter
    }()
}
