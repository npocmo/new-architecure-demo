import Foundation
import RxSwift

protocol HomePresenterProtocol {
    func onTransferButtonTouched()
    func onOrderButtonTouched()
}

class HomePresenter: HomePresenterProtocol {
    private weak var view: HomeViewProtocol?
    private let openTransferhandler: (() -> Void)?
    private let openOrderHandler: (() -> Void)?
    
    init(
        view: HomeViewProtocol?,
        openTransferhandler: (() -> Void)?,
        openOrderHandler: (() -> Void)?
    ) {
        self.view = view
        self.openTransferhandler = openTransferhandler
        self.openOrderHandler = openOrderHandler
    }
    
    // MARK: HomePresenterProtocol
    
    func onTransferButtonTouched() {
        openTransferhandler?()
    }
    
    func onOrderButtonTouched() {
        openOrderHandler?()
    }
}
