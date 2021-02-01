import RxSwift

protocol AmountInputInteractorProtocol: class {
    func getBalance(for accountType: AccountType) -> Single<Balance>
}

class AmountInputInteractor: AmountInputInteractorProtocol {
    func getBalance(for accountType: AccountType) -> Single<Balance> {
        return BalanceService.instance.getBalance(for: accountType)
    }
}
