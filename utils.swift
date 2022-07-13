//
//  utils.swift
//  test1
//
//  Created by joshua on 7/12/22.
//

import Foundation
import Just

func input(arg : String) -> String{
    print(arg,terminator: "")
    let result = readLine() ?? ""
    return result
}

func iinput(arg : Int) -> Int{
    print(arg,terminator: "")
    let result = readLine() ?? "0"
    let new_result = Int(result) ?? 0
    return new_result
}

func error_raise(text : String, code: Int) throws {
    if code == 404{
        throw TestBot.UserNotFound("Request return 404; User not found")}
    else if code==403 || text.contains("login_required"){
        throw TestBot.NotLoggedIn("You are not logged in!")
    }
    else if text.contains("ip_block") || code == 429{
        throw TestBot.NotLoggedIn("You are rate limited")
    }
    else if text.contains("api_path"){
        throw TestBot.ChallengeBlock("Suspicious Login")
    }
    else if text.contains("challenge_required"){
        throw TestBot.ChallengeBlock("Youve been challenge blocked")
    }
    else if text.contains("invalid_user") || text.contains("Invalid Parameters"){
        throw TestBot.InvalidCredentials("Invalid username")
    }
    else if text.contains("bad_password"){
        throw TestBot.InvalidCredentials("Invalid password")
    }
    else{throw TestBot.BadRequest("Bad request: "+text)}
}

func get_session(headers : CaseInsensitiveDictionary<String, String>) -> String{
    let cookie = String(headers["Set-Cookie"] ?? "")
    let session = cookie.components(separatedBy: "sessionid=")[1].components(separatedBy: ";")[0]
    return session

}

func clear(){
    print("", terminator: Array(repeating: "\n", count: 100).joined()) // only for xcode terminal
    sleep(1)
}
