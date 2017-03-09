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
    
    func setAuthToken(token: String) {
        defaults.set(token, forKey: SessionKey.token)
    }
    
    func getAuthToken() -> String {
        return defaults.object(forKey: SessionKey.token) as! String
    }
    
    
    func logout() {
        for key in defaults.dictionaryRepresentation().keys {
            defaults.removeObject(forKey: key.description)
        }
    }
    

}
