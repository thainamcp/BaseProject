//
//  NewViewController.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 22/12/2023.
//  Copyright © 2023 Vulcan Labs. All rights reserved.
//

import UIKit
import SnapKit

class NewViewController: UIViewController{
    private lazy var backButton = UIButton()
    private lazy var nameLabel = UILabel()
    var nameFood : String?
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .orange
        setUpViews()
        setUpConstraints()
        
    }
    func setUpViews() {
        nameLabel.text = nameFood
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 18)
        
        
        backButton.setTitle("Next view", for: .normal)
        backButton.setTitleColor(.white, for: .normal)
        backButton.backgroundColor = .blue
        backButton.addTarget(self, action: #selector(backView), for: .touchUpInside)
    }
    func setUpConstraints(){
        view.addSubview(backButton)
        view.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints{
            $0.leftMargin.equalToSuperview().offset(20)
            $0.topMargin.equalToSuperview().offset(50)
            $0.size.equalTo(CGSize(width: 200, height: 30))
        }
        
        backButton.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.size.equalTo(CGSize(width: 200, height: 50))
            
        }
        
    }
    @objc func backView(){
        navigationController?.popViewController(animated: true)
    }
    
}
