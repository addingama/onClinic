//
//  SessionManager.swift
//  onClinic
//
//  Created by MTMAC24 on 3/9/17.
//  Copyright © 2017 MTMAC24. All rights reserved.
//

import Foundation

class SessionManager {
    let defaults = UserDefaults.standard
    
    func setLoginStatus(status: Bool) {
        defaults.set(status, forKey: SessionKey.isLoggedIn)
    }
    
    func isLoggedIn() -> Bool {
        return defaults.bool(forKey: SessionKey.isLoggedIn)
    }
    
    func setUserId(id: Int) {
        defaults.set(id, forKey: SessionKey.userId)
    }
    
    func getUserId() -> Int {
        return defaults.integer(forKey: SessionKey.userId)
    }
    
    func setUserName(name: String) {
        defaults.set(name, forKey: SessionKey.userName)
    }
    
    func getUserName() -> String {
        return defaults.object(forKey: SessionKey.userName) as! String
    }
    
    func setUserRole(role: String) {
        defaults.object(forKey: SessionKey.userRole)
    }
    
    func getUserRole() -> String {
        return defaults.object(forKey: SessionKey.userRole) as! String
    }
    
    func setAuthToken(token: String) {
        defaults.set(token, forKey: SessionKey.userToken)
    }
    
    func getAuthToken() -> String {
        return defaults.object(forKey: SessionKey.userToken) as! String
    }
    
    
    
    func logout() {
        for key in defaults.dictionaryRepresentation().keys {
            defaults.removeObject(forKey: key.description)
        }
    }
    
    func setUser(user: [String: Any]) {
        defaults.set(user, forKey: SessionKey.user)
    }
    
    func getUser() -> User {
        let user = defaults.object(forKey: SessionKey.user) as! [String: Any]
        let id = user["id"] as! Int
        let name = user["name"] as! String
        let role = user["role"] as! String
        let token = user["token"] as! String
        print(name)
        print(role)
        let data = User.init(id: id, name: name, role: role, token: token)
        return data
    }
}
