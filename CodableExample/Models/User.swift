import Foundation

protocol OwnerSkeleton {}

struct UserSkeleton: Decodable, OwnerSkeleton {
    var id: Int
    var username: String
    var first_name: String
    var last_name: String
    var name: String
    var avatar: MediaSkeleton?
    var banner: MediaSkeleton?
}

struct User {
    var id: Int
    var username: String
    var firstName: String
    var lastName: String
    var displayName: String
    var avatar: Image?
    var banner: Image?
    
    init(from skeleton: UserSkeleton) {
        id = skeleton.id
        username = skeleton.username
        firstName = skeleton.first_name
        lastName = skeleton.last_name
        displayName = skeleton.name
        
        if let avatarSkeleton = skeleton.avatar {
            avatar = Image(from: avatarSkeleton)
        }
        
        if let bannerSkeleton = skeleton.banner {
            banner = Image(from: bannerSkeleton)
        }
    }
}


