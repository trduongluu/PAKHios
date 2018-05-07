//
//  SearchViewController.swift
//  PAKHApp
//
//  Created by Tung Vu on 1/29/18.
//  Copyright © 2018 Tung Vu. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    private var deviceType : Device = .Iphone
    
    var type : viewType?
    
    private var activeTextField: UITextField?
    
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
    
    private lazy var codeField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Mã yêu cầu"
        textField.placeholderFont = UIFont(name: "Ubuntu-Regular", size: 13)
        textField.font = UIFont(name: "Ubuntu-Regular", size: 16)
        textField.selectedLineColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        textField.selectedLineHeight = 0.85
        textField.delegate = self
        textField.keyboardType = .numberPad
        return textField
    }()

    
    private let systemField: SkyFloatPicker = {
        let field = SkyFloatPicker()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.fontSize = 16
        field.lineColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        field.placeHolder = "HỆ THỐNG"
        field.type = .SYSTEM
        return field
    }()
    
    private let DVSendField: SkyFloatPicker = {
        let field = SkyFloatPicker()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.fontSize = 16
        field.lineColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        field.placeHolder = "ĐƠN VỊ GỬI YÊU CẦU"
        field.defaultContent = User.sharedInstance.getRoomId()
        field.pickerButtonHidden = true
        return field
    }()

    private let guySendField: SkyFloatPicker = {
        let field = SkyFloatPicker()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.fontSize = 16
        field.lineColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        field.placeHolder = "NGƯỜI GỬI YÊU CẦU"
        field.defaultContent = User.sharedInstance.getUsername()
        field.pickerButtonHidden = true
        return field
    }()

    private let DVReceiveField: SkyFloatPicker = {
        let field = SkyFloatPicker()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.fontSize = 16
        field.lineColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        field.placeHolder = "ĐƠN VỊ XỬ LÝ YÊU CẦU"
        field.type = .PRODEP
        field.defaultContent = "Tất cả"
        return field
    }()
    
    private let guyReceiveField: SkyFloatPicker = {
        let field = SkyFloatPicker()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.fontSize = 16
        field.lineColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        field.placeHolder = "NGƯỜI XỬ LÝ YÊU CẦU"
        field.defaultContent = "Tất cả"
        field.type = .PROGUY
        return field
    }()
    
    private let fromTimeField: SkyFloatPicker = {
        let field = SkyFloatPicker()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.fontSize = 16
        field.lineColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        field.placeHolder = "THỜI GIAN XỬ LÝ YÊU CẦU"
        field.isTimePicker = true
        field.type = .PROGUY
        return field
    }()
    
    private let timeLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Đến"
        lbl.textColor = .black
        return lbl
    }()
    
    private let toTimeField: SkyFloatPicker = {
        let field = SkyFloatPicker()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.fontSize = 16
        field.lineColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        field.placeHolder = ""
        field.isTimePicker = true
        return field
    }()
    
    private let statusField: SkyFloatPicker = {
        let field = SkyFloatPicker()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.fontSize = 16
        field.lineColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        field.placeHolder = "TRẠNG THÁI"
        field.defaultContent = "Tất cả"
        return field
    }()
    
    private let searchButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        btn.layer.cornerRadius = 20
        btn.setTitle("Tìm kiếm", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    private let infoView : SkyInfoView = {
        let infoView = SkyInfoView()
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.title = "Thông tin"
        return infoView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tìm Kiếm"
        view.backgroundColor = .white
        setupNavBar()
        edgesForExtendedLayout = []
        navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        getDataForSystem()
        getNum()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        switch (traitCollection.horizontalSizeClass, traitCollection.verticalSizeClass) {
        case (.regular,.regular):
            self.deviceType = .Ipad
            setupUI(type: deviceType)
        //setup UI for ipad
        case (.compact, .regular):
            self.deviceType = .Iphone
            setupUI(type: deviceType)
        //setup UI for iphone portrait
        default:
            break
        }
    }
    
    private func setupNavBar(){
        let rightBarBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "icons8-info").withRenderingMode(.alwaysOriginal), style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItem = rightBarBtn
        rightBarBtn.action = #selector(handleShowInfo)
    }
    
    private func setupUI(type: Device){
        scrollView.frame = self.view.bounds
        scrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(textFieldShouldReturn(_:))))
    
        scrollView.addSubview(titleTextField)
        titleTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        titleTextField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        automaticConstraint(forView: titleTextField, type: type)
        
        scrollView.addSubview(systemField)
        systemField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 15).isActive = true
        automaticConstraint(forView: systemField, type: type)
        
        scrollView.addSubview(DVSendField)
        DVSendField.topAnchor.constraint(equalTo: systemField.bottomAnchor, constant: 15).isActive = true
        automaticConstraint(forView: DVSendField, andView: guySendField, type: type)
        
        scrollView.addSubview(DVReceiveField)
        DVReceiveField.topAnchor.constraint(equalTo: DVSendField.bottomAnchor, constant: 15).isActive = true
        automaticConstraint(forView: DVReceiveField, andView: guyReceiveField, type: type)
        
        scrollView.addSubview(fromTimeField)
        fromTimeField.topAnchor.constraint(equalTo: DVReceiveField.bottomAnchor, constant: 15).isActive = true
        automaticConstraint(forView: fromTimeField, andView: toTimeField, type: type)
        
        scrollView.addSubview(timeLabel)
        timeLabel.font = UIFont(name: "Ubuntu-Regular", size: deviceType == .Ipad ? 14 : 11)
        timeLabel.bottomAnchor.constraint(equalTo: fromTimeField.bottomAnchor).isActive = true
        timeLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        scrollView.addSubview(codeField)
        codeField.topAnchor.constraint(equalTo: fromTimeField.bottomAnchor, constant: 15).isActive = true
        automaticConstraint(forView: codeField, andView: statusField, type: type)
        statusField.setItems = ["Tất cả","PHAN_CONG_XU_LY","DANG_XU_LY","DA_XU_LY"]
        
        scrollView.addSubview(searchButton)
        searchButton.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: type == .Ipad ? 44 : 40).isActive = true
        searchButton.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, multiplier: 1/2).isActive = true
        searchButton.topAnchor.constraint(equalTo: codeField.bottomAnchor, constant: 70).isActive = true
        searchButton.addTarget(self, action: #selector(handleSearch), for: .touchUpInside)
        
        view.addSubview(scrollView)
        
        systemField.delegate = self
        DVReceiveField.delegate = self
        guyReceiveField.delegate = self
    }
    
    private func automaticConstraint(forView myView : UIView, type: Device) {
        myView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: type == .Iphone ? 10 : 30).isActive = true
        myView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: type == .Iphone ? -10 : -30).isActive = true
        myView.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    private func automaticConstraint(forView leftView : UIView,andView anotherView: UIView, type: Device) {
        leftView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: type == .Iphone ? 10 : 30).isActive = true
        leftView.widthAnchor.constraint(equalToConstant: view.frame.width/2 - (type == .Iphone ? CGFloat(20) : CGFloat(60))).isActive = true
        leftView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        scrollView.addSubview(anotherView)
        anotherView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: type == .Iphone ? -10 : -30).isActive = true
        anotherView.heightAnchor.constraint(equalTo: leftView.heightAnchor, multiplier: 1).isActive = true
        anotherView.topAnchor.constraint(equalTo: leftView.topAnchor).isActive = true
        anotherView.widthAnchor.constraint(equalTo: leftView.widthAnchor, multiplier: 1).isActive = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        codeField.resignFirstResponder()
        return false
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 475)
    }
    
    @objc private func handleShowInfo(){
        view.addSubview(infoView)
        infoView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        infoView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        infoView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        infoView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        getNum()
    }
    
    @objc private func handleAddIssuse(){
        let vc = AddIssuseViewController()
        //vc.type = deviceType
        let vcvc = UINavigationController(rootViewController: vc)
        self.present(vcvc, animated: true, completion: nil)
    }
    
    @objc private func handleSearch(){

        let title = titleTextField.text!.lowercased()
        let system = systemField.getContent!
        let dvReceive = DVReceiveField.getContent! == "Tất cả" ? "" : DVReceiveField.getContent!
        let guyReveive = guyReceiveField.getContent! == "Tất cả" ? "" : guyReceiveField.getContent!
        let codeStr = codeField.text!
        let startTime = fromTimeField.getContent!
        let endTime = toTimeField.getContent!
        var code = 0
        if codeStr != ""{
            code = Int(codeStr)!
        }
        let status = statusField.getContent! == "Tất cả" ? "" : statusField.getContent!
        search(title: title, system: system, pro_dep: dvReceive, pro_guy: guyReveive, code: code, status: status, startTime: startTime, endTime: endTime, completion: { (result) in
            let vc = ResultViewController()
            vc.records = result
            vc.type = self.type
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        })
    }
    
    @objc func handleKeyboard(_ notification : Notification){
        guard let userInfo = notification.userInfo, let activeField = self.activeTextField else {return}
        let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardHeight = keyboardFrame.height
        //print(self.view.frame.height - codeField.frame.maxY , keyboardHeight)
        let codeFieldY = self.view.frame.height - activeField.frame.maxY
        if codeFieldY < keyboardHeight && notification.name == .UIKeyboardWillShow {
            scrollView.contentOffset.y = keyboardHeight - codeFieldY
        } else {
            scrollView.contentOffset.y = 0
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    private func isFieldNull(content: String) -> Bool {
        if content == "Tất cả" {
            return false
        }
        return true
    }

}

extension SearchViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 3
    }
}

extension SearchViewController: SkyFloatPickerDelegate {
    func valueDidChanged(fieldType: ApiCategory) {
        switch fieldType {
        case .PRODEP:
            guyReceiveField.setItems = ["Tất cả"]
            break
        case .PROGUY:
            break
        default:
            break
        }
    }
    
    func getDataForSystem() {
        let api = (UIApplication.shared.delegate as! AppDelegate).apiSharedInstance
        api.getSystemType { (success, results, error) in
            if !success {
                return
            }
            self.systemField.setItems = results!
            if !results!.isEmpty {
                self.systemField.defaultContent = results![0]
            }
        }
    }
    
    func showPickerView(fieldType: ApiCategory) {
        switch fieldType {
        case .PRODEP:
            getDataForDepartment()
            break
        case .PROGUY:
            getStaff()
            break
        default:
            break
        }
    }
    
    private func getDataForDepartment(){
        let api = (UIApplication.shared.delegate as! AppDelegate).apiSharedInstance
        api.getProDepartment(reqType: "") { (success, departments, error) in
            if !success {
                self.showMessage(title: "Error", message: error!)
                return
            }
            var deps = departments!
            deps.insert("Tất cả", at: 0)
            self.DVReceiveField.setItems = deps
        }
    }
    
    private func getStaff(){
        let api = (UIApplication.shared.delegate as! AppDelegate).apiSharedInstance
        let dvContent = DVReceiveField.getContent
        if dvContent != nil && dvContent != "" {
            api.getStaff(depCode: dvContent!) { (success, departments, error) in
                if !success {
                    self.showMessage(title: "Error", message: error!)
                    return
                }
                var deps = departments!
                deps.insert("Tất cả", at: 0)
                self.guyReceiveField.setItems = deps
            }
        }
    }
    
    private func search(title: String, system: String, pro_dep: String, pro_guy: String, code: Int, status: String,startTime: String, endTime: String, completion : @escaping ([Record]) -> ()) {
        let api = (UIApplication.shared.delegate as! AppDelegate).apiSharedInstance
        api.searchRequest(title: title, systemCode: system, reqDV: pro_dep, reqUser: pro_guy, code: code, status: status, startTime: startTime, endTime: endTime) { (success, error,results)  in
            if !success {
                self.showMessage(title: "Error", message: error!)
                return
            }
            completion(results!)
        }
    }
    
    private func getNum() {
        let api = (UIApplication.shared.delegate as! AppDelegate).apiSharedInstance
        api.getNum(reqStatus: "PHAN_CONG_XU_LY") { (success, num1) in
            if !success {return}
            api.getNum(reqStatus: "DANG_XU_LY", completion: { (success, num2) in
                if !success{return}
                api.getNum(reqStatus: "DA_XU_LY", completion: { (success, num3) in
                    if !success{return}
                    self.infoView.items = [("Phân công xử lý",num1), ("Đang xử lý",num2), ("Đã xử lý",num3) ]
                })
            })
        }
    }
}
