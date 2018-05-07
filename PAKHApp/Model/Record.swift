//
//  Record.swift
//  PAKHApp
//
//  Created by Tung Vu on 2/8/18.
//  Copyright © 2018 Tung Vu. All rights reserved.
//

import Foundation

class Record {
    
    private var stt: String = ""
    private var code : String = ""
    private var title: String = ""
    private var dvYC : String = ""
    private var guyYC: String = ""
    private var timeYC : String = ""
    private var dvXL : String = ""
    private var guyXL : String = ""
    private var status : String = ""
    private var date: String = ""
    private var content: String = ""
    private var system : String = ""
    private var contentXl: String = ""
    
    func setContentXL(xl: String){
        self.contentXl = xl
    }
    
    func getContentXL() -> String {
        return contentXl
    }
    
    func setSystem(system: String) {
        self.system = system
    }
    
    func getSystem() -> String {
        return system
    }
    
    func setStt(stt: String) {
        self.stt = stt
    }
    
    func setCode(code: String){
        self.code = code
    }
    
    func setTitle(title: String) {
        self.title = title
    }
    
    func setDVYC(dvYC: String) {
        self.dvYC = dvYC
    }
    
    func setGuyYC(guyYC: String) {
        self.guyYC = guyYC
    }
    
    func setTimeYC(time: String) {
        self.timeYC = time
    }
    
    func setDVXL(dvXL: String) {
        self.dvXL = dvXL
    }
    
    func setGuyXL(guyXL: String) {
        self.guyXL = guyXL
    }
    
    func setStatus(stt: String) {
        self.status = stt
    }
    
    func setDate(date: String) {
        self.date = date
    }
    
    func setContent(content: String) {
        self.content = content
    }
    
    // Get
    
    func getStt() -> String {
        return stt
    }
    
    func getCode() -> String{
        return code
    }
    
    func getTitle() ->String {
        return title
    }
    
    func getDVYC() -> String {
        return dvYC
    }
    
    func getGuyYC() -> String {
        return guyYC
    }
    
    func getTimeYC() -> String {
        return timeYC
    }
    
    func getDVXL() -> String {
        return dvXL
    }
    
    func getGuyXL() -> String{
        return guyXL
    }
    
    func getStatus() -> String {
        return status
    }
    
    func getDate() -> String {
        return date
    }
    
    func getContent() -> String {
        return content
    }
    
}

class Recent {
    private var id: String = ""
    private var fw_dep_code : String = ""
    private var fw_user : String = ""
    private var dic_cause_id : String = ""
    private var fw_date : String = ""
    private var content : String = ""
    private var privateContent : String = ""
    
    func setId(id: String){
        self.id = id
    }
    
    func getId() -> String {
        return id
    }
    
    func setDepCode(depCode : String) {
        self.fw_dep_code = depCode
    }
    
    func setUser(user: String){
        self.fw_user = user
    }
    
    func setCauseId(id: String) {
        self.dic_cause_id = id
    }
    
    func setDate(date: String) {
        self.fw_date = date
    }
    
    func setContent(_ content : String) {
        self.content = content
    }
    
    func setPrivateContent(_ content : String){
        self.privateContent = content
    }
    
    func getContent() -> String {
        return content
    }
    
    func getPrivateContent() -> String {
        return privateContent
    }
    
    func getDepCode() -> String{
        return fw_dep_code
    }
    
    func getUser() -> String{
        return fw_user
    }
    
    func getCauseId() -> String{
        return dic_cause_id
    }
    
    func getDate() -> String{
        return fw_date
    }

}
