import UIKit

struct TransferWireframeModel {
    var sourceIban: String?
    var targetIban: String?
    var amount: Money?
}

class TransferWireframe: BaseWireframe {
    
    private var model = TransferWireframeModel()
    
    // MARK: - Navigation
    
    func present() {
        let view = AmountInputView()
        let interactor = AmountInputInteractor()
        let presenter = AmountInputPresenter(
            nextHandler: { result in
                self.model.amount = result
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
