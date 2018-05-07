//
//  User.swift
//  PAKHApp
//
//  Created by Tung Vu on 2/7/18.
//  Copyright © 2018 Tung Vu. All rights reserved.
//

import Foundation

class User {
    static let sharedInstance = User()
    private init() {}
    private var username : String = ""
    private var roomId : String = ""
    private var password : String = ""
    private var fullname: String = ""
    
    func setUsername(username: String) {
        self.username = username
    }
    func getUsername() -> String {
        return username
    }
    
    func setPassword(password: String) {
        self.password = password
    }
//    func getPassword() -> String {
//        return username
//    }
    
    func setRoomId(roomId: String) {
        self.roomId = roomId
    }
    func getRoomId() -> String {
        return roomId
    }
    
    func setFullname(name: String) {
        self.fullname = name
    }
    func getFullname() -> String {
        return fullname
    }

}
