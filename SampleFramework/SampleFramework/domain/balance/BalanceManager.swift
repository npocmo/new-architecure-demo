import RxSwift
import Foundation

class BalanceManager {
    func getGiroBalance(completionHandler: @escaping (Result<Balance, Error>) -> Void) {
        let balance = Balance(amount: Money(value: 3725, currency: Currency(iso: "EUR")))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            completionHandler(.success(balance))
        }
    }
}
