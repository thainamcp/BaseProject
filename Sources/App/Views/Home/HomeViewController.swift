import Foundation
import NVActivityIndicatorView
import StoreKit
import SnapKit
import UIKit

class HomeViewController: BaseViewController {
        private var quoteTableView = UITableView()
    private let loadingIndicator = NVActivityIndicatorView(frame: .zero, type: .circleStrokeSpin, color: AppColor.loadingIndicatorColor, padding: 0)
    
    private let viewModel: HomeViewModel = .init()
    let userDefault = UserDefaultService.shared
}

extension HomeViewController {
    override func setupViews() {
        super.setupViews()
        
        // MARK: Setup views
        quoteTableView.register(QuotesFirstCell.self, forCellReuseIdentifier: QuotesFirstCell.identifier)
        quoteTableView.register(QuotesMainCell.self, forCellReuseIdentifier: QuotesMainCell.identifier)
        quoteTableView.dataSource = self
        quoteTableView.delegate = self
        quoteTableView.backgroundColor = .clear
        quoteTableView.separatorStyle = .none
        quoteTableView.showsVerticalScrollIndicator = false
        quoteTableView.contentInset = UIEdgeInsets(top: 0.scaleX, left: 0.scaleX, bottom: 20.scaleX, right: 0.scaleX)
        
        // MARK: Setup constrains
        view.addSubview(quoteTableView)
        view.addSubview(loadingIndicator)
        quoteTableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20.scaleX)
            $0.top.bottom.equalToSuperview()
        }
        
        loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(CGSize(width: 50.scaleX, height: 50.scaleX))
        }
        
        loadingIndicator.startAnimating()
    }
    
    override func setupRx() {
        super.setupRx()
        
        viewModel.quotesObservable
            .withUnretained(self)
            .observe(on: scheduler.main)
            .subscribe(onNext: { owner, _ in
                owner.quoteTableView.reloadData()
                if (owner.viewModel.quotes.count != 0) {
                    owner.loadingIndicator.stopAnimating()
                }
                print("----config: Quotes \(owner.viewModel.quotes)")
            })
            .disposed(by: disposeBag)
        
        
        viewModel.purchaseObservable
            .withUnretained(self)
            .observe(on: scheduler.main)
            .subscribe(onNext: { owner, purchase in
                
            })
            .disposed(by: disposeBag)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.quotes.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: QuotesFirstCell.identifier, for: indexPath) as? QuotesFirstCell
            else { return .init() }
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuotesMainCell.identifier, for: indexPath) as? QuotesMainCell
        else { return .init() }
        let quoteModel = viewModel.quotes[indexPath.row - 1]
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.update(quoteModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}




