import UIKit
import RxSwift

protocol SelectStockViewProtocol: UIViewController {
}

class SelectStockView: UIViewController, SelectStockViewProtocol {
        
    var viewModel: SelectStockViewModel?
    
    private var containerView = UIView()
    private var tableView = UITableView()
    private var refreshButton = UIButton()
    private var nextButton = UIButton()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        bindToViewModel()
        
        viewModel?.viewDidLoad()
    }
    
    // MARK: - Bind
    
    private func bindToViewModel() {
        viewModel?.stocks.subscribe({ [weak self] stocks in
            print(stocks)
            self?.tableView.reloadData()
        })
        .disposed(by: disposeBag)
    }
    
    // MARK: - Init View
    
    private func initView() {
        initOverallView()
        initContainer()
        initStockTable()
        initRefreshButton()
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
        ConstraintUtils.setTopToTopOfView(superView: containerView, view: tableView, topMargin: 100)
        ConstraintUtils.setLeadingAndTrailingToSuperView(superView: containerView, view: tableView)
    }
    
    private func initRefreshButton() {
        view.addSubview(refreshButton)
        ConstraintUtils.setTopToBottomOfView(superView: tableView, view: refreshButton, topMargin: 40)
        ConstraintUtils.setLeadingAndTrailingToSuperView(superView: containerView, view: refreshButton, leftMargin: 20, rigthMargin: 20)
        
        refreshButton.setTitle("Refresh", for: .normal)
        refreshButton.setTitleColor(.black, for: .normal)
        
        refreshButton.addTarget(self, action: #selector(handleRefreshButtonClick), for: .touchUpInside)
    }
    
    private func initNextButton() {
        view.addSubview(nextButton)
        ConstraintUtils.setTopToBottomOfView(superView: refreshButton, view: nextButton, topMargin: 20)
        ConstraintUtils.setBottomToBottomOfView(superView: containerView, view: nextButton, margin: 40)
        ConstraintUtils.setLeadingAndTrailingToSuperView(superView: containerView, view: nextButton, leftMargin: 20, rigthMargin: 20)
        
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(.black, for: .normal)
        
        nextButton.addTarget(self, action: #selector(handleNextButtonClick), for: .touchUpInside)
    }
    
    // MARK: Actions
    
    @objc func handleRefreshButtonClick(sender: UIButton) {
        viewModel?.onRefreshButtonTouched()
    }
    
    @objc func handleNextButtonClick(sender: UIButton) {
        viewModel?.onNextButtonTouched(stockId: "Apple")
    }
}
