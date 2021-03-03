import RxSwift
import Foundation

class DepoManager {
    func getDepoBalance(completionHandler: @escaping (Result<Balance, Error>) -> Void) {
        let balance = Balance(amount: Money(value: 5128, currency: Currency(iso: "EUR")))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completionHandler(.success(balance))
        }
    }
}
