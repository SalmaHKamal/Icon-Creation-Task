//
//  AppDelegateEx.swift
//  IconCreationTask
//
//  Created by Salma Hassan on 2/15/19.
//  Copyright © 2019 Salma Hassan. All rights reserved.
//

import UIKit
import RealmSwift

extension AppDelegate {
    
    func styleStatusBar() {
        UIApplication.shared.statusBarView?.backgroundColor = satusBarColor
    }
    
    func styleNavigationBar() {
        UINavigationBar.appearance().barTintColor = blueThemeColor
    }
    
    func configRealm(){
        
        let schemaVer : UInt64 = 1
        let config = Realm.Configuration(
            schemaVersion: schemaVer,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < schemaVer) {
                    
                }
        })
        
        Realm.Configuration.defaultConfiguration = config
    }

}
