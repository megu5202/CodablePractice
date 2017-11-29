import Foundation

class SpacePagingSkeleton: Decodable {
    var offset: Int
    var count: Int
    var next_offset: Int?
    var total_count: Int
    
    private enum CodingKeys: String, CodingKey {
        case offset
        case count
        case next_offset
        case total_count
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        offset = try container.decode(Int.self, forKey: .offset)
        count = try container.decode(Int.self, forKey: .count)
        total_count = try container.decode(Int.self, forKey: .total_count)
        
        next_offset = try container.decode(Int?.self, forKey: .next_offset)
    }
}

struct SpaceSortingSkeleton: Decodable {
    var sort: String
    var order: String
}

struct SpaceMetaSkeleton: Decodable {
    var paging: SpacePagingSkeleton
    var sorting: SpaceSortingSkeleton
}

class SpaceSkeleton: Decodable {
    var posts: [PostSkeleton]
    var meta: SpaceMetaSkeleton
    
    private enum CodingKeys: String, CodingKey {
        case posts
        case meta
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        posts = try container.decode([PostSkeleton].self, forKey: .posts)
        meta = try container.decode(SpaceMetaSkeleton.self, forKey: .meta)
    }
}

struct Space {
    var id: Int?
    var name: String?
    
    var members: [User]?
    var ownerId: Int?
    var memberCount: Int?
    
    var posts: [Post]
    var postCount: Int
    var unreadPostCount: Int?
    
    var banner: Image?
    var dateUpdated: Date?
    var dateCreated: Date?
    var champion: Champion?
    var lastPost: Post?
    
    init(from skeleton: SpaceSkeleton) {
        posts = skeleton.posts.flatMap { Post(from: $0) }
        postCount = skeleton.posts.count
    }
}
