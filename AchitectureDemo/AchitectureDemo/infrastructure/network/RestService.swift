import RxSwift
import Foundation

// TODO: Request and Response should be URLRequest, or Moya.Request etc.
struct Request {
}

struct Response {
    var body: [String: Any]
}

class RestService {
    static let instance = RestService()
    
    private init() { }
    
    func request(_ request: Request) -> Observable<Response> {
        // TODO: Perform Request Alamofire, URLSession etc.
        let body = ["availableAmount": ["value": "100.0", "currency": "EUR"]]
        let response = Response(body: body)
        
        return Observable.just(response)
    }
}
