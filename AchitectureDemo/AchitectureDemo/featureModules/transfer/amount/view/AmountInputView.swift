import UIKit

protocol AmountInputViewProtocol: UIViewController {
    func updateView(viewState: AmountInputViewState)
}

class AmountInputView: UIViewController, AmountInputViewProtocol {
    
    var presenter: AmountInputPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - AmountInputView
    
    func updateView(viewState: AmountInputViewState) {
        
    }
}
