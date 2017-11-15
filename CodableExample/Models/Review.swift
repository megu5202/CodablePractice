import Foundation

struct ReviewUserSkeleton: Decodable {
    var name: String
    var avatar_url: URL?
}

// MARK: Skeleton Model

struct ReviewSkeleton: Decodable {
    var id: Int
    var user_id: Int
    var rating: Int
    var description: String
    var reviewed_item_id: Int
    var created_at: Date
    var updated_at: Date
    var user: ReviewUserSkeleton
    var title: String?
}

// MARK: View Model

struct Review {
    var id: Int
    var userId: Int
    var userName: String
    var userAvatarURL: URL?
    var rating: Int
    var description: String
    var reviewedItemId: Int
    var dateCreated: Date
    var dateUpdated: Date
    var title: String?
}

extension Review {
    init(from skeleton: ReviewSkeleton) {
        id = skeleton.id
        userId = skeleton.user_id
        userName = skeleton.user.name
        userAvatarURL = skeleton.user.avatar_url
        rating = skeleton.rating
        description = skeleton.description
        reviewedItemId = skeleton.reviewed_item_id
        dateCreated = skeleton.created_at
        dateUpdated = skeleton.updated_at
        title = skeleton.title
    }
}
