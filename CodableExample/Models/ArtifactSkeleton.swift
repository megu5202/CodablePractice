import Foundation

class ArtifactSkeleton: Decodable {}

enum ArtifactType: String, Decodable {
    case program
    case collection
    case link
    case page
}

class Artifact {

}
