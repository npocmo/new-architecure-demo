import RxSwift
import Foundation

protocol BalanceServiceProtocol {
    func getBalance(for accountType: AccountType) -> Single<Balance>
}

class BalanceService: BalanceServiceProtocol {
    
    private let restSevice: RestServiceProtocol
    
    init(restSevice: RestServiceProtocol) {
        self.restSevice = restSevice
    }
    
    func getBalance(for accountType: AccountType) -> Single<Balance> {
        return restSevice.request(BalanceRequest())
            .mapObject(BalanceData.self)
            .flatMap(mapToBalance)
            .asSingle()
    }
    
    private func mapToBalance(_ data: BalanceData?) -> Observable<Balance> {
        guard
            let data = data,
            let amount = data.availableAmount?.value,
            let currency = data.availableAmount?.currency,
            let value = Decimal(string: amount) else {
            return Observable.error(RxError.noElements)
        }
        
        let availableAmount = Money(value: value, currency: Currency(iso: currency))
        return Observable.just(Balance(amount: availableAmount))
    }
}

