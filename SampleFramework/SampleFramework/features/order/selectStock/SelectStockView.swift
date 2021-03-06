import UIKit
import RxSwift
import RxDataSources

protocol SelectStockViewProtocol: UIViewController {
}

class SelectStockView: UIViewController, SelectStockViewProtocol {
        
    var presenter: SelectStockPresenterProtocol?
        
    private var containerView = UIView()
    private var titleLabel = UILabel()
    private var tableView = UITableView()
    private var giroBalanceLabel = UILabel()
    private var depoBalanceLabel = UILabel()
    private var refreshButton = UIButton()
    private var nextButton = UIButton()
    
    private var selectedStock = ""
    private let disposeBag = DisposeBag()
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        
        bindTableData()
        bindGiroBalanceData()
        bindDepoBalanceData()
        
        bindTableClick()
        bindRefreshButton()
        bindNextButton()
        
        presenter?.viewDidLoad()
    }
    
    // MARK: - Bind Data
    
    private func bindTableData() {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, SelectStockViewState>>(
            configureCell: { dataSource, tableView, indexPath, item in
                var cellText = ""
                switch item {
                case .idle:
                    cellText = ""
                case .empty:
                    cellText = "No data to show"
                case .loading:
                    cellText = "Data is loading..."
                case .error(error: let error):
                    cellText = "Got error while loading data: \(error)"
                case .dataAvailable(let stock):
                    cellText = stock
                }
              let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
              cell.textLabel?.text = cellText
              return cell
            }
        )
        
        presenter?.stocks
            .map { selectStockCellModel in
                return [SectionModel(model: "SectionName", items: selectStockCellModel ?? [])]
            }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func bindTableClick() {
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                let cell = self?.tableView.cellForRow(at: indexPath)
                self?.selectedStock = cell?.textLabel?.text ?? ""
            })
            .disposed(by: disposeBag)
    }
    
    private func bindGiroBalanceData() {
        presenter?.giroBalance
            .compactMap {$0}
            .map { giroBalance in
                let text = "Giro Balance = \(giroBalance)"
                return NSAttributedString(string: text)
            }
            .bind(to: giroBalanceLabel.rx.attributedText)
            .disposed(by: disposeBag)
    }
    
    private func bindDepoBalanceData() {
        presenter?.depoBalance
            .compactMap {$0}
            .map { depoBalance in
                let text = "Depo Balance = \(depoBalance)"
                return NSAttributedString(string: text)
            }
            .bind(to: depoBalanceLabel.rx.attributedText)
            .disposed(by: disposeBag)
    }
    
    private func bindNextButton() {
        nextButton.rx.tap.bind { [weak self] in
            self?.presenter?.onNextButtonTouched(stockId: self?.selectedStock)
        }.disposed(by: disposeBag)
    }
    
    private func bindRefreshButton() {
        refreshButton.rx.tap.bind { [weak self] in
            self?.presenter?.onRefreshButtonTouched()
        }.disposed(by: disposeBag)
    }
    
    // MARK: Init View
    
    private func initView() {
        initOverallView()
        initContainer()
        initTitleLabel()
        initStockTable()
        initGiroBalanceLabel()
        initDepoBalanceLabel()
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
    
    private func initTitleLabel() {
        view.addSubview(titleLabel)
        ConstraintUtils.setTopToTopOfView(superView: containerView, view: titleLabel, topMargin: 30)
        ConstraintUtils.setCenterXToView(superView: containerView, view: titleLabel)
        
        titleLabel.text = "Select Stock"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    private func initStockTable() {
        view.addSubview(tableView)
        ConstraintUtils.setTopToBottomOfView(superView: titleLabel, view: tableView, topMargin: 40)
        ConstraintUtils.setLeadingAndTrailingToSuperView(superView: containerView, view: tableView, leftMargin: 20, rigthMargin: 20)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
    
    private func initGiroBalanceLabel() {
        view.addSubview(giroBalanceLabel)
        ConstraintUtils.setTopToBottomOfView(superView: tableView, view: giroBalanceLabel, topMargin: 20)
        ConstraintUtils.setLeadingAndTrailingToSuperView(superView: containerView, view: giroBalanceLabel, leftMargin: 20, rigthMargin: 20)
        
        giroBalanceLabel.text = "Loading"
    }
    
    private func initDepoBalanceLabel() {
        view.addSubview(depoBalanceLabel)
        ConstraintUtils.setTopToBottomOfView(superView: giroBalanceLabel, view: depoBalanceLabel, topMargin: 10)
        ConstraintUtils.setLeadingAndTrailingToSuperView(superView: containerView, view: depoBalanceLabel, leftMargin: 20, rigthMargin: 20)
        
        depoBalanceLabel.text = "Loading"
    }
    
    private func initRefreshButton() {
        view.addSubview(refreshButton)
        ConstraintUtils.setTopToBottomOfView(superView: depoBalanceLabel, view: refreshButton, topMargin: 30)
        ConstraintUtils.setLeadingAndTrailingToSuperView(superView: containerView, view: refreshButton, leftMargin: 20, rigthMargin: 20)
        ConstraintUtils.setHeightEqual(view: refreshButton, height: 30)
        
        refreshButton.setTitle("Refresh Stocks", for: .normal)
        refreshButton.setTitleColor(.black, for: .normal)
    }
    
    private func initNextButton() {
        view.addSubview(nextButton)
        ConstraintUtils.setTopToBottomOfView(superView: refreshButton, view: nextButton, topMargin: 20)
        ConstraintUtils.setBottomToBottomOfView(superView: containerView, view: nextButton, margin: 40)
        ConstraintUtils.setLeadingAndTrailingToSuperView(superView: containerView, view: nextButton, leftMargin: 20, rigthMargin: 20)
        ConstraintUtils.setHeightEqual(view: nextButton, height: 30)
        
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(.black, for: .normal)
    }
}
