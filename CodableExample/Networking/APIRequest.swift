import Foundation

final class APIRequest {

    let httpMethod: HTTPMethod

    private var host: String = "github.com"
    private var path: String = "/"
    private var queryParameters = [URLQueryItem]()
    private var body: Data?

    private init(httpMethod: HTTPMethod) {
        self.httpMethod = httpMethod
    }

    // MARK: Initialization

    static var get: APIRequest {
        return APIRequest(httpMethod: .get)
    }

    static var post: APIRequest {
        return APIRequest(httpMethod: .post)
    }

    // MARK: Builders

    func host(_ host: String) -> APIRequest {
        self.host = host
        return self
    }

    func path(_ path: String) -> APIRequest {
        self.path = path
        return self
    }

    func queryParameters(_ params: [URLQueryItem]) -> APIRequest {
        self.queryParameters = params
        return self
    }

    func body(_ body: Data) -> APIRequest {
        self.body = body
        return self
    }

    // MARK: Request

    func request() -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path

        if queryParameters.isEmpty == false {
            urlComponents.queryItems = queryParameters
        }

        guard let urlComponentsURL = urlComponents.url else { fatalError("Could not create a url with the components: \(urlComponents)") }

        var request = URLRequest(url: urlComponentsURL)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body

        return request
    }
}
