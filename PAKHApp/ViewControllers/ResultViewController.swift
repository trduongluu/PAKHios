//
//  ResultViewController.swift
//  PAKHApp
//
//  Created by Tung Vu on 2/1/18.
//  Copyright © 2018 Tung Vu. All rights reserved.
//

import UIKit

enum viewType {
    case Detail
    case Fix
}

class ResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var type : viewType?
    
    var records : [Record] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let stackView1 : UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alignment = .center
        sv.axis = .vertical
        sv.distribution = .fillEqually
        return sv
    }()
    
    private let stackView2 : UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alignment = .center
        sv.axis = .vertical
        sv.distribution = .fillEqually
        return sv
    }()
    
    private let stackView3 : UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alignment = .center
        sv.axis = .vertical
        sv.distribution = .fillEqually
        return sv
    }()
    
    private let stackView4 : UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alignment = .center
        sv.axis = .vertical
        sv.distribution = .fillEqually
        return sv
    }()
    
    private let stackView5 : UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alignment = .center
        sv.axis = .vertical
        sv.distribution = .fillEqually
        return sv
    }()
    
    private let stackView6 : UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alignment = .center
        sv.axis = .vertical
        sv.distribution = .fillEqually
        return sv
    }()
    
    private let infoView : SkyInfoView = {
        let infoView = SkyInfoView()
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.title = "Chú Thích"
        infoView.items = [("PCXL","Phân công xử lý"), ("ĐAXL","Đang xử lý"), ("ĐXL","Đã xử lý")]
        return infoView
    }()

    var separateLine = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Xem yêu cầu"
        edgesForExtendedLayout = []
        setupTopViews()
        setupTableView()
        setupBarButtons()
        // Do any additional setup after loading the view.
    }
    
    private func setupBarButtons(){
        let rightBarBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "icons8-info").withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(handleShowInfo))
        navigationItem.rightBarButtonItem = rightBarBtn
    }
    
    @objc private func handleShowInfo(){
        view.addSubview(infoView)
        infoView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        infoView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        infoView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        infoView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ResultCell
        cell.item = records[indexPath.item]
        if indexPath.item % 2 != 0 {
            cell.backgroundColor = UIColor.yellow.withAlphaComponent(0.5)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if type == .Detail {
            let vc = DetailViewController()
            vc.item = records[indexPath.item]
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
            navigationController?.pushViewController(vc, animated: true)
        } else if type == .Fix {
            let vc = HandleViewController()
            vc.item = records[indexPath.item]
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
            navigationController?.pushViewController(vc, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            let index = tableView.indexPath(for: cell)
            if index!.item % 2 != 0 {
                cell.backgroundColor = UIColor.yellow.withAlphaComponent(0.5)
            }else {
                cell.backgroundColor = .white
            }
        }
    }
    
    private func setupTopViews(){
        setupFirstColumn()
        setupSecondColumn()
        setupThirdColumn()
        setupFourthColumn()
        setupFithColumn()
        setupSixthColumn()
        setupStackViews()
    }
    let sttLabel = UILabel()
    let codeLabel = UILabel()
    private func setupFirstColumn(){
        sttLabel.setupLabel()
        sttLabel.text = "STT"
        codeLabel.setupLabel()
        codeLabel.text = "Mã y/c"
        stackView1.addArrangedSubview(sttLabel)
        stackView1.addArrangedSubview(codeLabel)
    }
    
    let titleLabel = UILabel()
    private func setupSecondColumn() {
        titleLabel.setupLabel()
        titleLabel.text = "Tiêu đề y/c"
        titleLabel.numberOfLines = 2
        stackView2.addArrangedSubview(titleLabel)
    }
    let dvLabel = UILabel()
    let guyLabel = UILabel()
    private func setupThirdColumn(){
        dvLabel.setupLabel()
        dvLabel.text = "Đ.vị y/c"
        guyLabel.setupLabel()
        guyLabel.text = "Người y/c"
        stackView3.addArrangedSubview(dvLabel)
        stackView3.addArrangedSubview(guyLabel)
    }
    let timeLabel = UILabel()
    private func setupFourthColumn() {
        timeLabel.setupLabel()
        timeLabel.text = "Thời gian"
        stackView4.addArrangedSubview(timeLabel)
    }
    let dvxlLabel = UILabel()
    let guyxlLabel = UILabel()
    private func setupFithColumn(){
        dvxlLabel.setupLabel()
        dvxlLabel.text = "Đ.vị xử lý"
        guyxlLabel.setupLabel()
        guyxlLabel.text = "Người xử lý"
        stackView5.addArrangedSubview(dvxlLabel)
        stackView5.addArrangedSubview(guyxlLabel)
    }
    let stLabel = UILabel()
    let dateLabel = UILabel()
    private func setupSixthColumn(){
        stLabel.setupLabel()
        stLabel.text = "Trạng thái"
        dateLabel.setupLabel()
        dateLabel.text = "Hạn xử lý"
        stackView6.addArrangedSubview(stLabel)
        stackView6.addArrangedSubview(dateLabel)
    }

    private func setupStackViews(){
        for i in 1...5 {
            let separatedView = UIView()
            separatedView.backgroundColor = UIColor.rgb(red: 34, green: 67, blue: 162)
            separatedView.frame = CGRect(x: self.view.frame.width / 6 * CGFloat(i), y: 10, width: 0.8, height: 25)
            view.addSubview(separatedView)
        }
        stackView.addArrangedSubview(stackView1)
        stackView.addArrangedSubview(stackView2)
        stackView.addArrangedSubview(stackView3)
        stackView.addArrangedSubview(stackView4)
        stackView.addArrangedSubview(stackView5)
        stackView.addArrangedSubview(stackView6)
        view.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        separateLine.translatesAutoresizingMaskIntoConstraints = false
        separateLine.backgroundColor = UIColor.rgb(red: 34, green: 67, blue: 162)
        view.addSubview(separateLine)
        separateLine.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        separateLine.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        separateLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separateLine.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 5).isActive = true
        
    }
    
    
    private func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ResultCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: separateLine.bottomAnchor,constant: 1).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }

}


