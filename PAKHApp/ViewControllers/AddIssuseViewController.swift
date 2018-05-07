//
//  AddIssuseViewController.swift
//  PAKHApp
//
//  Created by Tung Vu on 1/30/18.
//  Copyright © 2018 Tung Vu. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class AddIssuseViewController: UIViewController, UITextFieldDelegate,UITextViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    private let user = User.sharedInstance
    let api = (UIApplication.shared.delegate as! AppDelegate).apiSharedInstance
    
    var departments1 = [Department]()
    var departments2 = [Department]()
    
    var type : Device = .Ipad {
        didSet {
            setupUI()
        }
    }
    
    private lazy var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        return imagePicker
    }()
    
    private let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var titleTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Tiêu đề"
        textField.placeholderFont = UIFont(name: "Ubuntu-Regular", size: 13)
        textField.font = UIFont(name: "Ubuntu-Regular", size: 15)
        textField.selectedLineColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        textField.selectedLineHeight = 0.85
        textField.clearButtonMode = .whileEditing
        textField.delegate = self
        return textField
    }()
    
    private let systemField: SkyFloatPicker = {
        let field = SkyFloatPicker()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.fontSize = 16
        field.lineColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        field.placeHolder = "LOẠI HỆ THỐNG"
        field.type = .SYSTEM
        return field
    }()
    
    private let level1Field: SkyFloatPicker = {
        let field = SkyFloatPicker()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.fontSize = 14
        field.lineColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        field.placeHolder = "YÊU CẦU CẤP 1"
        field.type = .LEVEL1
        return field
    }()
    
    private let level2Field: SkyFloatPicker = {
        let field = SkyFloatPicker()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.fontSize = 14
        field.lineColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        field.placeHolder = "YÊU CẦU CẤP 2"
        field.type = .LEVEL2
        return field
    }()
    
    private let DVReceive: SkyFloatPicker = {
        let field = SkyFloatPicker()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.fontSize = 16
        field.lineColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        field.placeHolder = "ĐƠN VỊ XỬ LÝ"
        field.type = .DEP
        field.pickerButtonHidden = false
        return field
    }()
    
    private let contentLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Ubuntu-Regular", size: 14)
        lbl.textColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        lbl.text = "NỘI DUNG YÊU CẦU"
        return lbl
    }()
    
    private lazy var contentTextView: UITextView = {
        let txtView = UITextView()
        txtView.layer.borderWidth = 1
        txtView.translatesAutoresizingMaskIntoConstraints = false
        txtView.layer.borderColor = UIColor.rgb(red: 34, green: 67, blue: 162).cgColor
        txtView.font = UIFont(name: "Ubuntu-Regular", size: 16)
        txtView.delegate = self
        return txtView
    }()
    
    private let emailCheckbox: SkyCheckbox = {
        let checkBox = SkyCheckbox()
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        checkBox.title = "Nhận Email khi kết thúc yêu cầu"
        checkBox.fontSize = 15
        checkBox.isChecked = true
        return checkBox
    }()
    
    private let smsCheckbox: SkyCheckbox = {
        let checkBox = SkyCheckbox()
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        checkBox.title = "Nhận SMS khi kết thúc yêu cầu"
        checkBox.fontSize = 15
        checkBox.isChecked = true
        return checkBox
    }()
    
    private let sendIssuseBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Gửi yêu cầu", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        btn.layer.cornerRadius = 20
        return btn
    }()
    
    private let saveIssuseBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Lưu bản nháp", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        btn.layer.cornerRadius = 20
        return btn
    }()
    
    private let removeIssuseBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Bỏ qua", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        btn.layer.cornerRadius = 20
        return btn
    }()
    
    private let additionImageBtn: UIImageView = {
        let btn = UIImageView()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.image = #imageLiteral(resourceName: "icons8-compact_camera_filled").withRenderingMode(.alwaysTemplate)
        btn.contentMode = .scaleToFill
        btn.isUserInteractionEnabled = true
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Gửi yêu cầu"
        edgesForExtendedLayout = []
        view.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        switch (traitCollection.horizontalSizeClass, traitCollection.verticalSizeClass) {
        case (.regular,.regular):
            self.type = .Ipad
            DispatchQueue.main.async {
                self.setupUI()
            }
        //setup UI for ipad
        case (.compact, .regular):
            self.type = .Iphone
            DispatchQueue.main.async {
                self.setupUI()
            }
        //setup UI for iphone portrait
        default:
            break
        }
    }

    private func setupUI(){
        scrollView.frame = self.view.bounds
        view.addSubview(scrollView)
        // MARK : Fields
        scrollView.addSubview(titleTextField)
        titleTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        titleTextField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 14).isActive = true
        titleTextField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: type == .Ipad ? -30 : -10).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        scrollView.addSubview(systemField)
        systemField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        systemField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 15).isActive = true
        systemField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: type == .Ipad ? -30 : -10).isActive = true
        systemField.heightAnchor.constraint(equalToConstant: 45).isActive = true

        scrollView.addSubview(level1Field)
        level1Field.topAnchor.constraint(equalTo: systemField.bottomAnchor, constant: 15).isActive = true
        level1Field.leftAnchor.constraint(equalTo: systemField.leftAnchor).isActive = true
        level1Field.widthAnchor.constraint(equalToConstant: (self.scrollView.frame.width - (type == .Ipad ? 60 : 10)) / 2).isActive = true
        level1Field.heightAnchor.constraint(equalToConstant: 45).isActive = true

        scrollView.addSubview(level2Field)
        level2Field.rightAnchor.constraint(equalTo: systemField.rightAnchor, constant: 0).isActive = true
        level2Field.heightAnchor.constraint(equalToConstant: 45).isActive = true
        level2Field.widthAnchor.constraint(equalTo: level1Field.widthAnchor).isActive = true
        level2Field.topAnchor.constraint(equalTo: systemField.bottomAnchor, constant: 15).isActive = true

        scrollView.addSubview(DVReceive)
        DVReceive.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        DVReceive.heightAnchor.constraint(equalToConstant: 45).isActive = true
        DVReceive.topAnchor.constraint(equalTo: level1Field.bottomAnchor, constant: 15).isActive = true
        DVReceive.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: type == .Ipad ? -30 : -10).isActive = true
        
        // MARK : CONTENT

        scrollView.addSubview(contentLabel)
        contentLabel.leftAnchor.constraint(equalTo: systemField.leftAnchor).isActive = true
        contentLabel.topAnchor.constraint(equalTo: DVReceive.bottomAnchor, constant: 15).isActive = true

        scrollView.addSubview(contentTextView)
        contentTextView.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 5).isActive = true
        contentTextView.leftAnchor.constraint(equalTo: contentLabel.leftAnchor).isActive = true
        contentTextView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: type == .Ipad ? -30 : -10).isActive = true
        contentTextView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        // MARK : Checkbox
        
        scrollView.addSubview(additionImageBtn)
        additionImageBtn.tintColor = UIColor.lightGray
        additionImageBtn.topAnchor.constraint(equalTo: contentTextView.bottomAnchor, constant: 15).isActive = true
        additionImageBtn.leftAnchor.constraint(equalTo: systemField.leftAnchor).isActive = true
        additionImageBtn.widthAnchor.constraint(equalToConstant: 45).isActive = true
        additionImageBtn.heightAnchor.constraint(equalToConstant: 45).isActive = true
        additionImageBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAddImage)))
        
        scrollView.addSubview(emailCheckbox)
        emailCheckbox.topAnchor.constraint(equalTo: contentTextView.bottomAnchor, constant: 15).isActive = true
        emailCheckbox.leftAnchor.constraint(equalTo: additionImageBtn.rightAnchor, constant: type == .Ipad ? 30 : 10).isActive = true
        emailCheckbox.widthAnchor.constraint(equalToConstant: ((self.scrollView.frame.width - 50)/2) - (type == .Ipad ? 50 : 13)).isActive = true
        //emailCheckbox.widthAnchor.constraint(equalToConstant: 130).isActive = true
        emailCheckbox.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        scrollView.addSubview(smsCheckbox)
        smsCheckbox.leftAnchor.constraint(equalTo: emailCheckbox.rightAnchor, constant: type == .Ipad ? 30 : 10).isActive = true
        smsCheckbox.heightAnchor.constraint(equalToConstant: 45).isActive = true
        smsCheckbox.widthAnchor.constraint(equalTo: emailCheckbox.widthAnchor).isActive = true
        smsCheckbox.topAnchor.constraint(equalTo: contentTextView.bottomAnchor, constant: 15).isActive = true
        
        let horizonalLine = UIView()
        horizonalLine.translatesAutoresizingMaskIntoConstraints = false
        horizonalLine.backgroundColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        scrollView.addSubview(horizonalLine)
        horizonalLine.topAnchor.constraint(equalTo: additionImageBtn.bottomAnchor, constant: 5).isActive = true
        horizonalLine.leftAnchor.constraint(equalTo: additionImageBtn.leftAnchor).isActive = true
        horizonalLine.rightAnchor.constraint(equalTo: smsCheckbox.rightAnchor).isActive = true
        horizonalLine.heightAnchor.constraint(equalToConstant: 0.7).isActive = true
        
        let verticalLine1 = UIView()
        verticalLine1.translatesAutoresizingMaskIntoConstraints = false
        verticalLine1.backgroundColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        scrollView.addSubview(verticalLine1)
        verticalLine1.centerYAnchor.constraint(equalTo: smsCheckbox.centerYAnchor, constant: 5).isActive = true
        verticalLine1.leftAnchor.constraint(equalTo: emailCheckbox.rightAnchor, constant : 5).isActive = true
        verticalLine1.widthAnchor.constraint(equalToConstant: 0.7).isActive = true
        verticalLine1.topAnchor.constraint(equalTo: smsCheckbox.topAnchor, constant: 3).isActive = true
        verticalLine1.bottomAnchor.constraint(equalTo: smsCheckbox.bottomAnchor, constant: -3).isActive = true
        
        let verticalLine2 = UIView()
        verticalLine2.translatesAutoresizingMaskIntoConstraints = false
        verticalLine2.backgroundColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        scrollView.addSubview(verticalLine2)
        verticalLine2.centerYAnchor.constraint(equalTo: smsCheckbox.centerYAnchor, constant: 5).isActive = true
        verticalLine2.leftAnchor.constraint(equalTo: additionImageBtn.rightAnchor, constant : 5).isActive = true
        verticalLine2.widthAnchor.constraint(equalToConstant: 0.7).isActive = true
        verticalLine2.topAnchor.constraint(equalTo: smsCheckbox.topAnchor, constant: 3).isActive = true
        verticalLine2.bottomAnchor.constraint(equalTo: smsCheckbox.bottomAnchor, constant: -3).isActive = true
        
        // MARK : Buttons :
        scrollView.addSubview(sendIssuseBtn)
        sendIssuseBtn.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        sendIssuseBtn.heightAnchor.constraint(equalToConstant: type == .Ipad ? 44 : 40).isActive = true
        sendIssuseBtn.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: type == .Ipad ? 1/2 : 2/3).isActive = true
        sendIssuseBtn.topAnchor.constraint(equalTo: horizonalLine.bottomAnchor, constant: type == .Ipad ? 50 : 25).isActive = true
        sendIssuseBtn.tag = 0
        sendIssuseBtn.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        
        scrollView.addSubview(saveIssuseBtn)
        saveIssuseBtn.leftAnchor.constraint(equalTo: sendIssuseBtn.leftAnchor, constant: type == .Ipad ? -30 : -20).isActive = true
        saveIssuseBtn.widthAnchor.constraint(equalTo: sendIssuseBtn.widthAnchor, multiplier: 1/2).isActive = true
        saveIssuseBtn.heightAnchor.constraint(equalToConstant: type == .Ipad ? 44 : 40).isActive = true
        saveIssuseBtn.topAnchor.constraint(equalTo: sendIssuseBtn.bottomAnchor, constant: type == .Ipad ? 20 : 10).isActive = true
        saveIssuseBtn.tag = 1
        saveIssuseBtn.addTarget(self, action: #selector(handleSend(_:)), for: .touchUpInside)
        
        scrollView.addSubview(removeIssuseBtn)
        removeIssuseBtn.rightAnchor.constraint(equalTo: sendIssuseBtn.rightAnchor, constant: type == .Ipad ? 30 : 20).isActive = true
        removeIssuseBtn.widthAnchor.constraint(equalTo: sendIssuseBtn.widthAnchor, multiplier: 1/2).isActive = true
        removeIssuseBtn.heightAnchor.constraint(equalToConstant: type == .Ipad ? 44 : 40).isActive = true
        removeIssuseBtn.topAnchor.constraint(equalTo: sendIssuseBtn.bottomAnchor, constant: type == .Ipad ? 20 : 10).isActive = true
        removeIssuseBtn.addTarget(self, action: #selector(handleRemoveView), for: .touchUpInside)
        
        // Delegates :
        systemField.delegate = self
        level1Field.delegate = self
        level2Field.delegate = self
        DVReceive.delegate = self
        getDataForSystem()
    }

    override func viewDidLayoutSubviews() {
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 700)
    }
    
    @objc private func handleRemoveView(){
        let alertController = UIAlertController(title: "Huỷ yêu cầu", message: "Bạn có chắc muốn huỷ yêu cầu ?", preferredStyle: .alert)
        let removeAction = UIAlertAction(title: "Huỷ", style: .cancel) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Không", style: .default, handler: nil)
        alertController.addAction(removeAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc private func handleAddImage(){
        let alertController = UIAlertController(title: "Thêm", message: "", preferredStyle: .actionSheet)
        alertController.popoverPresentationController?.sourceView = self.view
        alertController.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        alertController.popoverPresentationController?.permittedArrowDirections = []
        let chooseImage = UIAlertAction(title: "Chọn ảnh", style: .default) { (_) in
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let removeImage = UIAlertAction(title: "Huỷ ảnh chọn", style: .default) { (_) in
            self.additionImageBtn.image = #imageLiteral(resourceName: "icons8-image").withRenderingMode(.alwaysTemplate)
            self.additionImageBtn.tintColor = UIColor.lightGray
        }
        let mySelectedAttributedTitle = NSAttributedString(string: "Huỷ ảnh chọn",attributes: [NSAttributedStringKey.foregroundColor : UIColor.red])
        if #available(iOS 11.0, *) {
            removeImage.accessibilityAttributedValue = mySelectedAttributedTitle
        } else {
            // Fallback on earlier versions
        }
        
        let cancelAction = UIAlertAction(title: "Huỷ", style: .cancel, handler: nil)
        alertController.addAction(chooseImage)
        alertController.addAction(removeImage)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImage : UIImage?
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage{
            selectedImage = editedImage
        }
        if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImage = originalImage
        }
        if let selectedImage = selectedImage {
            self.additionImageBtn.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.titleTextField.resignFirstResponder()
        return false
    }
    
    @objc private func handleSend(_ sender: UIButton) {
        if systemField.getContent! != "" && titleTextField.text! != "" && level1Field.getContent! != "" && level2Field.getContent != "" && DVReceive.getContent! != "" {
            let tag = sender.tag
            let status = tag == 0 ? "PHAN_CONG_XU_LY" : "BAN_NHAP"
            let title = titleTextField.text ?? "null"
            let prodep = DVReceive.getContent ?? "null"
            let content = contentTextView.text ?? ""
            let sms = smsCheckbox.getContent
            let email = emailCheckbox.getContent
            api.sendRequest(title: title,system: systemField.getContent!, proDep: prodep, content: content, sms: sms, email: email, status: status, completion: { (success, error) in
                if !success {
                    self.showMessage(title: "Error", message: error!)
                }
                self.handleShowMessageSentRequest()
            })
        }
        else {
            showMessage(title: "Error", message: "Các thông tin chưa được điền đầy đủ.")
        }
    }
    
    private func handleShowMessageSentRequest(){
        let alert = UIAlertController(title: "Thông báo", message: "Đã gửi yêu cầu thành công", preferredStyle: .alert)
        let action = UIAlertAction(title: "Đồng ý", style: .default) { (_) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            contentTextView.resignFirstResponder()
            return false
        }
        return true
    }

}

extension AddIssuseViewController: SkyFloatPickerDelegate {
    func valueDidChanged(fieldType: ApiCategory) {
        switch fieldType {
        case .SYSTEM:
            self.level1Field.setItems = []
            self.level2Field.setItems = []
            self.DVReceive.setItems = []
            getDataForLevel(reqId: "0")
        case .LEVEL1:
            self.level2Field.setItems = []
            self.DVReceive.setItems = []
            if let dep = departments1.filter({$0.depCode == (level1Field.getContent)!}).first {
                getDataForLevel(reqId: dep.id)
            }
        case .LEVEL2:
            self.DVReceive.setItems = []
            let depId = getDepId()
            if depId != "" {
                getDataForProcesser(depId : depId)
            }
        default:
            break
        }
    }
    
    func showPickerView(fieldType: ApiCategory) {
        switch fieldType {
        case .SYSTEM:
            getDataForSystem()
        case .LEVEL1:
            getDataForLevel(reqId: "0")
        case .LEVEL2:
            level2Field.setItems = []
            if let dep = departments1.filter({$0.depCode == (level1Field.getContent)!}).first {
                getDataForLevel(reqId: dep.id)
            }
        case .DEP:
            let depId = getDepId()
            if depId != "" {
                getDataForProcesser(depId : depId)
            }
        default:
            break
        }
    }
    
    private func getDataForSystem() {
        api.getSystemType { (success, results, error) in
            if !success {
                return
            }
            self.systemField.setItems = results!
            self.systemField.defaultContent = results!.first ?? ""
        }
    }
    
    private func getDataForLevel(reqId: String) {
        api.getReqLevel(reqId: reqId, sysCode: self.systemField.getContent ?? "") { (success, departments, error) in
            if !success {
                return
            }
            var depsCode = [String]()
            for department in departments! {
                depsCode.append(department.depCode)
            }
            if reqId == "0" {
                self.departments1 = departments!
                self.level1Field.defaultContent = depsCode.first ?? ""
                self.level1Field.setItems = depsCode
                // Sau khi chọn cấp 1 sẽ auto load ra cấp 2
                if let dep = self.departments1.filter({$0.depCode == (self.level1Field.getContent)!}).first {
                    self.getDataForLevel(reqId: dep.id)
                }
            } else {
                self.departments2 = departments!
                self.level2Field.defaultContent = depsCode.first ?? ""
                self.level2Field.setItems = depsCode
                //Sau khi chọn cấp 2 sẽ load ra DVXL
                let depId = self.getDepId()
                if depId != "" {
                    self.getDataForProcesser(depId : depId)
                }
            }
         }
    }
    
    private func getDepId() -> String{
        var depId = ""
        if level2Field.getContent! != "" {
            if let dep = departments2.filter({$0.depCode == level2Field.getContent!}).first {
                depId = dep.id
            }
        }
        return depId
    }
    
    private func getDataForProcesser(depId: String) {
        api.getProcesser(depId: depId) { (success, result) in
            if !success {
                return
            }
            self.DVReceive.setItems = [result!]
        }
    }
    
    
}

