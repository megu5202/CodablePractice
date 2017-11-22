import Foundation

enum PostableType: String, Decodable {
    case Space
    case Timeline
}

enum PostType: String, Decodable {
    case activity
    case post = "default"
}

enum ActivityType: String, Decodable {
    case comment
}

enum OwnerType: String, Decodable {
    case User
    case Champion
}

class PostSkeleton: Decodable {
    var id: Int
    var postable_id: Int
    var postable_type: PostableType
    var post_type: PostType
    var activity_type: ActivityType?
    var body: String
    var links: [URL]
    var markup_tokens: [MarkupTokenSkeleton]
    var created_at: Date
    var updated_at: Date
    var comments_count: Int
    var artifact: ArtifactSkeleton?
    
    var user_id: Int
    var user: UserSkeleton
    var owner_id: Int
    var owner_type: OwnerType
    var owner: OwnerSkeleton
    var linkable_id: Int?
    var linkable_owner_type: OwnerType?
    var linkable_owner: OwnerSkeleton?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case postable_id
        case postable_type
        case post_type
        case activity_type
        case body
        case links
        case markup_tokens
        case created_at
        case updated_at
        case comments_count
        case artifact

        case user_id
        case user
        case owner_id
        case owner_type
        case owner
        case linkable_id
        case linkable_owner_type
        case linkable_owner
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        
        postable_id = try container.decode(Int.self, forKey: .postable_id)
        postable_type = try container.decode(PostableType.self, forKey: .postable_type)
        post_type = try container.decode(PostType.self, forKey: .post_type)
        
        body = try container.decode(String.self, forKey: .body)
        links = try container.decode([URL].self, forKey: .links)
        markup_tokens = try container.decode([MarkupTokenSkeleton].self, forKey: .markup_tokens)
        created_at = try container.decode(Date.self, forKey: .created_at)
        updated_at = try container.decode(Date.self, forKey: .updated_at)
        user_id = try container.decode(Int.self, forKey: .user_id)
        user = try container.decode(UserSkeleton.self, forKey: .user)
        
        artifact = try container.decode(ArtifactSkeleton?.self, forKey: .artifact)
        comments_count = try container.decode(Int.self, forKey: .comments_count)
        
        owner_id  = try container.decode(Int.self, forKey: .owner_id)
        owner_type = try container.decode(OwnerType.self, forKey: .owner_type)
        switch (owner_type, postable_type) {
        case (.Champion, .Timeline):
            owner = try container.decode(ChampionForTimelineSkeleton.self, forKey: .owner)
        default:
            owner = try container.decode(UserSkeleton.self, forKey: .owner)
        }
        
        do {
            activity_type = try container.decode(ActivityType.self, forKey: .activity_type)
            linkable_id = try container.decode(Int.self, forKey: .linkable_id)
            linkable_owner_type = try container.decode(OwnerType.self, forKey: .linkable_owner_type)
            
            if let linkableOwnerType = linkable_owner_type {
                switch (linkableOwnerType, postable_type) {
                case (.Champion, .Timeline):
                    linkable_owner = try container.decode(ChampionForTimelineSkeleton.self, forKey: .linkable_owner)
                default:
                    linkable_owner = try container.decode(UserSkeleton.self, forKey: .linkable_owner)
                }
            }
        } catch {
            activity_type = nil
            linkable_id = nil
            linkable_owner_type = nil
        }
    }
}

struct Post {
    var id: Int
    var user: User
    var body: String
    var artifactType: ArtifactType?
    var artifact: Artifact?
    var commentCount: Int
//    var comments: [Comment]
//    var linkable: String
    var markupTokens: [MarkupToken]
    var dateCreated: Date
    var dateUpdated: Date
    
    init(from skeleton: PostSkeleton) {
        id = skeleton.id
        user = User(from: skeleton.user)
        body = skeleton.body
        commentCount = skeleton.comments_count
        markupTokens = skeleton.markup_tokens.flatMap { MarkupToken(from: $0) }
        dateCreated = skeleton.created_at
        dateUpdated = skeleton.updated_at
    }
    
}


