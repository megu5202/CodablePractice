import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

final class ChampionService {

    typealias ServiceCompletion<T> = (Result<T>) -> Void

    private let operationQueue = OperationQueue()

    func getChampion(byId id: Int, completion: ServiceCompletion<Champion>?) {
        let request = ChampionRequests.getChampion(withId: id)
        let operation = APIRequestOperation(request: request)
        operation.completionBlock = { [unowned operation] in
            if let error = operation.error {
                completion?(.failure(error))
                return
            }

            if let data = operation.data {
                do {
                    let championSkeleton = try OurDecoders.iso8601milliSeconds.decode(ChampionSkeleton.self, from: data)
                    let champion = Champion(from: championSkeleton)

                    completion?(.success(champion))
                } catch {
                    completion?(.failure(error))
                }
            }
        }

        operationQueue.addOperation(operation)
    }
}
