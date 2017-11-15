import Foundation

// Need a better name
struct OurDecoders {
    static var iso8601milliSeconds: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.ISO8601Formatter)
        return decoder
    }
}
