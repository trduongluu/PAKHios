//
//  ResultCell.swift
//  PAKHApp
//
//  Created by Tung Vu on 2/1/18.
//  Copyright © 2018 Tung Vu. All rights reserved.
//

import Foundation
import UIKit

class ResultCell: UITableViewCell {
    
    var item: Record? = nil {
        didSet {
            self.sttLabel.text = item?.getStt()
            self.codeLabel.text = item?.getCode()
            self.titleLabel.text = item?.getTitle()
            self.dvLabel.text = item?.getDVYC()
            self.guyLabel.text = item?.getGuyYC()
            self.timeLabel.text = item?.getTimeYC()
            self.dvxlLabel.text = item?.getDVXL()
            self.guyxlLabel.text = item?.getGuyXL()
            switch item!.getStatus() {
            case "PHAN_CONG_XU_LY":
                self.stLabel.text = "PCXL"
            case "DANG_XU_LY" :
                self.stLabel.text = "ĐAXL"
            case "DA_XU_LY":
                self.stLabel.text = "ĐXL"
            default:
                break
            }
            self.dateLabel.text = item?.getDate()
        }
    }
    
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
    
    let fontSize : CGFloat = 11
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
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
        sttLabel.textColor = .black
        codeLabel.setupLabel()
        codeLabel.text = "Mã y/c"
        codeLabel.textColor = .black
        stackView1.addArrangedSubview(sttLabel)
        stackView1.addArrangedSubview(codeLabel)
    }
    
    let titleLabel = UILabel()
    private func setupSecondColumn() {
        titleLabel.setupLabel()
        titleLabel.text = "Tiêu đề y/c"
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .black
        stackView2.addArrangedSubview(titleLabel)
    }
    let dvLabel = UILabel()
    let guyLabel = UILabel()
    private func setupThirdColumn(){
        dvLabel.setupLabel()
        dvLabel.text = "Đ.vị y/c"
        dvLabel.textColor = .black
        guyLabel.setupLabel()
        guyLabel.textColor = .black
        guyLabel.text = "Người y/c"
        guyLabel.textColor = .black
        stackView3.addArrangedSubview(dvLabel)
        stackView3.addArrangedSubview(guyLabel)
    }
    let timeLabel = UILabel()
    private func setupFourthColumn() {
        timeLabel.setupLabel()
        timeLabel.text = "Thời gian"
        timeLabel.numberOfLines = 2
        timeLabel.textColor = .black
        stackView4.addArrangedSubview(timeLabel)
    }
    let dvxlLabel = UILabel()
    let guyxlLabel = UILabel()
    private func setupFithColumn(){
        dvxlLabel.setupLabel()
        dvxlLabel.text = "Đ.vị xử lý"
        dvxlLabel.textColor = .black
        guyxlLabel.setupLabel()
        guyxlLabel.text = "Người xử lý"
        guyxlLabel.textColor = .black
        stackView5.addArrangedSubview(dvxlLabel)
        stackView5.addArrangedSubview(guyxlLabel)
    }
    let stLabel = UILabel()
    let dateLabel = UILabel()
    private func setupSixthColumn(){
        stLabel.setupLabel()
        stLabel.text = "Trạng thái"
        stLabel.textColor = .black
        dateLabel.setupLabel()
        dateLabel.text = "Hạn xử lý"
        dateLabel.textColor = .black
        dateLabel.numberOfLines = 2
        stackView6.addArrangedSubview(stLabel)
        stackView6.addArrangedSubview(dateLabel)
    }

    
    private func setupStackViews(){

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 3
        stackView.addArrangedSubview(stackView1)
        stackView.addArrangedSubview(stackView2)
        stackView.addArrangedSubview(stackView3)
        stackView.addArrangedSubview(stackView4)
        stackView.addArrangedSubview(stackView5)
        stackView.addArrangedSubview(stackView6)
        addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
}
