import Foundation

protocol MediaMetaSkeleton {}

enum MediaType: String, Decodable {
    case image, video, audio, pdf
}

class MediaSkeleton: Decodable {
    var id: Int
    var media_type: MediaType
    var src: URL
    var meta: MediaMetaSkeleton
    
    private enum CodingKeys: String, CodingKey {
        case id
        case media_type
        case src
        case meta
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        media_type = try container.decode(MediaType.self, forKey: .media_type)
        src = try container.decode(URL.self, forKey: .src)
        
        switch media_type {
        case .image:
            meta = try container.decode(ImageMetaSkeleton.self, forKey: .meta)
        default:
            meta = try container.decode(ImageMetaSkeleton.self, forKey: .meta)
        }
        
    }
}
