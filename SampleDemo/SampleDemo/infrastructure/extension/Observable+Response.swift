import RxSwift
import Foundation

extension Response {

    func mapObject<T: Decodable>(_ type: T.Type, path: String? = nil) throws -> T {
        do {
            let data = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            let decoder = JSONDecoder()
            return try! decoder.decode(T.self, from: data)
        } catch {
            throw RxError.unknown
        }
    }
}

extension ObservableType where Element == Response {
    func mapObject<T: Codable>(_ type: T.Type, _ path: String? = nil) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            Observable.just(try response.mapObject(type, path: path))
        }
    }
}
