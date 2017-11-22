import Foundation

enum MarkupType: String, Decodable { case Mention }

struct MarkupTokenSkeleton: Decodable {
    var type: MarkupType
    var reference_type: OwnerType
    var reference_id: Int?
    var indices: [Int]
    var reference_display: String
    var reference_match: String
}

struct MarkupToken {
    var type: MarkupType
    var referenceType: OwnerType
    var referenceId: Int?
    var range: Range<Int>
    var displayName: String
    var targetName: String
    
    init(from skeleton: MarkupTokenSkeleton) {
        type = skeleton.type
        referenceType = skeleton.reference_type
        referenceId = skeleton.reference_id
        range = skeleton.indices.first! ..< skeleton.indices.last!
        displayName = skeleton.reference_display
        targetName = skeleton.reference_match
    }
}
