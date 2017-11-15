import Foundation

struct ChampionRequests {
    static func getChampion(withId id: Int) -> APIRequest {
        return APIRequest
            .get
            .host("raw.githubusercontent.com")
            .path("/megu\(id)/CodablePractice/master/CodableExample/Data/champion.json")
    }
}
