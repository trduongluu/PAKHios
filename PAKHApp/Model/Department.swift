//
//  Department.swift
//  PAKHApp
//
//  Created by Tung Vu on 2/7/18.
//  Copyright © 2018 Tung Vu. All rights reserved.
//

import Foundation

class Department {
    var id : String
    var depCode : String
    var depName : String?
    init(id: String, depCode: String) {
        self.id = id
        self.depCode = depCode
    }
}
