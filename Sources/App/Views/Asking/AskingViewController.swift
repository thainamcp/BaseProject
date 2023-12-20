import Foundation
import NVActivityIndicatorView
import SnapKit
import UIKit

class AskingViewController: BaseViewController {
    private var characterTableView = UITableView()
    private let loadingIndicator = NVActivityIndicatorView(frame: .zero, type: .circleStrokeSpin, color: AppColor.loadingIndicatorColor, padding: 0)
    
    private let viewModel: AskingViewModel = .init()
}

extension AskingViewController {
    override func setupViews() {
        super.setupViews()
        
        characterTableView.register(CharacterFirstCell.self, forCellReuseIdentifier: CharacterFirstCell.identifier)
        characterTableView.register(CharacterMainCell.self, forCellReuseIdentifier: CharacterMainCell.identifier)
        characterTableView.dataSource = self
        characterTableView.delegate = self
        characterTableView.backgroundColor = .clear
        characterTableView.separatorStyle = .none
        characterTableView.showsVerticalScrollIndicator = false
        characterTableView.contentInset = UIEdgeInsets(top: 0.scaleX, left: 0.scaleX, bottom: 20.scaleX, right: 0.scaleX)
    
        view.addSubview(characterTableView)
        view.addSubview(loadingIndicator)
        characterTableView.snp.makeConstraints {
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
        
        viewModel.charactersObservable
            .withUnretained(self)
            .observe(on: scheduler.main)
            .subscribe(onNext: { owner, _ in
                owner.characterTableView.reloadData()
                if (owner.viewModel.characters.count != 0) {
                    owner.loadingIndicator.stopAnimating()
                }
            })
            .disposed(by: disposeBag)
    }
}

extension AskingViewController: UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterFirstCell.identifier, for: indexPath) as? CharacterFirstCell
            else { return .init() }
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterMainCell.identifier, for: indexPath) as? CharacterMainCell
        else { return .init() }
        let characterModel = viewModel.characters[indexPath.row - 1]
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.update(characterModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row != 0) {

            let chatVC = ChatViewController()
            chatVC.characterModel = viewModel.characters[indexPath.row - 1]
            chatVC.modalPresentationStyle = .fullScreen
            self.navigationController?.present(chatVC, animated: true)
        }
    }
}


