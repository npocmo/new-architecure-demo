import Foundation
import RxSwift

struct TransferModel {
    var sourceIban: String
    var targetIban: String
    var amount: Money
}

protocol SummaryPresenterProtocol {
    func viewDidLoad()
}

class SummaryPresenter: SummaryPresenterProtocol {
    private weak var view: SummaryViewProtocol?
    
    private let nextHandler: (() -> Void)?
    private let disposeBag = DisposeBag()
    private let transferService: TransferServiceProtocol?
    private let model: TransferModel
    
    init(
        view: SummaryViewProtocol?,
        model: TransferModel,
        transferService: TransferServiceProtocol?,
        nextHandler: (() -> Void)?
    ) {
        self.view = view
        self.model = model
        self.transferService = transferService
        self.nextHandler = nextHandler
    }
    
    // MARK: AmountInputPresenterProtocol
    
    func viewDidLoad() {
        view?.updateView(viewState: .putInput(transferModel: model))
    }
    
    func onNextButtonTouched() {
        nextHandler?()
    }
}
