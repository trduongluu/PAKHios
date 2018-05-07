//
//  ViewController.swift
//  PAKHApp
//
//  Created by Tung Vu on 1/28/18.
//  Copyright © 2018 Tung Vu. All rights reserved.
//

import UIKit
import CryptoSwift

public enum Device {
    case Iphone
    case Ipad
}

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    private let api = (UIApplication.shared.delegate as! AppDelegate).apiSharedInstance
    
    private enum ErrorType : Error {
        case empty
        case wrongPassword
        case requestTimeout
        
    }

    // MARK: Views for top view
    
    private let bgImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "Rectangle")
        return image
    }()
    

    private let appLabel2: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white
        lbl.text = "Tiếp nhận và quản lý yêu cầu hỗ trợ hệ thống CNTT"
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "Ubuntu-Regular", size: 20)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.1
        lbl.numberOfLines = 1
        return lbl
    }()
    
    // MARK: Views for bottom View
    private let logoImageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = #imageLiteral(resourceName: "Mobifone_Logo-1")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    // MARK: Views for center View
    
    private let fieldsContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.rgb(red: 34, green: 67, blue: 162).cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private let loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "SignBtn").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy private var usernameField: UITextField = {
        let txtField = UITextField()
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.placeholder = "username"
        txtField.clearButtonMode = .whileEditing
        txtField.font = UIFont(name: "Ubuntu-Regular", size: 17)
        txtField.delegate = self
        return txtField
    }()
    
    private let usernameImageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = #imageLiteral(resourceName: "icons8-user").withRenderingMode(.alwaysOriginal)
        return img
    }()
    
    private let passwordImageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = #imageLiteral(resourceName: "icons8-password").withRenderingMode(.alwaysOriginal)
        return img
    }()
    
    lazy private var passwordField: UITextField = {
        let txtField = UITextField()
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.placeholder = "password"
        txtField.isSecureTextEntry = true
        txtField.font = UIFont(name: "Ubuntu-Regular", size: 17)
        txtField.delegate = self
        return txtField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(textFieldShouldReturn(_:))))
        // Do any additional setup after loading the view, typically from a nib.
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
    
    private func setupUI(type: Device){
        setupTopViews()
        setupCenterViews(type: type)
    }
    
    private func setupTopViews(){
        view.addSubview(bgImageView)
        bgImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        bgImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        bgImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        bgImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        view.addSubview(logoImageView)
        logoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        logoImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
    }

    
    private func setupCenterViews(type: Device){
        view.addSubview(fieldsContainerView)
        fieldsContainerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        fieldsContainerView.heightAnchor.constraint(equalToConstant: type == .Ipad ? 120 : 100).isActive = true
        fieldsContainerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: type == .Ipad ? 1.8/3 : 2.2/3).isActive = true
        fieldsContainerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        view.addSubview(appLabel2)
        appLabel2.centerXAnchor.constraint(equalTo: fieldsContainerView.centerXAnchor).isActive = true
        appLabel2.bottomAnchor.constraint(equalTo: fieldsContainerView.topAnchor, constant: -20).isActive = true
        appLabel2.widthAnchor.constraint(equalTo: fieldsContainerView.widthAnchor).isActive = true
        
        view.addSubview(loginButton)
        loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: fieldsContainerView.bottomAnchor, constant: 60).isActive = true
        loginButton.widthAnchor.constraint(equalTo: fieldsContainerView.widthAnchor, constant: -80).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: type == .Ipad ? 44 : 40).isActive = true
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        let separateView = UIView()
        separateView.translatesAutoresizingMaskIntoConstraints = false
        separateView.backgroundColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        fieldsContainerView.addSubview(separateView)
        separateView.centerYAnchor.constraint(equalTo: fieldsContainerView.centerYAnchor).isActive = true
        separateView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separateView.leftAnchor.constraint(equalTo: fieldsContainerView.leftAnchor, constant: 10).isActive = true
        separateView.rightAnchor.constraint(equalTo: fieldsContainerView.rightAnchor, constant: -10).isActive = true
        
        view.addSubview(usernameImageView)
        usernameImageView.topAnchor.constraint(equalTo: fieldsContainerView.topAnchor, constant: 11).isActive = true
        usernameImageView.leftAnchor.constraint(equalTo: fieldsContainerView.leftAnchor, constant: 8).isActive = true
        usernameImageView.widthAnchor.constraint(equalToConstant: 26).isActive = true
        usernameImageView.heightAnchor.constraint(equalToConstant: 26).isActive = true
        
        view.addSubview(passwordImageView)
        passwordImageView.bottomAnchor.constraint(equalTo: fieldsContainerView.bottomAnchor, constant: -11).isActive = true
        passwordImageView.leftAnchor.constraint(equalTo: fieldsContainerView.leftAnchor, constant: 8).isActive = true
        passwordImageView.widthAnchor.constraint(equalToConstant: 26).isActive = true
        passwordImageView.heightAnchor.constraint(equalToConstant: 26).isActive = true
        
        view.addSubview(usernameField)
        usernameField.leftAnchor.constraint(equalTo: usernameImageView.rightAnchor, constant: 5).isActive = true
        usernameField.rightAnchor.constraint(equalTo: fieldsContainerView.rightAnchor, constant: -5).isActive = true
        usernameField.centerYAnchor.constraint(equalTo: usernameImageView.centerYAnchor, constant: 0).isActive = true
        
        view.addSubview(passwordField)
        passwordField.leftAnchor.constraint(equalTo: passwordImageView.rightAnchor, constant: 5).isActive = true
        passwordField.rightAnchor.constraint(equalTo: fieldsContainerView.rightAnchor, constant: -5).isActive = true
        passwordField.centerYAnchor.constraint(equalTo: passwordImageView.centerYAnchor, constant: 0).isActive = true
    }

    @objc func handleLogin(){
        do {
            try login()
        } catch ErrorType.empty {
            print("Xin hãy điền đầy đủ thông tin vào các trường")
            showMessage(title: "Lỗi", message: "Xin hãy điền đầy đủ thông tin vào các trường")
        } catch {
            print("Unexpected error")
        }
//        let delegate = UIApplication.shared.delegate as! AppDelegate
//        let layout = UICollectionViewFlowLayout()
//        let vc = MenuCollectionViewController(collectionViewLayout: layout)
//        delegate.window?.rootViewController = UINavigationController(rootViewController: vc)
    }
    
    private func login() throws {
        if usernameField.text!.isEmpty || passwordField.text!.isEmpty {
            throw ErrorType.empty
        }
        api.login(username: usernameField.text!.lowercased(), password: passwordField.text!) { (success, user, error) in
            if !success {
                self.showMessage(title: "Lỗi", message: error!)
                return
            }
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let layout = UICollectionViewFlowLayout()
            let vc = MenuCollectionViewController(collectionViewLayout: layout)
            delegate.window?.rootViewController = UINavigationController(rootViewController: vc)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        return false
    }


}

