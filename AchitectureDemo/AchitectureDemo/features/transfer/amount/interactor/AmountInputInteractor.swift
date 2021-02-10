import RxSwift

protocol AmountInputInteractorProtocol {
    func getAvailableBalance(for: AccountType) -> Single<Balance>
}

class AmountInputInteractor: AmountInputInteractorProtocol {
    
    private let balanceService: BalanceServiceProtocol
    
    init(balanceService: BalanceServiceProtocol = ServiceLocator.instance.balanceService) {
        self.balanceService = balanceService
    }
    
    // MARK: AmountInputInteractorProtocol
    
    func getAvailableBalance(for accountType: AccountType) -> Single<Balance> {
        return balanceService.getBalance(for: accountType)
    }
}
