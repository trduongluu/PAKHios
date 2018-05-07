//
//  MenuViewController.swift
//  PAKHApp
//
//  Created by Tung Vu on 3/5/18.
//  Copyright © 2018 Tung Vu. All rights reserved.
//

import UIKit

class MenuCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let menuItems = [
        Menu(title: "Tạo yêu cầu", image: #imageLiteral(resourceName: "icons8-add-1"), code: .TYC),
        Menu(title: "Tìm kiếm yêu cầu", image: #imageLiteral(resourceName: "icons8-search-1"), code: .TKYC),
        Menu(title: "Xử lý yêu cầu", image: #imageLiteral(resourceName: "icons8-wrench"), code: .XLYC),
        Menu(title: "Đăng xuất", image: #imageLiteral(resourceName: "icons8-logout_rounded_left"), code: .DX)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(MenuCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView?.backgroundColor = .white
        collectionView?.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 5, right: 10)
        collectionView?.alwaysBounceVertical = true
        title = "Chức năng"
        // Do any additional setup after loading the view.
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MenuCell
        cell.title.text = menuItems[indexPath.item].title
        cell.imageView.image = menuItems[indexPath.item].image
        cell.layer.cornerRadius = 5
        cell.backgroundColor = UIColor.white
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowOffset = CGSize.zero
        cell.layer.shadowRadius = 3
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/2 - 20, height: self.view.frame.width / 2 - 20)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = menuItems[indexPath.item]
        switch item.code {
        case .TYC:
            let vc = AddIssuseViewController()
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        case .TKYC:
            let vc = SearchViewController()
            vc.type = .Detail
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        case .XLYC:
            let vc = HandleIssuseViewController()
            vc.type = .Fix
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        case .DX:
            let vc = LoginViewController()
            (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = vc
        default:
            break
        }
    }

}
