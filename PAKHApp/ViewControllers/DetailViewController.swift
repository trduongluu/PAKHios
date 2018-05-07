//
//  DetailViewController.swift
//  PAKHApp
//
//  Created by Tung Vu on 2/1/18.
//  Copyright © 2018 Tung Vu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    var item : Record = Record() {
        didSet {
            self.titleField.defaultContent = item.getTitle()
            self.contentField.defaultContent = item.getContent()
            self.systemField.defaultContent = item.getSystem()
            self.DVField.defaultContent = item.getDVXL()
            self.guyField.defaultContent = item.getGuyXL()
            self.timeField.defaultContent = item.getTimeYC()
            self.dateField.defaultContent = item.getDate()
            self.contentTextView.text = item.getContentXL()
        }
    }
    
    private let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private let titleField: SkyFloatPicker = {
        let field = SkyFloatPicker()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.fontSize = 16
        field.lineColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        field.placeHolder = "TIỀU ĐỀ"
        field.pickerButtonHidden = true
        return field
    }()
    
    private let contentField: SkyFloatPicker = {
        let field = SkyFloatPicker()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.fontSize = 16
        field.lineColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        field.placeHolder = "NỘI DUNG"
        field.pickerButtonHidden = true
        return field
    }()
    
    private let systemField: SkyFloatPicker = {
        let field = SkyFloatPicker()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.fontSize = 16
        field.lineColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        field.placeHolder = "HỆ THỐNG"
        field.pickerButtonHidden = true
        return field
    }()
    
    private let DVField: SkyFloatPicker = {
        let field = SkyFloatPicker()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.fontSize = 16
        field.lineColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        field.placeHolder = "ĐƠN VỊ XỬ LÝ"
        field.pickerButtonHidden = true
        return field
    }()
    
    private let guyField: SkyFloatPicker = {
        let field = SkyFloatPicker()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.fontSize = 16
        field.lineColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        field.placeHolder = "NGƯỜI XỬ LÝ"
        field.pickerButtonHidden = true
        return field
    }()
    
    private let timeField: SkyFloatPicker = {
        let field = SkyFloatPicker()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.fontSize = 16
        field.lineColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        field.placeHolder = "THỜI GIAN XỬ LÝ"
        field.pickerButtonHidden = true
        return field
    }()
    
    private let dateField: SkyFloatPicker = {
        let field = SkyFloatPicker()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.fontSize = 16
        field.lineColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        field.placeHolder = "HẠN XỬ LÝ"
        field.pickerButtonHidden = true
        return field
    }()
    
    private lazy var contentTextView: UITextView = {
        let txtView = UITextView()
        txtView.layer.borderWidth = 1
        txtView.translatesAutoresizingMaskIntoConstraints = false
        txtView.layer.borderColor = UIColor.rgb(red: 34, green: 67, blue: 162).cgColor
        txtView.font = UIFont(name: "Ubuntu-Regular", size: 16)
        txtView.isUserInteractionEnabled = false
        return txtView
    }()
    
    private let contentLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Ubuntu-Regular", size: 14)
        lbl.textColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        lbl.text = "NỘI DUNG XỬ LÝ"
        return lbl
    }()

    private let additionImage: UIImageView = {
        let btn = UIImageView()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.image = #imageLiteral(resourceName: "icons8-compact_camera_filled").withRenderingMode(.alwaysTemplate)
        btn.contentMode = .scaleToFill
        btn.isUserInteractionEnabled = true
        return btn
    }()
    
    private let additionLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Ubuntu-Regular", size: 14)
        lbl.textColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        lbl.text = "Tệp đính kèm"
        return lbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chi tiết"
        edgesForExtendedLayout = []
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = .white
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    
    private func setupUI(type: Device) {
        
        scrollView.frame = self.view.bounds
        view.addSubview(scrollView)
        scrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(textFieldShouldReturn(_:))))
        
        scrollView.addSubview(titleField)
        titleField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15).isActive = true
        automaticConstraint(forView: titleField, type: type)
        scrollView.addSubview(contentField)
        contentField.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 15).isActive = true
        automaticConstraint(forView: contentField, type: type)
        scrollView.addSubview(systemField)
        systemField.topAnchor.constraint(equalTo: contentField.bottomAnchor, constant: 15).isActive = true
        automaticConstraint(forView: systemField, type: type)
        scrollView.addSubview(DVField)
        DVField.topAnchor.constraint(equalTo: systemField.bottomAnchor, constant: 15).isActive = true
        automaticConstraint(forView: DVField, type: type)
        scrollView.addSubview(guyField)
        guyField.topAnchor.constraint(equalTo: DVField.bottomAnchor, constant: 15).isActive = true
        automaticConstraint(forView: guyField, type: type)
        scrollView.addSubview(timeField)
        timeField.topAnchor.constraint(equalTo: guyField.bottomAnchor, constant: 15).isActive = true
        timeField.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: type == .Iphone ? 10 : 30).isActive = true
        timeField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        timeField.widthAnchor.constraint(equalToConstant: (scrollView.frame.width - (type == .Iphone ? 20 : 60))/2).isActive = true
        scrollView.addSubview(dateField)
        dateField.topAnchor.constraint(equalTo: guyField.bottomAnchor, constant: 15).isActive = true
        dateField.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: type == .Iphone ? -10 : -30).isActive = true
        dateField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        dateField.widthAnchor.constraint(equalToConstant: (scrollView.frame.width - (type == .Iphone ? 20 : 60))/2).isActive = true

        scrollView.addSubview(contentLabel)
        contentLabel.topAnchor.constraint(equalTo: dateField.bottomAnchor, constant: 15).isActive = true
        contentLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: type == .Iphone ? 10 : 30).isActive = true
        scrollView.addSubview(contentTextView)
        contentTextView.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 5).isActive = true
        contentTextView.leftAnchor.constraint(equalTo: contentLabel.leftAnchor).isActive = true
        contentTextView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: type == .Iphone ? -10 : -30).isActive = true
        contentTextView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        scrollView.addSubview(additionLabel)
        additionLabel.topAnchor.constraint(equalTo: contentTextView.bottomAnchor, constant: 15).isActive = true
        additionLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: type == .Iphone ? 10 : 30).isActive = true
        scrollView.addSubview(additionImage)
        additionImage.tintColor = UIColor.lightGray
        additionImage.topAnchor.constraint(equalTo: additionLabel.topAnchor, constant: 0).isActive = true
        additionImage.leftAnchor.constraint(equalTo: additionLabel.rightAnchor, constant: 5).isActive = true
        additionImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        additionImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func automaticConstraint(forView myView : UIView, type: Device) {
        myView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        myView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: type == .Iphone ? 10 : 30).isActive = true
        myView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: type == .Iphone ? -10 : -30).isActive = true
        myView.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return false
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        switch (traitCollection.horizontalSizeClass, traitCollection.verticalSizeClass) {
        case (.regular,.regular):
            setupUI(type: .Ipad)
        //setup UI for ipad
        case (.compact, .regular):
            setupUI(type: .Iphone)
        //setup UI for iphone portrait
        default:
            break
        }
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 700)
    }


}
