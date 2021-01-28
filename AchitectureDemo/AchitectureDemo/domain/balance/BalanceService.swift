import RxSwift

protocol BalanceServiceProtocol {
    func getBalance(for accountType: AccountType) -> Single<Balance>
}

class BalanceService: BalanceServiceProtocol {
    static let instance = BalanceService()
    
    private init() { }
    
    func getBalance(for accountType: AccountType) -> Single<Balance> {
        let testAmount = Money(value: 100.0, currency: Currency(iso: "EUR"))
        return Single.just(Balance(amount: testAmount))
    }
}

