import Foundation

protocol AmountInputPresenterProtocol {
    func onNextButtonTouched(amount: Money)
}

class AmountInputPresenter {
    weak var view: AmountInputViewProtocol?
    weak var interactor: AmountInputInteractorProtocol?
    
    private let nextHandler: ((Money) -> Void)?
    
    init(nextHandler: ((Money) -> Void)?) {
        self.nextHandler = nextHandler
    }
    
    // MARK: AmountInputPresenterProtocol
    
    func onNextButtonTouched(amount: Money) {
        nextHandler?(amount)
    }
}
