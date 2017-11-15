import Foundation

// MARK: View Model

struct Program {
    var id: Int
    var friendlyId: String
    var title: String
    var dateCreated: Date
    var dateUpdated: Date
    var banner: Image
    var champion: Champion
    var isLegacyRendered: Bool
    
    var requesterHasReviewed: Bool
    var reviews: [Review]?
    var averageRating: Int?
    var ratingsCount: Int?
    
    var numberOfSections: Int
    
    var overviewSection: ProgramSection
    var contentSections: [ProgramSection]
    var sections: [ProgramSection]
    
    func linearizedSections() -> [ProgramSection] {
        return linearizeSections(sections)
    }
}

extension Program {
    init(from skeleton: ProgramSkeleton) {
        id = skeleton.id
        friendlyId = skeleton.friendly_id
        title = skeleton.title
        dateCreated = skeleton.created_at
        dateUpdated = skeleton.updated_at
        banner = Image(from: skeleton.banner)
        champion = Champion(from: skeleton.champion)
        
        isLegacyRendered = skeleton.rendering == "webview" ? true : false

        requesterHasReviewed = skeleton.requestor_has_reviewed
        reviews = skeleton.reviews.flatMap { Review(from: $0) }
        averageRating = skeleton.reviews_average_rating
        ratingsCount = skeleton.reviews_ratings_count
        numberOfSections = skeleton.section_count
        
        overviewSection = ProgramSection(from: skeleton.root)
        contentSections = skeleton.root.outline.children.flatMap { ProgramSection(from: $0) }
        sections = [overviewSection]
        sections.append(contentsOf: contentSections)
    }
    
    private func linearizeSections(_ sections: [ProgramSection]) -> [ProgramSection] {
        let reduced = sections.reduce([ProgramSection]()) { current, next in
            var copy = current
            copy.append(next)
            
            if let sections = next.children {
                copy.append(contentsOf: linearizeSections(sections))
            }
            return copy
        }
        return reduced
    }
}

// MARK: Skeleton Models

struct OutlineSkeleton: Decodable {
    var id: Int
    var children: [ProgramSectionSkeleton]
}

struct RootSkeleton: Decodable {
    var outline: OutlineSkeleton
    
    var id: Int
    var friendly_id: String
    var title: String
    var children: [ProgramSectionSkeleton]?
    var skip_on_pending_prerequisites: Bool = false
    var prerequisite_ids: [Int]
    var description: String?
    var kind: String?
}

struct ProgramSkeleton: Decodable {
    var id: Int
    var friendly_id: String
    var title: String
    var description: String
    var created_at: Date
    var updated_at: Date
    var banner: MediaSkeleton
    var champion: ChampionSkeleton
    var rendering: String
    var outcomes: [String]
    
    var requestor_has_reviewed: Bool // 'requestOr' should be 'requestEr' TYPO FROM THE BACKEND
    var reviews_average_rating: Int
    var reviews_ratings_count: Int
    var reviews: [ReviewSkeleton]
    
    var section_count: Int
    var root: RootSkeleton
}
