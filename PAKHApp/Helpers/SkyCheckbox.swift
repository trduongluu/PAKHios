//
//  SkyCheckbox.swift
//  PAKHApp
//
//  Created by Tung Vu on 1/31/18.
//  Copyright © 2018 Tung Vu. All rights reserved.
//

import Foundation
import UIKit
class SkyCheckbox: UIView {
    
    var title: String = "" {
        didSet {
            updateUI()
        }
    }
    
    var fontSize: CGFloat = 16 {
        didSet {
            updateUI()
        }
    }
    
    var isChecked: Bool = true {
        didSet {
            updateUI()
        }
    }
    
    var getContent : String {
        get {
            return checkboxBtn.imageView?.image == #imageLiteral(resourceName: "icons8-unchecked_checkbox") ? "N" : "Y"
        }
    }
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        lbl.font = UIFont(name: "Ubuntu-Regular", size: 16)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.1
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let checkboxBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        addSubview(checkboxBtn)
        checkboxBtn.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        checkboxBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        checkboxBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        checkboxBtn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        checkboxBtn.setImage(#imageLiteral(resourceName: "icons8-checked_checkbox").withRenderingMode(.alwaysOriginal), for: .normal)
        checkboxBtn.addTarget(self, action: #selector(handleCheck), for: .touchUpInside)
        titleLabel.rightAnchor.constraint(equalTo: checkboxBtn.leftAnchor, constant: -5).isActive = true
    }
    
    private func updateUI(){
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: fontSize)
        if isChecked {
            checkboxBtn.setImage(#imageLiteral(resourceName: "icons8-checked_checkbox").withRenderingMode(.alwaysOriginal), for: .normal)
            checkboxBtn.tag = 1
        } else {
            checkboxBtn.setImage(#imageLiteral(resourceName: "icons8-unchecked_checkbox").withRenderingMode(.alwaysOriginal), for: .normal)
            checkboxBtn.tag = 0
        }
    }
    
    @objc private func handleCheck(){
        isChecked = !isChecked
    }
    
    
}
