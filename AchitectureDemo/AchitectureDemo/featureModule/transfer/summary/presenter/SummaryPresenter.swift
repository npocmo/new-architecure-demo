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

class SummaryPresenter {
    weak var view: SummaryViewProtocol?
    var interactor: SummaryInteractorProtocol?
    
    private let nextHandler: (() -> Void)?
    private let disposeBag = DisposeBag()
    
    private let model: TransferModel
    
    init(model: TransferModel, nextHandler: (() -> Void)?) {
        self.model = model
        self.nextHandler = nextHandler
    }
    
    // MARK: AmountInputPresenterProtocol
    
    func viewDidLoad() {
        view?.updateView(viewState: .putInput(transferModel: model))
    }
    
    func onNextButtonTouched() {
        
    }
}
