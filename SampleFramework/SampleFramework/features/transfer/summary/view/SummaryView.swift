import UIKit

protocol SummaryViewProtocol: UIViewController {
    func updateView(viewState: SummaryViewState)
}

class SummaryView: UIViewController, SummaryViewProtocol {
    
    var presenter: SummaryPresenter?
    
    private var containerView = UIView()
    private var sourceLabel = UILabel()
    private var ibanLabel = UILabel()
    private var transferAmount = UILabel()
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
        initSourceLabel()
        initIbanLabel()
        initTransferAmountLabel()
        initNextButton()
    }
    
    private func initOverallView() {
        view.backgroundColor = .systemYellow
    }
    
    private func initContainer() {
        view.addSubview(containerView)
        ConstraintUtils.setToFitSuperView(superView: view, view: containerView)
    }
    
    private func initSourceLabel() {
        view.addSubview(sourceLabel)
        ConstraintUtils.setTopToTopOfView(superView: containerView, view: sourceLabel, topMargin: 100)
        ConstraintUtils.setLeadingAndTrailingToSuperView(superView: containerView, view: sourceLabel, leftMargin: 20, rigthMargin: 20)
    }
    
    private func initIbanLabel() {
        view.addSubview(ibanLabel)
        ConstraintUtils.setTopToBottomOfView(superView: sourceLabel, view: ibanLabel, topMargin: 10)
        ConstraintUtils.setLeadingAndTrailingToSuperView(superView: containerView, view: ibanLabel, leftMargin: 20, rigthMargin: 20)
    }
    
    private func initTransferAmountLabel() {
        view.addSubview(transferAmount)
        ConstraintUtils.setTopToBottomOfView(superView: ibanLabel, view: transferAmount, topMargin: 10)
        ConstraintUtils.setLeadingAndTrailingToSuperView(superView: containerView, view: transferAmount, leftMargin: 20, rigthMargin: 20)
    }
    
    private func initNextButton() {
        view.addSubview(nextButton)
        ConstraintUtils.setBottomToBottomOfView(superView: containerView, view: nextButton, margin: 40)
        ConstraintUtils.setLeadingAndTrailingToSuperView(superView: containerView, view: nextButton, leftMargin: 20, rigthMargin: 20)
        
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(.black, for: .normal)
        nextButton.isEnabled = true
        nextButton.isUserInteractionEnabled = true
        nextButton.addTarget(self, action: #selector(handleNextButtonClick), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc func handleNextButtonClick(sender: UIButton) {
        presenter?.onNextButtonTouched()
    }
    
    // MARK: - SummaryViewState
    
    func updateView(viewState: SummaryViewState) {
        switch viewState {
        case .putInput(let model):
            sourceLabel.text = "Transferring from " + model.sourceIban
            ibanLabel.text = "Transferring to " + model.targetIban
            transferAmount.text = "Transfer amount: " + model.amount.value.description + " " +  model.amount.currency.iso
        }
    }
}
