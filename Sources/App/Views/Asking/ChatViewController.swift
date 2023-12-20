import Foundation
import SwiftJWT
import CryptoKit
import IQKeyboardManagerSwift
import UIKit
import SnapKit
import Kingfisher
import NVActivityIndicatorView

class ChatViewController: BaseViewController {
    
    private lazy var backButton = UIButton()
    private lazy var thumbnailImageView = UIImageView()
    
    private lazy var bgAnsweGPTView = UIView()
    private lazy var answerGPTLabel = UILabel()
    
    private lazy var bgQuestionUserView = UIView()
    private lazy var questionUserLabel = UILabel()
    
    private lazy var optionInputMessageView = UIView()
    private lazy var inputQuestionTextView = UITextView()
    private lazy var sendAnswerButton = UIButton()
    
    private let loadingIndicator = NVActivityIndicatorView(frame: .zero, type: .ballPulse, color: AppColor.loadingIndicatorColor, padding: 0)
    
    var characterModel: CharacterModel?
    var isClickLike = false
    private let hintTextView = "Asking anything..."
    var createDate = 0
    
    var userQuestion = ""
    var GPTAnswer = ""
    
    let userDefault = UserDefaultService.shared
    
    private let askingViewModel: AskingViewModel = .init()
}

extension ChatViewController: UITextViewDelegate {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let url = URL(string: characterModel!.thumbnail)
        let imgResource = ImageResource(downloadURL: url!, cacheKey: characterModel?.id)
        self.thumbnailImageView.kf.setImage(with: imgResource)
        {
            result in
            switch result {
            case .success(let value):
                print("\(value)")
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }
    }
    
    override func setupViews() {
        super.setupViews()
        self.askingViewModel.resetHistoryChat()

        // MARK: Setup views
        backButton.setImage(R.image.icon_back(), for: .normal)
        
        thumbnailImageView.contentMode          = .scaleAspectFit
        thumbnailImageView.backgroundColor      = AppColor.tabbarColor
        thumbnailImageView.cornerRadius         = 40.scaleX
        thumbnailImageView.layer.masksToBounds  = true
    
        bgAnsweGPTView.backgroundColor  = .white
        bgAnsweGPTView.cornerRadius     = Developer.cornerRadius20

        answerGPTLabel.setText(text:(characterModel?.firstMessages.randomElement())!, color: AppColor.blackTextColor)
        answerGPTLabel.numberOfLines    = 0
        answerGPTLabel.font             = UIFont.appFont(size: 14)
        answerGPTLabel.textAlignment    = .left
        answerGPTLabel.lineBreakMode    = .byWordWrapping
        
        bgQuestionUserView.isHidden         = true
        bgQuestionUserView.backgroundColor  = AppColor.bgQuestionColor
        bgQuestionUserView.cornerRadius     = Developer.cornerRadius20

        questionUserLabel.numberOfLines = 3
        questionUserLabel.font          = UIFont.appFont(size: 14)
        
        optionInputMessageView.backgroundColor = .white
        optionInputMessageView.cornerRadius = 20.scaleX
        
        inputQuestionTextView.cornerRadius = 12.scaleX
        inputQuestionTextView.layer.masksToBounds = true
        inputQuestionTextView.backgroundColor = AppColor.grayBackground
        
        inputQuestionTextView.font = UIFont.appFont(size: 14)
        inputQuestionTextView.textColor = UIColor.lightGray
        inputQuestionTextView.resignFirstResponder()
        inputQuestionTextView.selectedTextRange = inputQuestionTextView.textRange(from: inputQuestionTextView.beginningOfDocument, to: inputQuestionTextView.beginningOfDocument)
        inputQuestionTextView.text = hintTextView
        inputQuestionTextView.isScrollEnabled = true
        inputQuestionTextView.contentInset.left = 5.scaleX
        inputQuestionTextView.returnKeyType = UIReturnKeyType.send
        inputQuestionTextView.delegate = self
        
        sendAnswerButton.setImage(R.image.icon_send_black(), for: .normal)
        
        // MARK: Setup constrains
        view.addSubview(backButton)
        view.addSubview(bgAnsweGPTView)
        bgAnsweGPTView.addSubview(answerGPTLabel)
        bgAnsweGPTView.addSubview(loadingIndicator)
        view.addSubview(thumbnailImageView)
        view.addSubview(bgQuestionUserView)
        
        bgQuestionUserView.addSubview(questionUserLabel)
        view.addSubview(optionInputMessageView)
        optionInputMessageView.addSubview(inputQuestionTextView)
        optionInputMessageView.addSubview(sendAnswerButton)
        
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Developer.isHasNortch ? 50.scaleX : 20.scaleX)
            $0.leading.equalToSuperview().inset(5.scaleX)
            $0.size.equalTo(CGSize(width: 44.scaleX, height: 44.scaleX))
        }
        
        thumbnailImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(Developer.isHasNortch ? 50.scaleX : 20.scaleX)
            $0.size.equalTo(CGSize(width: 80.scaleX, height: 80.scaleX))
        }
        
        bgAnsweGPTView.snp.makeConstraints {
            $0.top.equalTo(thumbnailImageView.snp.bottom).inset(-15.scaleX)
            $0.leading.trailing.equalToSuperview().inset(28.scaleX)
        }
        
        answerGPTLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(5.scaleX)
            $0.leading.bottom.top.equalToSuperview().inset(13.scaleX)
        }
        
        loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(CGSize(width: 40.scaleX, height: 30.scaleX))
        }
        
        bgQuestionUserView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(28.scaleX)
            $0.leading.equalToSuperview().inset(100.scaleX)
            $0.bottom.equalTo(optionInputMessageView.snp.top).inset(-20.scaleX)
        }
        
        questionUserLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(13.scaleX)
        }
        
        optionInputMessageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20.scaleX)
            $0.bottom.equalTo(view.keyboardLayoutGuide.snp.top).inset(-20)
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
    
    func defaultInputText() {
        inputQuestionTextView.textColor = UIColor.lightGray
        inputQuestionTextView.text = hintTextView
    }
    
    func checkRequest() {
        if(inputQuestionTextView.text != "" && inputQuestionTextView.text != hintTextView) {
            if ((userDefault.isFreeUsage < askingViewModel.freeUsage) || askingViewModel.isPurchase || userDefault.isPurchase) {
                userQuestion  = inputQuestionTextView.text
                requestQuestion()
            } else {
                let dsVC = DirectStoreViewController()
                dsVC.modalPresentationStyle = .fullScreen
                present(dsVC, animated: true)
            }
        }
    }
    
    func requestQuestion() {
        loadingIndicator.startAnimating()
        bgQuestionUserView.isHidden = false
        questionUserLabel.text = self.userQuestion
        sendAnswerButton.isUserInteractionEnabled = false
        
        APIClient.requestQuestion(question: self.userQuestion, prompt: characterModel!.prompt) { result in
            switch result {
            case .success(let response):
                
                print("RESPONE \(response)")
                let answerGPT = response.choices.first!.message.content.replacingOccurrences(of: "\n\n", with: "")
                // increase free usage
                self.userDefault.isFreeUsage += 1
                
                self.loadingIndicator.stopAnimating()
                self.sendAnswerButton.isUserInteractionEnabled = true
                self.isClickLike = false
                
                self.createDate = response.created
                self.answerGPTLabel.text = answerGPT

                self.askingViewModel.updateHistoryChat(historyModel: [MessageModel(role: "user", content: self.userQuestion), MessageModel(role: "assistant", content: "\(String(describing: answerGPT))")])
                
            case .failure(let error):
                print("\(error.localizedDescription)")
                self.answerGPTLabel.text = "Please input again!"
                self.loadingIndicator.stopAnimating()
                self.sendAnswerButton.isUserInteractionEnabled = true
                self.isClickLike = false
            }
        }
        self.defaultInputText()
    }
    
    override func setupRx() {
        super.setupRx()
        
        backButton.rx.tap
            .observe(on: scheduler.main)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        sendAnswerButton.rx.tap
            .observe(on: scheduler.main)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.checkRequest()
            })
            .disposed(by: disposeBag)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = AppColor.blackTextColor
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = self.hintTextView
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            checkRequest()
            return false
        }
        
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = updatedText.count
        if (updatedText.isEmpty) {
            textView.text = self.hintTextView
            textView.textColor = UIColor.lightGray
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }
        else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.textColor = AppColor.blackTextColor
            textView.text = text
        } else if text == "\n" {
            return false
        }
        else {
            return numberOfChars < askingViewModel.serverConfig.limit_text
        }
        
        return false
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
}

