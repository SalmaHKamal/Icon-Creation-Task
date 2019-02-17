//
//  UIColorEx.swift
//  IconCreationTask
//
//  Created by Salma Hassan on 2/16/19.
//  Copyright © 2019 Salma Hassan. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func setColor(r : CGFloat , g : CGFloat , b : CGFloat , alpha: CGFloat) -> UIColor{
        return UIColor(red : r/255, green : g/255, blue: b/255, alpha: alpha)
    }
}


