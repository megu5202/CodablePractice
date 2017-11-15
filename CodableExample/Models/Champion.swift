import Foundation

// MARK: Skeleton Model


struct ChampionSkeleton: Decodable {
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
    var description: String
    var dateCreated: Date
    var dateUpdated: Date
    var banner: Image
    var avatar: Image
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
}
