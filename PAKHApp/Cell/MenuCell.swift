//
//  MenuCell.swift
//  PAKHApp
//
//  Created by Tung Vu on 3/5/18.
//  Copyright © 2018 Tung Vu. All rights reserved.
//

import UIKit

enum MenuType {
    case TYC
    case TKYC
    case XLYC
    case DX
}

struct Menu {
    let title: String!
    let image: UIImage!
    let code: MenuType!
}

class MenuCell: UICollectionViewCell {
    
    let title : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Ubuntu-Regular", size: 17)
        return lbl
    }()
    
    let imageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        addSubview(title)
        title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
        title.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        title.text = "Title"
        addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
}
