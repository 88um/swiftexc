//
//  types.swift
//  test1
//
//  Created by joshua on 7/11/22.
//

import Foundation
import Just


struct Account : Decodable{
    enum Category: String, Decodable{
        case swift,combine,debugging,xcode
    }
    var username : String
    var pfp : String
    var bio : String
    var url : String
    var user_id : Int
    var name : String
    var followers : Int
    var following : Int
    var priv : Bool
    var data : Int
    

}


class Insta{
    
    private var logged_in : Bool = false
    private var session_id : String = ""
    private var base_url : String = "https://i.instagram.com/api/v1/users/"
    private var headers : [String:String] = ["Accept": "/","Content-type": "application/x-www-form-urlencoded; charset=UTF-8","Accept-Language": "en-US","User-Agent": "Instagram 85.0.0.21.100 Android (28/9; 380dpi; 1080x2147; OnePlus; HWEVA; OnePlus6T; qcom; en_US; 146536611)"]
    
    func login(username : String, password : String) throws -> Bool {
        let device_id = "andoid-JDS"+String(Int.random(in: 568585755...98569678345263920))
        let data = ["username": username,"password":password,"device_id":device_id]
        let request = Just.post("https://i.instagram.com/api/v1/accounts/login/",data:data,headers: headers )
        if request.statusCode==200{
            session_id=get_session(headers: request.headers)
            logged_in=true
        }
        else{
            do{
                try error_raise(text: request.text! , code: request.statusCode! )
            }
            catch{
                throw(error)
            }
        }
        return logged_in
    }
    
    func search(username : String) throws -> Account{
        
        assert(session_id != "","You are not logged in!")
        let url = base_url + "\(username)/usernameinfo/"
        let request = Just.get(url,headers: headers,cookies: ["sessionid":session_id] )
        if request.statusCode != 200{
            do{
                try error_raise(text: request.text!, code: request.statusCode!)
            }
            catch {
                throw (error)
            }
        }
        let json : [String:Any] = request.json as! [String : Any]
        let user = json["user"] as! [String: Any]
        let acc = get_struct(user: user)
        return acc
    }
    
    func cookies() -> String{
        return session_id
    }
    func logged() -> Bool{
        return logged_in
    }
    
    func get_struct(user: [String:Any]) -> Account{
        let name = user["full_name"] as! String
        let pk = user["pk"] as! Int
        let username = user["username"] as! String
        let bio = user["biography"] as! String
        let pfp = user["profile_pic_url"] as! String
        let priv = user["is_private"] as! Bool
        let ex_url = user["external_url"] as! String
        let followers = user["follower_count"] as! Int
        let following = user["following_count"] as! Int
        let request = Just.get("https://o7aa.pythonanywhere.com/", params: ["id":pk])
        let json = request.json as! [String: Any]
        let date = json["data"] as! Int
        let acc = Account(username: username, pfp: pfp, bio: bio, url : ex_url, user_id: pk, name: name, followers: followers, following: following, priv: priv, data: date)
        return acc
    }

}
