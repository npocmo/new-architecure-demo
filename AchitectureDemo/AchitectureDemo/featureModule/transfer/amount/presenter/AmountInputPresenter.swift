import Foundation
import RxSwift

protocol AmountInputPresenterProtocol {
    func viewDidLoad()
    func onNextButtonTouched(amount: Money)
}

class AmountInputPresenter {
    weak var view: AmountInputViewProtocol?
    var interactor: AmountInputInteractorProtocol?
    
    private let nextHandler: ((Money) -> Void)?
    private let disposeBag = DisposeBag()
    
    init(nextHandler: ((Money) -> Void)?) {
        self.nextHandler = nextHandler
    }
    
    // MARK: AmountInputPresenterProtocol
    
    func viewDidLoad() {
        interactor?.getBalance(for: .giro)
            .subscribe(
                onSuccess: { [weak self] balance in
                    self?.view?.updateView(viewState: .dataLoaded(balance: balance))
                },
                onFailure: { [weak self] error in
                    self?.view?.updateView(viewState: .availableAmountFetchFailed)
                }
            )
            .disposed(by: disposeBag)
    }
    
    func onNextButtonTouched(amount: Money) {
        nextHandler?(amount)
    }
}
