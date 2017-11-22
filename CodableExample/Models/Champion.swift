import Foundation

// MARK: Skeleton Models

struct ChampionForTimelineSkeleton: Decodable, OwnerSkeleton {
    var id: Int
    var name: String
    var created_at: Date
    var updated_at: Date
    var icon: MediaSkeleton
}

struct ChampionSkeleton: Decodable, OwnerSkeleton {
    var id: Int
    var name: String
    var description: String
    var created_at: Date
    var updated_at: Date
    var banner: MediaSkeleton
    var icon: MediaSkeleton
    var website: URL?
}

// MARK: View Model

struct Champion {
    var id: Int
    var name: String
    var dateCreated: Date
    var dateUpdated: Date
    var avatar: Image
    
    var description: String?
    var banner: Image?
    var website: URL?
}

extension Champion {
    init(from skeleton: ChampionSkeleton) {
        id = skeleton.id
        name = skeleton.name
        description = skeleton.description
        dateCreated = skeleton.created_at
        dateUpdated = skeleton.updated_at
        website = skeleton.website
        banner = Image(from: skeleton.banner)
        avatar = Image(from: skeleton.icon)
    }
    
    init(from skeleton: ChampionForTimelineSkeleton) {
        id = skeleton.id
        name = skeleton.name
        description = nil
        dateCreated = skeleton.created_at
        dateUpdated = skeleton.updated_at
        banner = nil
        avatar = Image(from: skeleton.icon)
        website = nil
    }
}
