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
        let transferModel = TransferModel(sourceIban: "DE12500105170648489890", targetIban: "DE12500105170648489890", amount: model.amount!)
        let view = SummaryView()
        let interactor = SummaryInteractor()
        let presenter = SummaryPresenter(
            model: transferModel,
            nextHandler: nil
        )
        
        presenter.view = view
        presenter.interactor = interactor
        view.presenter = presenter
        
        push(presenter.view)
    }
}
