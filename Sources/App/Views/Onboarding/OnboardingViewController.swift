import Foundation
import RxSwift
import UIKit
import SnapKit

class OnboardingViewController: BaseViewController {
    
    private lazy var obCollectionView = UICollectionView()
    var curentPage = 1
    var curentCellMain = 1
    var isClickBtn = false
}

extension OnboardingViewController {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func setupViews() {
        super.setupViews()
        
        // MARK: Setup views

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        layout.scrollDirection = .horizontal
        obCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        obCollectionView.register(OnboardingMainCell.self, forCellWithReuseIdentifier: OnboardingMainCell.identifier)
        obCollectionView.dataSource = self
        obCollectionView.delegate = self
        obCollectionView.isScrollEnabled = false
        obCollectionView.setupCollectionView()
        
        // MARK: Setup constrains
        view.addSubview(obCollectionView)
        
        obCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.height.equalToSuperview()
        }
    }
    
    override func setupRx() {
        super.setupRx()
        
        obCollectionView.reloadData()
    }
}

extension OnboardingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOnboarding.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingMainCell.identifier, for: indexPath) as? OnboardingMainCell
                else { return .init() }
     
        let listOB = listOnboarding[indexPath.row]
        cell.update(background: listOB.background, title: listOB.title, button: listOB.button, index: indexPath.row)
        
        cell.nextAction = { [weak self] in
            if (indexPath.row == listOnboarding.count - 1) {
                self?.navigationController?.pushViewController(HomeViewController(), animated: true)
            } else {
                let indexPath = IndexPath(item: indexPath.row + 1, section: 0)
                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        }
        return cell
    }
}

extension OnboardingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

