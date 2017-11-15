import Foundation

final class APIRequestOperation: Operation {

    override var isAsynchronous: Bool { return true }

    let request: APIRequest

    var data: Data?
    var error: Error?

    private var task: URLSessionDataTask?

    init(request: APIRequest) {
        self.request = request
        super.init()
        qualityOfService = .userInitiated
    }

    override func main() {
        guard isCancelled == false else {
            isFinished = true
            return
        }

        task = URLSession.shared.dataTask(with: request.request()) { (data, response, error) in
            guard self.isCancelled == false else {
                self.isFinished = true
                return
            }

            self.data = data
            self.error = error

            self.isFinished = true
        }

        task?.resume()
    }

    override func cancel() {
        task?.cancel()
    }
 }
