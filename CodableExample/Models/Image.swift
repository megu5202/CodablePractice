import Foundation
import UIKit

// MARK: View Model

class Image {
    var id: Int
    var sourceURL: URL
    
    var width: Int
    var height: Int
    var formatExtension: String
    var predominantColor: UIColor
    
    required init(from skeleton: MediaSkeleton) {
        id = skeleton.id
        sourceURL = skeleton.src
        
        guard let meta = skeleton.meta as? ImageMetaSkeleton else {
            fatalError("Image must be initialized with an ImageMetaSkeleton (ensure you are not passing a different media type).")
        }
        width = meta.width
        height = meta.height
        formatExtension = meta.format
        
        let mostPredominantColor = meta.colors[0]
        let predominantColorHexString = mostPredominantColor.hex
        predominantColor = UIColor(hex: predominantColorHexString)
    }
}

// MARK: Skeleton Models

struct ColorPredominanceSkeleton: Decodable {
    var hex: String
    var percent: Float
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        hex = try container.decode(String.self)
        percent = try container.decode(Float.self)
    }
}

struct ImageMetaSkeleton: Decodable, MediaMetaSkeleton {
    var width: Int
    var height: Int
    var format: String
    var colors: [ColorPredominanceSkeleton]
}
