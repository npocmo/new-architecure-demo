import UIKit

protocol SelectStockViewProtocol: UIViewController {
}

class SelectStockView: UIViewController, SelectStockViewProtocol {
        
    var viewModel: SelectStockViewModel?
    
    private var containerView = UIView()
    private var tableView = UITableView()
    private var nextButton = UIButton()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        bindToViewModel()
        
        viewModel?.viewDidLoad()
    }
    
    // MARK: - Bind
    
    private func bindToViewModel() {
        viewModel?.stocks.observe(on: self) { [weak self] stocks in
            print(stocks)
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - Init View
    
    private func initView() {
        initOverallView()
        initContainer()
        initStockTable()
        initNextButton()
    }
    
    private func initOverallView() {
        view.backgroundColor = .systemYellow
    }
    
    private func initContainer() {
        view.addSubview(containerView)
        ConstraintUtils.setToFitSuperView(superView: view, view: containerView)
    }
    
    private func initStockTable() {
        view.addSubview(tableView)
        ConstraintUtils.setTopToTopOfView(superView: containerView, view: tableView)
        ConstraintUtils.setLeadingAndTrailingToSuperView(superView: containerView, view: tableView)
        ConstraintUtils.setBottomToTopOfView(superView: containerView, view: tableView)
        
        tableView.backgroundColor = .green
    }
    
    private func initNextButton() {
        view.addSubview(nextButton)
        ConstraintUtils.setBottomToBottomOfView(superView: containerView, view: nextButton, margin: 40)
        ConstraintUtils.setLeadingAndTrailingToSuperView(superView: containerView, view: nextButton, leftMargin: 20, rigthMargin: 20)
        
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(.black, for: .normal)
        
        nextButton.addTarget(self, action: #selector(handleNextButtonClick), for: .touchUpInside)
    }
    
    // MARK: Actions
    
    @objc func handleNextButtonClick(sender: UIButton) {
        viewModel?.onNextButtonTouched(stockId: "Apple")
    }
}
