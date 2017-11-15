import Foundation

// MARK: View Model

struct ProgramSection {
    var id: Int
    var friendlyId: String
    var title: String
    var children: [ProgramSection]?
    var isBranching: Bool?
    var description: String?
    var kind: String?
}

extension ProgramSection {
    init(from skeleton: ProgramSectionSkeleton) {
        id = skeleton.id
        friendlyId = skeleton.friendly_id
        title = skeleton.title
        children = skeleton.children.flatMap { ProgramSection(from: $0) }
        isBranching = skeleton.prerequisite_ids.count > 0 && skeleton.skip_on_pending_prerequisites
        description = skeleton.description
        kind = skeleton.kind
    }
    
    init(from skeleton: RootSkeleton) {
        id = skeleton.id
        friendlyId = skeleton.friendly_id
        title = skeleton.title
        children = skeleton.children?.flatMap { ProgramSection(from: $0) }
        isBranching = skeleton.prerequisite_ids.count > 0 && skeleton.skip_on_pending_prerequisites
        description = skeleton.description
        kind = skeleton.kind
    }
}

extension ProgramSection: Hashable {
    var hashValue: Int {
        return id
    }
    
    static func ==(lhs: ProgramSection, rhs: ProgramSection) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: Skeleton Model

struct ProgramSectionSkeleton: Decodable {
    var id: Int
    var friendly_id: String
    var title: String
    var children: [ProgramSectionSkeleton]
    var skip_on_pending_prerequisites: Bool = false
    var prerequisite_ids: [Int]
    var description: String?
    var kind: String?
}


