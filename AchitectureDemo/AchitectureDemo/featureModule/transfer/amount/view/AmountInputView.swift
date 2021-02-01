import UIKit

protocol AmountInputViewProtocol: UIViewController {
    func updateView(viewState: AmountInputViewState)
}

class AmountInputView: UIViewController, AmountInputViewProtocol {
    
    var presenter: AmountInputPresenter?
    
    private var containerView = UIView()
    private var editTextFieldTitleLabel = UILabel()
    private var editTextField = UITextField()
    private var availableAmountLabel = UILabel()
    private var nextButton = UIButton()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        
        presenter?.viewDidLoad()
    }
    
    // MARK: - Init View
    
    private func initView() {
        initOverallView()
        initContainer()
        initEditTextFieldTitleLabel()
        initEditTextField()
        initAvailableAmountLabel()
        initNextButton()
    }
    
    private func initOverallView() {
        view.backgroundColor = .systemYellow
    }
    
    private func initContainer() {
        view.addSubview(containerView)
        ConstraintUtils.setToFitSuperView(superView: view, view: containerView)
    }
    
    private func initEditTextFieldTitleLabel() {
        view.addSubview(editTextFieldTitleLabel)
        ConstraintUtils.setTopToTopOfView(superView: containerView, view: editTextFieldTitleLabel, topMargin: 100)
        ConstraintUtils.setLeadingAndTrailingToSuperView(superView: containerView, view: editTextFieldTitleLabel, leftMargin: 20, rigthMargin: 20)
        
        editTextFieldTitleLabel.text = "Amount to be transferred:"
    }
    
    private func initEditTextField() {
        view.addSubview(editTextField)
        ConstraintUtils.setTopToBottomOfView(superView: editTextFieldTitleLabel, view: editTextField, topMargin: 10)
        ConstraintUtils.setLeadingAndTrailingToSuperView(superView: containerView, view: editTextField, leftMargin: 20, rigthMargin: 20)
        
        editTextField.placeholder = "Enter amount"
    }
    
    private func initAvailableAmountLabel() {
        view.addSubview(availableAmountLabel)
        ConstraintUtils.setTopToBottomOfView(superView: editTextField, view: availableAmountLabel, topMargin: 10)
        ConstraintUtils.setLeadingAndTrailingToSuperView(superView: containerView, view: availableAmountLabel, leftMargin: 20, rigthMargin: 20)
        
        availableAmountLabel.textColor = .gray
    }
    
    private func initNextButton() {
        view.addSubview(nextButton)
        ConstraintUtils.setBottomToBottomOfView(superView: containerView, view: nextButton, margin: 40)
        ConstraintUtils.setLeadingAndTrailingToSuperView(superView: containerView, view: nextButton, leftMargin: 20, rigthMargin: 20)
        
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(.black, for: .normal)
        
        nextButton.addTarget(self, action: #selector(handleNextButtonClick), for: .touchUpInside)
    }
    
    @objc func handleNextButtonClick(sender: UIButton) {
        presenter?.onNextButtonTouched(amount: editTextField.text!)
    }
    
    // MARK: - AmountInputViewProtocol
    
    func updateView(viewState: AmountInputViewState) {
        switch viewState {
        case .loading:
            // TODO
            break
        case .updateAvailableAmount(balance: let balance):
            availableAmountLabel.text = "Available amount: " + balance.amount.value.description + " " +  balance.amount.currency.iso
        case .availableAmountFetchFailed:
            availableAmountLabel.text = "-"
        }
    }
}
