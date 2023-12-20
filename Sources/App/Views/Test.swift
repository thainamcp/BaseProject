//
//  Test.swift
//  TimelessTalkApp
//
//  Created by thainam on 30/03/2023.
//  Copyright © 2023 Vulcan Labs. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

class Test: BaseViewController {
    private lazy var thumbnailImageView = UIImageView()
    
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    private lazy var optionInputMessageView = UIView()
    private lazy var inputQuestionTextView = UITextView()
    private lazy var sendAnswerButton = UIButton()
}

extension Test {
    override func setupViews() {
        super.setupViews()
        
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.backgroundColor = .orange
        thumbnailImageView.cornerRadius = 40.scaleX
        
        optionInputMessageView.backgroundColor = .white
        optionInputMessageView.cornerRadius = 20.scaleX
        
        inputQuestionTextView.cornerRadius = 12.scaleX
        inputQuestionTextView.layer.masksToBounds = true
        inputQuestionTextView.backgroundColor = AppColor.grayBackground
        
        inputQuestionTextView.font = UIFont.appFont(size: 14)
        inputQuestionTextView.textColor = UIColor.lightGray
        inputQuestionTextView.resignFirstResponder()
        inputQuestionTextView.selectedTextRange = inputQuestionTextView.textRange(from: inputQuestionTextView.beginningOfDocument, to: inputQuestionTextView.beginningOfDocument)
        inputQuestionTextView.isScrollEnabled = true
        inputQuestionTextView.contentInset.left = 5.scaleX
        inputQuestionTextView.returnKeyType = UIReturnKeyType.send
        
        sendAnswerButton.setImage(R.image.icon_send_black(), for: .normal)
        
        //
        view.addSubview(thumbnailImageView)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(optionInputMessageView)
        optionInputMessageView.addSubview(inputQuestionTextView)
        optionInputMessageView.addSubview(sendAnswerButton)
        
        thumbnailImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(Developer.isHasNortch ? 50.scaleX : 20.scaleX)
            $0.size.equalTo(CGSize(width: 80.scaleX, height: 80.scaleX))
        }
        
        scrollView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(thumbnailImageView.snp.bottom)
        }
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        optionInputMessageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20.scaleX)
            $0.bottom.equalToSuperview().inset(Developer.isHasNortch ? 50.scaleX : 30.scaleX)
        }
        
        inputQuestionTextView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview().inset(11.scaleX)
            $0.trailing.equalTo(sendAnswerButton.snp.leading).inset(-10.scaleX)
            $0.height.equalTo(60.scaleX)
        }
        
        sendAnswerButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20.scaleX)
            $0.centerY.equalTo(inputQuestionTextView)
            $0.size.equalTo(CGSize(width: 30.scaleX, height: 30.scaleX))
        }
    }
    
    override func setupRx() {
        super.setupRx()
        
        
    }
}
