//
//  StorageSingleton.swift
//  SocialNet
//
//  Created by Екатерина Алексеева on 30.05.2023.
//

import UIKit

class StorageSingleton: NSObject {
    static let share = StorageSingleton()
    let allGroupsArray: [String] = ["tigers", "cats", "goats"]
    var myGroupsArray: [String] = []
    
    private override init() {
        super.init()
    }
}
