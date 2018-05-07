//
//  HandleViewController.swift
//  PAKHApp
//
//  Created by Tung Vu on 3/7/18.
//  Copyright © 2018 Tung Vu. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class HandleViewController: UIViewController, UITextViewDelegate {
    
    var item : Record = Record() {
        didSet {
            self.contentField.defaultContent = item.getContent()
            print(item.getCode())
            Api.sharedInstance.getRecentFix(tickedId: item.getCode()) { (success, record, error) in
                if !success {
                    return
                }
                self.systemField.defaultContent = record!.getDepCode()
                self.staffField.defaultContent = record!.getUser()
                self.recentCauseField.defaultContent = record!.getCauseId()
                self.timeField.defaultContent = record!.getDate()
                self.recentFixTextView.text = record!.getContent()
                self.recentPrivateFixTextView.text = record!.getPrivateContent()
                self.id = record!.getId()
            }
        }
    }
    
    var id : String = ""
    
    var causeIDLevel1 : [(id: String,name: String)] = []
    var causeIDLevel2 : [(id: String,name: String)] = []
    
    private let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let causeFieldLevel1 : SkyFloatPicker = {
        let txtField = SkyFloatPicker()
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.placeHolder = "NGUYÊN NHÂN YÊU CẦU CẤP 1 - 2"
        txtField.lineColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        txtField.type = .LEVEL1
        return txtField
    }()
    
    private let causeFieldLevel2 : SkyFloatPicker = {
        let txtField = SkyFloatPicker()
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.placeHolder = ""
        txtField.type = .LEVEL2
        txtField.lineColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        return txtField
    }()
    
    private let contentField : SkyFloatPicker = {
        let txtField = SkyFloatPicker()
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.placeHolder = "NỘI DUNG YÊU CẦU"
        txtField.lineColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        txtField.pickerButtonHidden = true
        return txtField
    }()
    
    private let fixLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Ubuntu-Regular", size: 14)
        lbl.textColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        lbl.text = "NỘI DUNG XỬ LÝ"
        return lbl
    }()
    
    private lazy var fixTextView: UITextView = {
        let txtView = UITextView()
        txtView.layer.borderWidth = 1
        txtView.translatesAutoresizingMaskIntoConstraints = false
        txtView.layer.borderColor = UIColor.rgb(red: 34, green: 67, blue: 162).cgColor
        txtView.font = UIFont(name: "Ubuntu-Regular", size: 16)
        txtView.delegate = self
        return txtView
    }()
    
    private let privateFixLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Ubuntu-Regular", size: 14)
        lbl.textColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        lbl.text = "NỘI DUNG XỬ LÝ NỘI BỘ"
        return lbl
    }()
    
    private lazy var privateFixTextView: UITextView = {
        let txtView = UITextView()
        txtView.layer.borderWidth = 1
        txtView.translatesAutoresizingMaskIntoConstraints = false
        txtView.layer.borderColor = UIColor.rgb(red: 34, green: 67, blue: 162).cgColor
        txtView.font = UIFont(name: "Ubuntu-Regular", size: 16)
        txtView.delegate = self
        return txtView
    }()
    
    // recent fix views :
    private let systemField : SkyFloatPicker = {
        let txtField = SkyFloatPicker()
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.placeHolder = "ĐƠN VỊ XỬ LÝ"
        txtField.pickerButtonHidden = true
        txtField.lineColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        return txtField
    }()
    
    private let staffField : SkyFloatPicker = {
        let txtField = SkyFloatPicker()
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.placeHolder = "NGƯỜI XỬ LÝ"
        txtField.lineColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        txtField.pickerButtonHidden = true
        return txtField
    }()
    
    private let recentFixLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Ubuntu-Regular", size: 14)
        lbl.textColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        lbl.text = "NỘI DUNG XỬ LÝ"
        return lbl
    }()
    
    private lazy var recentFixTextView: UITextView = {
        let txtView = UITextView()
        txtView.layer.borderWidth = 1
        txtView.translatesAutoresizingMaskIntoConstraints = false
        txtView.layer.borderColor = UIColor.rgb(red: 34, green: 67, blue: 162).cgColor
        txtView.font = UIFont(name: "Ubuntu-Regular", size: 16)
        txtView.delegate = self
        txtView.isUserInteractionEnabled = false
        return txtView
    }()
    
    private let recentCauseField : SkyFloatPicker = {
        let txtField = SkyFloatPicker()
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.placeHolder = "NGUYÊN NHÂN"
        txtField.pickerButtonHidden = true
        txtField.lineColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        return txtField
    }()
    
    private let timeField : SkyFloatPicker = {
        let txtField = SkyFloatPicker()
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.placeHolder = "THỜI GIAN"
        txtField.lineColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        txtField.pickerButtonHidden = true
        return txtField
    }()
    
    private let recentPrivateFixLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Ubuntu-Regular", size: 14)
        lbl.textColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        lbl.text = "NỘI DUNG XỬ LÝ NỘI BỘ"
        return lbl
    }()
    
    private lazy var recentPrivateFixTextView: UITextView = {
        let txtView = UITextView()
        txtView.layer.borderWidth = 1
        txtView.translatesAutoresizingMaskIntoConstraints = false
        txtView.layer.borderColor = UIColor.rgb(red: 34, green: 67, blue: 162).cgColor
        txtView.font = UIFont(name: "Ubuntu-Regular", size: 16)
        txtView.delegate = self
        txtView.isUserInteractionEnabled = false
        return txtView
    }()
    
    //
    
    private let fixButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        btn.layer.cornerRadius = 20
        btn.setTitle("Xử lý", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()

    private let sendButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        btn.layer.cornerRadius = 20
        btn.setTitle("Chuyển tiếp", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    private let showRecentFixButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("NỘI DUNG XỬ LÝ GẦN NHẤT", for: .normal)
        btn.setTitleColor(UIColor.rgb(red: 34, green: 67, blue: 162), for: .normal)
        btn.titleLabel?.font = UIFont(name: "Ubuntu-Regular", size: 13)
        return btn
    }()
    
    private let hideRecentFixButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("ẨN NỘI DUNG", for: .normal)
        btn.setTitleColor(UIColor.rgb(red: 34, green: 67, blue: 162), for: .normal)
        btn.titleLabel?.font = UIFont(name: "Ubuntu-Regular", size: 13)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.frame = self.view.bounds
        navigationController?.edgesForExtendedLayout = []
        title = "Xử lý yêu cầu"
        
        scrollView.addSubview(causeFieldLevel1)
        causeFieldLevel1.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        causeFieldLevel1.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30).isActive = true
        causeFieldLevel1.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        causeFieldLevel1.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -20).isActive = true
        causeFieldLevel1.heightAnchor.constraint(equalToConstant: 50).isActive = true
        causeFieldLevel1.delegate = self
        
        scrollView.addSubview(causeFieldLevel2)
        causeFieldLevel2.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        causeFieldLevel2.topAnchor.constraint(equalTo: causeFieldLevel1.bottomAnchor, constant: 30).isActive = true
        causeFieldLevel2.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        causeFieldLevel2.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -20).isActive = true
        causeFieldLevel2.heightAnchor.constraint(equalToConstant: 50).isActive = true
        causeFieldLevel2.delegate = self
        
        scrollView.addSubview(contentField)
        contentField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentField.topAnchor.constraint(equalTo: causeFieldLevel2.bottomAnchor, constant: 20).isActive = true
        contentField.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        contentField.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -20).isActive = true
        contentField.heightAnchor.constraint(equalToConstant: 50).isActive = true

        scrollView.addSubview(fixLabel)
        fixLabel.topAnchor.constraint(equalTo: contentField.bottomAnchor, constant: 20).isActive = true
        fixLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        fixLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(fixTextView)
        fixTextView.topAnchor.constraint(equalTo: fixLabel.bottomAnchor, constant: 5).isActive = true
        fixTextView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        fixTextView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -20).isActive = true
        fixTextView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        scrollView.addSubview(privateFixLabel)
        privateFixLabel.topAnchor.constraint(equalTo: fixTextView.bottomAnchor, constant: 20).isActive = true
        privateFixLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        privateFixLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(privateFixTextView)
        privateFixTextView.topAnchor.constraint(equalTo: privateFixLabel.bottomAnchor, constant: 5).isActive = true
        privateFixTextView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        privateFixTextView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -20).isActive = true
        privateFixTextView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        scrollView.addSubview(fixButton)
        fixButton.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 20).isActive = true
        fixButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        fixButton.widthAnchor.constraint(equalToConstant: ((scrollView.frame.width - 40) / 2) - 10).isActive = true
        fixButton.topAnchor.constraint(equalTo: privateFixTextView.bottomAnchor, constant: 30).isActive = true
        fixButton.addTarget(self, action: #selector(handleFix), for: .touchUpInside)
        
        scrollView.addSubview(sendButton)
        sendButton.topAnchor.constraint(equalTo: fixButton.topAnchor).isActive = true
        sendButton.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -20).isActive = true
        sendButton.heightAnchor.constraint(equalTo: fixButton.heightAnchor, multiplier: 1).isActive = true
        sendButton.widthAnchor.constraint(equalTo: fixButton.widthAnchor, multiplier: 1).isActive = true
        sendButton.addTarget(self, action: #selector(handleFinalSend), for: .touchUpInside)
        
        scrollView.addSubview(showRecentFixButton)
        let attr = NSMutableAttributedString(string: "NỘI DUNG XỬ LÝ GẦN NHẤT", attributes: [NSAttributedStringKey.underlineStyle : 1])
        showRecentFixButton.titleLabel?.attributedText = attr
        showRecentFixButton.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10).isActive = true
        showRecentFixButton.topAnchor.constraint(equalTo: sendButton.bottomAnchor, constant: 20).isActive = true
        showRecentFixButton.addTarget(self, action: #selector(showRecentFix), for: .touchUpInside)
        
        scrollView.addSubview(systemField)
        systemField.topAnchor.constraint(equalTo: showRecentFixButton.bottomAnchor, constant: 30).isActive = true
        systemField.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        systemField.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -20).isActive = true
        systemField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        scrollView.addSubview(staffField)
        staffField.topAnchor.constraint(equalTo: systemField.bottomAnchor, constant: 30).isActive = true
        staffField.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        staffField.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -20).isActive = true
        staffField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        scrollView.addSubview(recentCauseField)
        recentCauseField.topAnchor.constraint(equalTo: staffField.bottomAnchor, constant: 30).isActive = true
        recentCauseField.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        recentCauseField.widthAnchor.constraint(equalToConstant: (scrollView.frame.width - 40)/2 - 15).isActive = true
        recentCauseField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        scrollView.addSubview(timeField)
        timeField.topAnchor.constraint(equalTo: staffField.bottomAnchor, constant: 30).isActive = true
        timeField.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -20).isActive = true
        timeField.widthAnchor.constraint(equalToConstant: (scrollView.frame.width - 40)/2 - 15).isActive = true
        timeField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        scrollView.addSubview(recentFixLabel)
        recentFixLabel.topAnchor.constraint(equalTo: recentCauseField.bottomAnchor, constant: 20).isActive = true
        recentFixLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        recentFixLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(recentFixTextView)
        recentFixTextView.topAnchor.constraint(equalTo: recentFixLabel.bottomAnchor, constant: 5).isActive = true
        recentFixTextView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        recentFixTextView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -20).isActive = true
        recentFixTextView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        scrollView.addSubview(recentPrivateFixLabel)
        recentPrivateFixLabel.topAnchor.constraint(equalTo: recentFixTextView.bottomAnchor, constant: 20).isActive = true
        recentPrivateFixLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        recentPrivateFixLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(recentPrivateFixTextView)
        recentPrivateFixTextView.topAnchor.constraint(equalTo: recentPrivateFixLabel.bottomAnchor, constant: 5).isActive = true
        recentPrivateFixTextView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        recentPrivateFixTextView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -20).isActive = true
        recentPrivateFixTextView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        scrollView.addSubview(hideRecentFixButton)
        hideRecentFixButton.topAnchor.constraint(equalTo: recentPrivateFixTextView.bottomAnchor, constant: 20).isActive = true
        hideRecentFixButton.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10).isActive = true
        hideRecentFixButton.addTarget(self, action: #selector(hideRecentFix), for: .touchUpInside)
        let attr2 = NSMutableAttributedString(string: "ẨN NỘI DUNG", attributes: [NSAttributedStringKey.underlineStyle : 1])
        hideRecentFixButton.titleLabel?.attributedText = attr2
        // Do any additional setup after loading the view.
    }
    
    @objc private func showRecentFix(){
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 1400)
        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
        scrollView.setContentOffset(bottomOffset, animated: true)
        self.view.setNeedsDisplay()
    }
    
    @objc private func hideRecentFix(){
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 750)
        self.view.setNeedsDisplay()
        self.view.layoutIfNeeded()
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 750)
    }
    
    @objc private func handleFix(){
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        Api.sharedInstance.fix(tickedId: item.getCode(), pro_actua: dateFormatter.string(from: date), pro_content: fixTextView.text, pro_user: User.sharedInstance.getUsername(), pro_dep_code: User.sharedInstance.getRoomId()) { (success, error) in
            if !success {
                return
            }
            self.handleSendNext(completion: { (success) in
                if !success {
                    //
                    print("Error send next")
                    return
                }
                self.showMessage(title: "Gửi xử lý thành công", message: "")
            })
        }
    }
    
    @objc private func handleFinalSend(){
        let ticketID = self.causeIDLevel2.filter({$0.id == self.causeFieldLevel2.getContent!}).first!.id
        Api.sharedInstance.finalSend(ticketId: item.getCode(), causeID: ticketID, content: fixTextView.text, contentPrivate: privateFixTextView.text) { (success, error) in
            if !success {
                return
            }
            self.showMessage(title: "Gửi chuyển tiếp thành công", message: "")
        }
    }
    
    @objc private func handleSendNext(){
        handleSendNext(completion: nil)
    }
    
    private func handleSendNext(completion : ((Bool) -> ())? = nil){
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        Api.sharedInstance.sendNext(id: self.id, receivingUser: User.sharedInstance.getUsername(), receivingDepCode: User.sharedInstance.getRoomId(), receivingDate: dateFormatter.string(from: date), content: fixTextView.text, contentPrivate: privateFixTextView.text) { (success, error) in
            if !success {
                completion?(false)
                return
            }
            completion?(true)
            
        }
    }
}

extension HandleViewController : SkyFloatPickerDelegate {
    
    func getDataForCauseLevel(_ level: Int, parentId : Int? = nil) {
        print("Level ",level)
        Api.sharedInstance.getCauseLevel(level,parentId : parentId) { (success, results, error) in
            if !success {
                return
            }
            var causeName = [String]()
            for cause in results! {
                causeName.append(cause.1)
            }
            if level == 1 {
                self.causeFieldLevel1.setItems = causeName
                self.causeIDLevel1 = results!
            } else {
                self.causeIDLevel2 = results!
                self.causeFieldLevel2.setItems = causeName
            }
        }
    }
    
    func valueDidChanged(fieldType: ApiCategory) {
        switch fieldType {
        case .LEVEL1:
//            let level1ID = causeIDLevel1.filter({$0.name == self.causeFieldLevel1.getContent!}).first!.id
//            Api.sharedInstance.getCauseLevel(2, parentId: Int(level1ID), completion: { (success, results, error) in
//                if !success {
//                    return
//                }
//                var causeName = [String]()
//                for cause in results! {
//                    causeName.append(cause.1)
//                }
//                self.causeFieldLevel2.setItems = causeName
//            })
            self.causeFieldLevel2.setItems = []
        default:
            break
        }
    }
    
    func showPickerView(fieldType: ApiCategory) {
        switch fieldType {
        case .LEVEL1:
            getDataForCauseLevel(1)
        case .LEVEL2:
            print(causeIDLevel1)
            let level1ID = causeIDLevel1.filter({$0.name == self.causeFieldLevel1.getContent!}).first!.id
            getDataForCauseLevel(2, parentId: Int(level1ID)!)
        default:
            break
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            fixTextView.resignFirstResponder()
            privateFixTextView.resignFirstResponder()
            return false
        }
        return true
    }
    
}
