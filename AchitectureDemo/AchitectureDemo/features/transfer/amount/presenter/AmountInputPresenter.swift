import Foundation
import RxSwift

protocol AmountInputPresenterProtocol {
    func onViewDidLoad()
    func onNextButtonTouched(amount: String?)
}

class AmountInputPresenter: AmountInputPresenterProtocol {
    private weak var view: AmountInputViewProtocol?
    private var interactor: AmountInputInteractorProtocol?
    private let nextHandler: ((Money) -> Void)?
    private let balanceService: BalanceServiceProtocol?
    private let disposeBag = DisposeBag()
    
    init(
        view: AmountInputViewProtocol?,
        interactor: AmountInputInteractorProtocol?,
        balanceService: BalanceServiceProtocol? = serviceLocator.balanceService,
        nextHandler: ((Money) -> Void)?
    ) {
        self.view = view
        self.interactor = interactor
        self.balanceService = balanceService
        self.nextHandler = nextHandler
    }
    
    // MARK: AmountInputPresenterProtocol
    
    func onViewDidLoad() {
        interactor?.getAvailableBalance(for: .giro)
            .map(mapToAmountInputBalanceViewModel)
            .subscribe(
                onSuccess: { [weak self] balance in
                    self?.view?.updateView(viewState: .updateAvailableAmount(balance: balance))
                },
                onFailure: { [weak self] error in
                    self?.view?.updateView(viewState: .availableAmountFetchFailed)
                }
            )
            .disposed(by: disposeBag)
    }
    
    func onNextButtonTouched(amount: String?) {
        guard let amount = amount, let amountAsDecimal = Decimal(string: amount) else {
            return
        }
        let money = Money(value: amountAsDecimal, currency: Currency.init(iso: "EUR"))
        nextHandler?(money)
    }
    
    // MARK: Mapping
    
    private func mapToAmountInputBalanceViewModel(balance: Balance) -> AmountInputBalanceViewModel {
        return AmountInputBalanceViewModel(amount: balance.amount.value.description + " " +  balance.amount.currency.iso)
    }
}
