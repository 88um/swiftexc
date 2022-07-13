//
//  errors.swift
//  test1
//
//  Created by joshua on 7/11/22.
//

import Foundation

enum TestBot : Error{
    case UserNotFound(String)
    case NotLoggedIn(String)
    case RateLimited(String)
    case ChallengeBlock(String)
    case InvalidCredentials(String)
    case BadRequest(String)
}
