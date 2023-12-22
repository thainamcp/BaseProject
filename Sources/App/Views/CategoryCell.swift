//
//  CategoryCell.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 22/12/2023.
//  Copyright © 2023 Vulcan Labs. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell{
    
    private lazy var nameFoodLabel = UILabel()
    static let id = "CategoryCell"
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpViews()
        self.setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews(){
        nameFoodLabel.textColor = .black
        nameFoodLabel.font = UIFont.systemFont(ofSize: 18)
        
        
    }
    func setUpConstraints() {
        self.contentView.addSubview(nameFoodLabel)
        nameFoodLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
    }
    func updateData(namefood: String){
        self.nameFoodLabel.text = namefood
    }
    
    
}
