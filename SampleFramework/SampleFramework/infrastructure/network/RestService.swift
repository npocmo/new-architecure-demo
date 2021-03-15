import RxSwift
import Foundation

// TODO: Request and Response should be URLRequest, or Moya.Request etc.
protocol Request {
}

struct Response {
    var body: [String: Any]
}

protocol RestServiceProtocol {
    func request(_ request: Request) -> Observable<Response>
}

class RestService: RestServiceProtocol {
    func request(_ request: Request) -> Observable<Response> {
        // TODO: Perform Request Alamofire, URLSession etc.
        let body = ["availableAmount": ["value": "100.0", "currency": "EUR"]]
        let response = Response(body: body)
        
        return Observable.just(response)
    }
}
