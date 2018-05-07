//
//  SkyInfoView.swift
//  PAKHApp
//
//  Created by Tung Vu on 2/1/18.
//  Copyright © 2018 Tung Vu. All rights reserved.
//

import Foundation
import UIKit

class SkyInfoView : UIView {
    
    var title: String? = nil
    
    var color : UIColor = UIColor.rgb(red: 34, green: 67, blue: 162) {
        didSet {
            updateUI()
        }
    }
    
    var items : [(String, String)] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.dataSource = self
        tv.delegate = self
        tv.layer.cornerRadius = 8
        tv.register(SkyCell.self, forCellReuseIdentifier: "skyCell")
        return tv
    }()
    
    private let backgroundView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let disapearButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Ẩn", for: .normal)
        btn.layer.cornerRadius = 20
        btn.backgroundColor = .white
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        addSubview(backgroundView)
        backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        backgroundView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissView)))
        addSubview(tableView)
        tableView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        tableView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -50).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        tableView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 2.6/3).isActive = true
        addSubview(disapearButton)
        disapearButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 50).isActive = true
        disapearButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        disapearButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.2/2).isActive = true
        disapearButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        disapearButton.setTitleColor(color, for: .normal)
        disapearButton.addTarget(self, action: #selector(handleDismissView), for: .touchUpInside)
    }
    
    private func updateUI() {
        disapearButton.setTitleColor(color, for: .normal)
    }
    
    @objc private func handleDismissView(){
        self.removeFromSuperview()
    }
    
}

extension SkyInfoView : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "skyCell", for: indexPath) as! SkyCell
        cell.item = items[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / CGFloat(items.count) - 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UILabel()
        headerView.textColor = .black
        headerView.adjustsFontSizeToFitWidth = true
        headerView.minimumScaleFactor = 0.1
        headerView.textAlignment = .center
        headerView.text = title
        headerView.font = UIFont.boldSystemFont(ofSize: 15)
        headerView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        headerView.heightAnchor.constraint(equalToConstant: 50)
        return headerView
    }

}

class SkyCell : UITableViewCell {
    
    var item : (String, String)? = nil{
        didSet {
            itemTitleLabel.text = item?.0
            itemLabel.text = item?.1
        }
    }
    
    private let itemTitleLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Ubuntu-Regular", size: 15)
        return lbl
    }()
    
    private let itemLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Ubuntu-Regular", size: 15)
        lbl.textColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        lbl.textAlignment = .right
        return lbl
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        addSubview(itemTitleLabel)
        itemTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        itemTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(itemLabel)
        itemLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        itemLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    
    }
}
