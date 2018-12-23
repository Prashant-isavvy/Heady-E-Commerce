//
//  Window.swift
//  HeadyApp
//
//  Created by Apple on 23/12/18.
//  Copyright © 2018 HeadyApp. All rights reserved.
//

import Foundation
import UIKit

extension UIWindow {
    
    /** @return Returns the current Top Most ViewController in hierarchy.   */
    public func topMostWindowController()->UIViewController? {
        
        var topController = rootViewController
        
        while let presentedController = topController?.presentedViewController {
            topController = presentedController
        }
        
        return topController
    }
    
    /** @return Returns the topViewController in stack of topMostWindowController.    */
    public func currentViewController()->UIViewController? {
        
        var currentViewController = topMostWindowController()
        
        while currentViewController != nil && currentViewController is UINavigationController && (currentViewController as! UINavigationController).topViewController != nil {
            currentViewController = (currentViewController as! UINavigationController).topViewController
        }
        
        return currentViewController
    }
}
