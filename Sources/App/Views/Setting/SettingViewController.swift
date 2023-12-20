import Foundation
import UIKit
import SnapKit
import MailController

class SettingViewController: BaseViewController {
    
    private lazy var titleLabel = UILabel()
    private var settingTableView = UITableView()
    
    private let listSetting = ["Share Mindful Talk", "Term Of Use", "Privacy & Security", "Contact", "Email Us", "About Us"]
}

extension SettingViewController {
    
    override func setupViews() {
        super.setupViews()
        
        //MARK: Setup views
        settingTableView.register(SettingFirstCell.self, forCellReuseIdentifier: SettingFirstCell.identifier)
        settingTableView.register(SettingCell.self, forCellReuseIdentifier: SettingCell.identifier)
        settingTableView.dataSource = self
        settingTableView.delegate = self
        settingTableView.backgroundColor = UIColor.clear
        settingTableView.separatorStyle = .none
        settingTableView.showsVerticalScrollIndicator = false
        
        //MARK: Setup constrains
        view.addSubview(settingTableView)
        
        settingTableView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(25.scaleX)
            $0.top.bottom.equalToSuperview()
        }
    }
    
    override func setupRx() {
        super.setupRx()

    }
}

extension SettingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSetting.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingFirstCell.identifier, for: indexPath) as? SettingFirstCell
            else { return .init() }
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.identifier, for: indexPath) as? SettingCell
        else { return .init() }
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.update(title: listSetting[indexPath.row - 1], index: indexPath.row - 1)
        return cell
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1 :
            if let name = URL(string: Developer.urlApp), !name.absoluteString.isEmpty {
                let objectsToShare = [name]
                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                self.present(activityVC, animated: true, completion: nil)
            } else {
                // show alert for not available
            }
            break
        case 2:
            let url = URL(string: Developer.termOfUse)!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            break
        case 3:
            let url = URL(string: Developer.privacyPolicy)!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            break
        case 4:
            let url = URL(string: Developer.conntacUs)!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            break
        case 5:
            if let mailComposeViewController = MailController.shared.mailComposeViewController() {
                mailComposeViewController.setToRecipients(["\(Developer.supportEmail)"])
                mailComposeViewController.setSubject("Feedback Mindful Talk")
                present(mailComposeViewController, animated:true, completion:nil)
            }
            break
        case 6:
            let url = URL(string: Developer.conntacUs)!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            break
        default:
            break
            
        }
    }
}
