//
//  SkyFloatPicker.swift
//  PAKHApp
//
//  Created by Tung Vu on 1/30/18.
//  Copyright © 2018 Tung Vu. All rights reserved.
//

import Foundation
import UIKit

enum ApiCategory {
    case SYSTEM
    case LEVEL1
    case LEVEL2
    case PRODEP
    case DEP
    case PROGUY
}

protocol SkyFloatPickerDelegate : class {
    func valueDidChanged(fieldType: ApiCategory)
    func showPickerView(fieldType: ApiCategory)
}

class SkyFloatPicker : UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    weak var delegate: SkyFloatPickerDelegate?
    
    var pickerButtonHidden: Bool = false {
        didSet {
            updateUI()
        }
    }
    
    var lineColor: UIColor = .black {
        didSet{
            updateUI()
        }
    }
    
    var fontSize : Double = 17 {
        didSet {
            updateUI()
        }
    }
    
    var placeHolder: String = "" {
        didSet{
            updateUI()
        }
    }
    
    var defaultContent: String = "" {
        didSet{
            updateUI()
        }
    }
    
    var getContent: String? {
        get {
            return self.contentLabel.text
        }
    }
    
    var isTimePicker : Bool = false {
        didSet {
            updateUI()
        }
    }
    
    var setItems : [String] = [] {
        didSet {
            self.items = setItems
            self.defaultContent = setItems.first ?? ""
        }
    }
    
    var getItems : [String] {
        return items
    }
    
    var type : ApiCategory?
    
    private let cancelButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Huỷ", for: .normal)
        return btn
    }()
    
    private let doneButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Chọn", for: .normal)
        return btn
    }()
    
    private var items : [String] = [] {
        didSet {
            pickerView.isUserInteractionEnabled = items.isEmpty ? false : true
            pickerView.reloadAllComponents()
            print("Picker view loaded data")
        }
    }
    
    private lazy var pickerView : UIPickerView = {
        let pv = UIPickerView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        pv.dataSource = self
        pv.delegate = self
        pv.backgroundColor = UIColor.rgb(red: 241, green: 241, blue: 241)
        return pv
    }()
    
    private let bottomLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let pickerButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "icons8-expand_arrow_filled").withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    private let placeHolderLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Ubuntu-Regular", size: 12.5)
        return lbl
    }()
    
    private let contentLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Ubuntu-Regular", size: 14)
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var datePicker : UIDatePicker = {
        let pickerView = UIDatePicker()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.datePickerMode = .date
        pickerView.backgroundColor = UIColor.rgb(red: 241, green: 241, blue: 241)
        return pickerView
    }()
    
    let containerView = UIView()
    var lastContent : String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        addSubview(bottomLine)
        bottomLine.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bottomLine.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        bottomLine.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bottomLine.heightAnchor.constraint(equalToConstant: 0.7).isActive = true
        
        addSubview(pickerButton)
        pickerButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        pickerButton.bottomAnchor.constraint(equalTo: bottomLine.topAnchor, constant: -5).isActive = true
        pickerButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        pickerButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        pickerButton.addTarget(self, action: #selector(handleShowPickerView), for: .touchUpInside)
        
        addSubview(placeHolderLabel)
        placeHolderLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        placeHolderLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
       // placeHolderLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        addSubview(contentLabel)
        contentLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        contentLabel.bottomAnchor.constraint(equalTo: bottomLine.topAnchor, constant: -3).isActive = true
        contentLabel.rightAnchor.constraint(equalTo: pickerButton.leftAnchor, constant: -10).isActive = true
    }
    
    private func updateUI(){
        placeHolderLabel.text = placeHolder
        bottomLine.backgroundColor = lineColor
        contentLabel.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        placeHolderLabel.textColor = lineColor
        contentLabel.text =  defaultContent
        pickerButton.isHidden = pickerButtonHidden
        if isTimePicker {
            let dateFomatter = DateFormatter()
            dateFomatter.dateFormat = "dd-MM-yyyy"
            self.contentLabel.text = dateFomatter.string(from: Date())
        }
    }
    
    private var pvTopConstrant: NSLayoutConstraint!
    
    @objc private func handleShowPickerView(){
        if let myType = type {
            delegate?.showPickerView(fieldType: myType)
        }
        if !isTimePicker {
            addPickerToSuperview(pickerView: pickerView)
        } else {
            addPickerToSuperview(pickerView: datePicker, isDatePicker: true)
        }
    }
    let blackView = UIView()
    private func addPickerToSuperview(pickerView: UIView, isDatePicker: Bool = false){
        if let superView = self.superview?.superview {
            lastContent = self.contentLabel.text!
            blackView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
            blackView.isUserInteractionEnabled = true
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hidePickerView)))
            blackView.frame = superView.bounds
            superView.addSubview(blackView)
            superView.addSubview(pickerView)
            pickerView.leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
            pickerView.rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
            pvTopConstrant = pickerView.topAnchor.constraint(equalTo: superView.bottomAnchor)
            pvTopConstrant.isActive = true
            pickerView.heightAnchor.constraint(equalToConstant: 170).isActive = true
            pvTopConstrant.constant = -170
            if isDatePicker {
                (pickerView as! UIDatePicker).addTarget(self, action: #selector(handlePickDate), for: .valueChanged)
            }
            
            containerView.translatesAutoresizingMaskIntoConstraints = false
            containerView.backgroundColor = .white
            containerView.layer.borderColor = UIColor.lightGray.cgColor
            containerView.layer.borderWidth = 1
            superView.addSubview(containerView)
            containerView.leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
            containerView.rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
            containerView.heightAnchor.constraint(equalToConstant: 30).isActive = true
            containerView.bottomAnchor.constraint(equalTo: pickerView.topAnchor).isActive = true
            containerView.addSubview(cancelButton)
            cancelButton.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
            cancelButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
            cancelButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
            cancelButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
            cancelButton.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
            containerView.addSubview(doneButton)
            doneButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
            doneButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
            doneButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
            doneButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
            doneButton.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
            
        }
    }
    
    @objc private func handleCancel(){
        self.contentLabel.text = lastContent
        hidePickerView()
    }
    
    @objc private func handleDone(){
        hidePickerView()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print(items.count)
        return items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[row]
    }
    
    @objc fileprivate func hidePickerView() {
        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseOut, animations: {
            self.pvTopConstrant.constant = 200
            self.superview?.superview?.layoutIfNeeded()
        }, completion: { (_) in
            self.pickerView.removeFromSuperview()
            self.containerView.removeFromSuperview()
            self.blackView.removeFromSuperview()
        })
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.contentLabel.text = items[row]
        guard let type = type else {return}
        delegate?.valueDidChanged(fieldType: type)
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    @objc private func handlePickDate(){
        let dateFomatter = DateFormatter()
        dateFomatter.dateFormat = "dd-MM-yyyy"
        print(dateFomatter.string(from: datePicker.date))
        contentLabel.text = dateFomatter.string(from: datePicker.date)
    }
    
}

