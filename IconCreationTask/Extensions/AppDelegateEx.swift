//
//  AppDelegateEx.swift
//  IconCreationTask
//
//  Created by Salma Hassan on 2/15/19.
//  Copyright © 2019 Salma Hassan. All rights reserved.
//

import UIKit

extension AppDelegate {
    
    func styleStatusBar() {
        UIApplication.shared.statusBarView?.backgroundColor = satusBarColor
    }
    
    func styleNavigationBar() {
        UINavigationBar.appearance().barTintColor = blueThemeColor
    }
}
