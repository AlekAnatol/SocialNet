//
//  StorageSingleton.swift
//  SocialNet
//
//  Created by Екатерина Алексеева on 30.05.2023.
//

import UIKit

class StorageSingleton: NSObject {
    static let share = StorageSingleton()
    
    var allGroupsArray: [Group] = []
    var myGroupsArray: [Group] = []
    var myFriendsArray: [Friend] = []
    var myFriendsSource: [Friend] = []
    
    private override init() {
        super.init()
    }
    
    func addGroupToMyGroups(group: Group) {
        var allGroupsNames = [String]()
        myGroupsArray.forEach { group in
            allGroupsNames.append(group.name)
        }
        if !allGroupsNames.contains(group.name) {
            myGroupsArray.append(group)
        }
    }
}
