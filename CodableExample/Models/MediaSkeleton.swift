import Foundation

protocol MediaMetaSkeleton {}

class MediaSkeleton: Decodable {
    var id: Int
    var src: URL
    
    private enum MediaType: String, Decodable {
        case image, video, audio, pdf
    }
    
    private var media_type: MediaType
    
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
        let srcString = try container.decode(String.self, forKey: .src)
        src = URL(from: srcString)
        
        switch media_type {
        case .image:
            meta = try container.decode(ImageMetaSkeleton.self, forKey: .meta)
        default:
            meta = try container.decode(ImageMetaSkeleton.self, forKey: .meta)
        }
    }
}
