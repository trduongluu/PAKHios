//
//  Api.swift
//  PAKHApp
//
//  Created by Tung Vu on 2/7/18.
//  Copyright © 2018 Tung Vu. All rights reserved.
//

import Foundation
import Alamofire
import CryptoSwift

class Api {
    static let sharedInstance = Api()
    private let user = User.sharedInstance
    private init(){}
    
    private var baseString = "http://103.199.78.64:80/"
    
    func login(username: String,password: String, completion : @escaping (Bool, User?, String?) -> ()) {
        let urlString = baseString + "user/\(username)"
        let url = URL(string: urlString)!
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .validate(statusCode: 200..<500)
            .responseJSON { (response) in
                switch response.result {
                case .failure :
                    completion(false, nil,"Lỗi hệ thống. Xin hãy thử lại sau.")
                    break
                case .success :
                    if let userDict = response.result.value as? [String : AnyObject] {
                        guard let fullname = userDict["fullname"] as? String, let username = userDict["username"] as? String,
                            let passWord = userDict["password"] as? String , let roomId = userDict["departmentCode"] as? String else {
                                completion(false, nil, "Tài khoản này không tồn tại.")
                                return}
                        if password.md5() == passWord {
                            self.user.setFullname(name: fullname)
                            self.user.setUsername(username: username)
                            self.user.setPassword(password: password)
                            self.user.setRoomId(roomId: roomId)
                            completion(true, self.user, nil)
                        } else { completion(false, nil, "Sai mật khẩu hoặc username.")}
                    }
                }
            }
        }
    
    func getSystemType(completion: @escaping (Bool, [String]?, String?) -> ()) {
        let urlString = baseString + "sys/\(user.getRoomId())"
        let url = URL(string: urlString)!
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .failure :
                completion(false,nil,"Lỗi không mong đợi. Xin hãy thử lại sau")
                break
            case .success :
                var systemsCode : [String] = []
                if let userArray = response.result.value as? NSArray {
                    for systemDict in userArray {
                        if let system = systemDict as? [String : AnyObject] {
                            let systemCode = system["systemCode"] as! String
                            systemsCode.append(systemCode)
                        }
                    }
                }
                completion(true, systemsCode, nil)
            }
        }
    }
    
    func getReqLevel(reqId: String, sysCode: String, completion: @escaping (Bool,[Department]?, String?) -> ()) {
        var reqString = ""
        if reqId == "0" {
            reqString = "null"
        } else {
            reqString = reqId
        }
        
        let params : Parameters = [
            "departmentCode" : User.sharedInstance.getRoomId(),
            "systemCode" : sysCode,
            "isHas" : reqString,
            "username" : User.sharedInstance.getUsername(),
        ]
        
        let urlString = baseString + "request/type"
        let url = URL(string: urlString)!
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding(destination : .queryString), headers: nil).responseJSON { (response) in
            switch response.result {
            case .failure :
                completion(false,nil,"Lỗi không mong đợi. Xin hãy thử lại sau")
                break
            case .success :
                var reqs : [Department] = []
                if let userArray = response.result.value as? NSArray {
                    for systemDict in userArray {
                        if let system = systemDict as? [String : AnyObject] {
                            let depCode = system["requestCode"] as! String
                            let id = system["id"] as! String
                            let department = Department(id: id, depCode: depCode)
                            reqs.append(department)
                        }
                    }
                     completion(true, reqs, nil)
                }
            }
        }
    }
    
    func getProcesser(depId : String, completion : @escaping (Bool, String?) -> ()) {
        let urlString = baseString + "process/\(depId)"
        let url = URL(string: urlString)!
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseString { (response) in
            switch response.result {
            case .failure :
                completion(false,"Lỗi không mong đợi. Xin hãy thử lại sau")
                break
            case .success :
                let processer = response.result.value!
                completion(true, processer)
            }
        }
    }
    
    func sendRequest(title: String, system : String, proDep: String, content: String, sms: String, email: String, status: String, completion:@escaping (Bool, String?) -> ()) {
        let urlString = baseString + "request/post/"
        let depCode = user.getRoomId()
        let reqUser = user.getUsername()
        let params : Parameters = [
            "req_title" : title,
            "receiving_sms" : sms,
            "file_dir" : "null",
            "req_status" : status,
            "req_dep_code" : depCode,
            "req_system_code" : system,
            "req_user" : reqUser,
            "pro_dep_code" : proDep,
            "req_content" : content,
            "receiving_email" : email,
        ]
        let url = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding(destination : .queryString), headers: nil)
            .validate(statusCode: 200..<500)
            .responseString { (response) in
            switch response.result {
            case .failure(let error) :
                completion(false, error.localizedDescription)
                break
            case .success :
                print(response.debugDescription)
                completion(true, nil)
                break
            }
        }
    }
    
    func getProDepartment(reqType: String, completion:@escaping (Bool, [String]?, String?)->()) {
        let urlString = baseString + "depart"
        let url = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .failure(let error) :
                completion(false,nil, error.localizedDescription)
                break
            case .success :
                var deps = [String]()
                if let depArray = response.result.value as? NSArray {
                    for dep in depArray {
                        if let depDict = dep as? [String: AnyObject] {
                            let depCode = depDict["departmentCode"] as! String
                            deps.append(depCode)
                        }
                    }
                }
                completion(true, deps, nil)
            }
        }
    }
    
    func getStaff(depCode: String, completion: @escaping (Bool, [String]?, String?)-> ()) {
        let urlString = baseString + "staff/\(depCode)"
        let url = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .failure(let error) :
                completion(false,nil, error.localizedDescription)
                break
            case .success :
                var deps = [String]()
                if let depArray = response.result.value as? NSArray {
                    for dep in depArray {
                        if let depDict = dep as? [String: AnyObject] {
                            let depCode = depDict["username"] as! String
                            deps.append(depCode)
                        }
                    }
                }
                completion(true, deps, nil)
            }
        }
    }
    
    func searchRequest(title: String, systemCode: String,reqDV: String, reqUser: String,code: Int, status: String,startTime: String, endTime: String, completion: @escaping (Bool, String?,[Record]?) -> ()) {
        let urlString = baseString + "request/get"
        let url = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let params : Parameters = [
            "req_title" : title,
            "req_system_code" : systemCode,
            "req_dep_code" : user.getRoomId(),
            "req_user" : user.getUsername(),
            "pro_dep_code" : reqDV,
            "pro_user" : reqUser,
            "ticketid" : code == 0 ? "" : code,
            "req_status": status,
            "start_req_date" : startTime,
            "end_req_date" : endTime
        ]
        
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding(destination: .queryString), headers: nil)
            .validate(statusCode: 200..<500)
            .responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(false, error.localizedDescription, nil)
            case .success:
                var records = [Record]()
                if let recordArray = response.result.value as? NSArray {
                    for record in recordArray {
                        if let dict = record as? [String: AnyObject] {
                            let id = dict["id"] as? String
                            let code = dict["ticket_id"] as? String
                            let title = dict["req_title"] as? String
                            let content = dict["req_content"] as? String
                            let system = dict["req_system_code"] as? String
                            let dvSend = dict["req_dep_code"] as? String
                            let guySend = dict["req_user"] as? String
                            let time = dict["req_date"] as? String
                            let dvReceive = dict["pro_dep_code"] as? String
                            let guyReceive = dict["pro_user"] as? String
                            let date = dict["pro_assginment_date"] as? String
                            let status = dict["req_status"] as? String
                            let contentXL = dict["pro_content"] as? String
                            let record = Record()
                            record.setStt(stt: id ?? "null")
                            record.setCode(code: code ?? "null")
                            record.setTitle(title: title ?? "null")
                            record.setContent(content: content ?? "")
                            record.setDVYC(dvYC: dvSend ?? "null")
                            record.setGuyYC(guyYC: guySend ?? "null")
                            record.setDVXL(dvXL: dvReceive ?? "null")
                            record.setGuyXL(guyXL: guyReceive ?? "null")
                            record.setTimeYC(time: time ?? "null")
                            record.setDate(date: date ?? "null")
                            record.setStatus(stt: status ?? "null")
                            record.setContentXL(xl: contentXL ?? "")
                            record.setSystem(system: system ?? "")
                            records.append(record)
                        }
                    }
                }
                completion(true, nil, records)
            }
        }
    }
    
    func getNum(reqStatus: String, completion :@escaping (Bool , String) -> ()){
        let urlString = baseString + "request/num/\(reqStatus)"
        let url = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseString { (response) in
            switch response.result{
            case .failure(let error):
                completion(false, error.localizedDescription)
            case .success:
                let num = response.result.value!
                completion(true, num)
            }
        }
    }
    
    func getCauseLevel(_ level : Int, parentId: Int? = nil, completion: @escaping (Bool,[(String, String)]?,String?) -> ()) {
        let urlString = baseString + "cause/"
        var params : Parameters = [:]
        if let parentId = parentId {
            params = [
                "level" : level,
                "id_parent" : parentId
            ]
        } else {
            params = [
                "level" : level
            ]
        }
        print("Params ",params)
        let url = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding(destination: .queryString), headers: nil).responseJSON { (response) in
            switch response.result{
            case .failure(let error):
                completion(false,nil, error.localizedDescription)
            case .success:
                var items = [(String, String)]()
                
                if let recordArray = response.result.value as? NSArray {
                    
                    for record in recordArray {
                        if let dict = record as? [String: AnyObject] {
                            let causeName = dict["causeName"] as! String
                            let causeId = dict["id"] as! String
                            let dict = (causeId, causeName)
                            items.append(dict)
                        }
                    }
                    completion(true, items, nil)
                }
            }
        }
    }
    
    func getRecentFix(tickedId: String, completion: @escaping (Bool, Recent?, String?) -> ()) {
        let urlString = baseString + "request/recent/\(tickedId)"
        let url = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result{
            case .failure(let error):
                completion(false,nil, error.localizedDescription)
            case .success:
                if let dict = response.result.value as? [String : AnyObject] {
                    let fw_dep_code = dict["fw_dep_code"] as? String
                    let fw_user = dict["fw_user"] as? String
                    let fw_date = dict["fw_date"] as? String
                    let dic_cause_id = dict["dic_cause_id"] as? String
                    let content = dict["return_content"] as? String
                    let privateContent = dict["return_content_private"] as? String
                    let id = dict["id"] as! String
                    let recent = Recent()
                    recent.setDepCode(depCode: fw_dep_code ?? "")
                    recent.setUser(user: fw_user ?? "")
                    recent.setCauseId(id: dic_cause_id ?? "")
                    recent.setDate(date: fw_date ?? "")
                    recent.setContent(content ?? "")
                    recent.setPrivateContent(privateContent ?? "")
                    recent.setId(id: id)
                    completion(true, recent, nil)
                }
            }
        }
    }
    
    func fix(tickedId: String, pro_actua : String, pro_content : String, pro_user: String, pro_dep_code : String, completion: @escaping (Bool, String?) -> ()) {
        let urlString = baseString + "request/updateRequest/\(tickedId)"
        let params : Parameters = [
            "pro_actua" : pro_actua,
            "pro_content" : pro_content,
            "pro_user" : pro_user,
            "pro_dep_code" : pro_dep_code
        ]
        
        let url = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        Alamofire.request(url, method: .put, parameters: params, encoding: URLEncoding(destination: .queryString), headers: nil)
        .validate(statusCode: 200..<500)
            .responseString { (response) in
                switch response.result {
                case .failure(let error) :
                    completion(false, error.localizedDescription)
                    break
                case .success :
                    completion(true, nil)
                    break
                }
        }
    }
    
    func sendNext(id : String,receivingUser: String,receivingDepCode: String,receivingDate: String, content: String, contentPrivate: String, completion: @escaping (Bool, String?) -> ()) {
        let urlString = baseString + "request/updateRequestDetail/\(id)"
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyy"
        let actualyFinish = dateFormatter.string(from: date)
        let params : Parameters = [
            "receiving_date" : receivingDate,
            "receiving_dep_code" : receivingDepCode,
            "receiving_user" : receivingUser,
            "actualy_finish" : actualyFinish,
            "return_content" : content,
            "return_content_private" : contentPrivate
        ]
        let url = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        Alamofire.request(url, method: .put, parameters: params, encoding: URLEncoding(destination: .queryString), headers: nil)
            .validate(statusCode: 200..<500)
            .responseString { (response) in
                switch response.result {
                case .failure(let error) :
                    print(error.localizedDescription)
                    completion(false, error.localizedDescription)
                    break
                case .success :
                    completion(true, nil)
                    break
                }
        }
    }
    
    func finalSend(ticketId : String,causeID: String, content: String, contentPrivate: String, completion: @escaping (Bool, String?) -> ()) {
        let urlString = baseString + "response"
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.string(from: date)
        let params : Parameters = [
            "ticketid" : ticketId,
            "return_content" : content,
            "return_content_private" : contentPrivate,
            "dic_cause_id" : causeID,
        ]
        let url = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        Alamofire.request(url, method: .put, parameters: params, encoding: URLEncoding(destination: .queryString), headers: nil)
            .validate(statusCode: 200..<500)
            .responseString { (response) in
                switch response.result {
                case .failure(let error) :
                    completion(false, error.localizedDescription)
                    break
                case .success :
                    completion(true, nil)
                    break
                }
        }
    }
    
}
