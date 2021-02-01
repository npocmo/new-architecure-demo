import RxSwift
import Foundation

protocol BalanceServiceProtocol {
    func getBalance(for accountType: AccountType) -> Single<Balance>
}

class BankingTarget {
    private let api: BankingAPI
    
    init(_ api: BankingAPI) {
        self.api = api
    }
    
    func getRequest() -> Request {
        // TODO: create Request
        return Request()
    }
}

enum BankingAPI {
    case getBalance(_ accountType: AccountType)
}

class BalanceService: BalanceServiceProtocol {
    static let instance = BalanceService()
    
    private let restSevice = RestService.instance
    
    private init() { }
    
    func getBalance(for accountType: AccountType) -> Single<Balance> {
        return restSevice.request(BankingTarget(.getBalance(accountType)).getRequest())
            .mapObject(BalanceData.self)
            .flatMap { balanceData -> Observable<Balance> in
                guard let result = self.mapToBalance(balanceData) else {
                    return Observable.error(RxError.noElements)
                }
                return Observable.just(result)
            }.asSingle()
    }
    
    private func mapToBalance(_ data: BalanceData) -> Balance? {
        guard
            let amount = data.availableAmount?.value,
            let currency = data.availableAmount?.currency,
            let value = Decimal(string: amount) else {
            return nil
        }
        
        let availableAmount = Money(value: value, currency: Currency(iso: currency))
        return Balance(amount: availableAmount)
    }
}

