import UIKit

protocol HomeViewProtocol: UIViewController {
}

class HomeView: UIViewController, HomeViewProtocol {
    
    var presenter: HomePresenterProtocol?
    
    private var containerView = UIView()
    private var transferButton = UIButton()
    private var orderButton = UIButton()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    // MARK: - Init View
    
    private func initView() {
        initOverallView()
        initContainer()
        initTransferButton()
        initOrderButton()
    }
    
    private func initOverallView() {
        view.backgroundColor = .systemYellow
    }
    
    private func initContainer() {
        view.addSubview(containerView)
        ConstraintUtils.setToFitSuperView(superView: view, view: containerView)
    }
    
    private func initTransferButton() {
        view.addSubview(transferButton)
        ConstraintUtils.setTopToTopOfView(superView: containerView, view: transferButton, topMargin: 80)
        ConstraintUtils.setLeadingAndTrailingToSuperView(superView: containerView, view: transferButton, leftMargin: 20, rigthMargin: 20)
        
        transferButton.setTitle("Start Transfer (VIPER)", for: .normal)
        transferButton.setTitleColor(.black, for: .normal)
        
        transferButton.addTarget(self, action: #selector(handleTransferButtonClick), for: .touchUpInside)
    }
    
    private func initOrderButton() {
        view.addSubview(orderButton)
        ConstraintUtils.setTopToTopOfView(superView: transferButton, view: orderButton, topMargin: 80)
        ConstraintUtils.setLeadingAndTrailingToSuperView(superView: containerView, view: orderButton, leftMargin: 20, rigthMargin: 20)
        
        orderButton.setTitle("Start Order (MVVM)", for: .normal)
        orderButton.setTitleColor(.black, for: .normal)
        
        orderButton.addTarget(self, action: #selector(handleOrderButtonClick), for: .touchUpInside)
    }
    
    // MARK: Actions
    
    @objc func handleTransferButtonClick(sender: UIButton) {
        presenter?.onTransferButtonTouched()
    }
    
    @objc func handleOrderButtonClick(sender: UIButton) {
        presenter?.onOrderButtonTouched()
    }
}
