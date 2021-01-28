import UIKit

struct TransferWireframeModel {
    var amount: Money?
}

class TransferWireframe: BaseWireframe {
    
    private var transferWireframeModel = TransferWireframeModel()
    
    // MARK: - Navigation
    
    func present() {
        let view = AmountInputView()
        let interactor = AmountInputInteractor()
        let presenter = AmountInputPresenter(
            nextHandler: { result in
                self.transferWireframeModel.amount = result
                self.pushSummary()
            }
        )
        
        presenter.view = view
        presenter.interactor = interactor
        view.presenter = presenter
        
        present(presenter.view)
    }
    
    func pushSummary() {
        
    }
}
