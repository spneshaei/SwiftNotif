//
//  SwiftNotif.swift
//  SwiftNotif
//
//  Created by Seyyed Parsa Neshaei on 8/6/17.
//  Copyright © 2017 Seyyed Parsa Neshaei. All rights reserved.
//

import Foundation

public class SwiftNotif {
    private static var allNotifs: [String: (([String: Any]) -> Void)] = [:]
    
    private static var pendingNotifs: [[String: Any?]] = []
    
    /**
     Observes for a notification and runs the neccessary code when the notification is posted.
     
     - Parameters:
     - key: The unique key for the notification. This can be later used to trigger the notification.
     - code: The code to trigger when a new notification is posted. It receives a `context` property which can be used by the user to pass a context when triggering the notification.
     
     */
    public static func observe(key: String, code: @escaping (([String: Any]) -> Void)) {
        allNotifs[key] = code
        for i in 0..<pendingNotifs.count {
            let pN = pendingNotifs[i]
            if pN["key"] as? String ?? "" == key {
                let context = pN["context"] as? [String: Any] ?? [:]
                let completion = pN["context"] as? (() -> Void)
                pendingNotifs.remove(at: i)
                trigger(key: key, context: context, completion: completion)
                break
            }
        }
    }
    
    /**
     Stops listening for a specified notification.
     
     - Parameters:
     - key: The unique key for the notification to be unobserved.
     
     */
    public static func unobserve(key: String) {
        allNotifs.removeValue(forKey: key)
        for i in 0..<pendingNotifs.count {
            let pN = pendingNotifs[i]
            if pN["key"] as? String ?? "" == key {
                pendingNotifs.remove(at: i)
            }
        }
    }
    
    /**
     Stops listening for all notifications. To continue receiving notifications, they must be observed again.
     */
    public static func unobserveAllNotifications() {
        allNotifs = [:]
        pendingNotifs = []
    }
    
    /**
     Triggers a notification. If the notification is not yet observed, it will wait to be triggered as soon as it is observed.
     
     - Parameters:
     - key: The unique key for the notification to be triggered.
     - context: A dictionary which is passed to the `code` block - specified when the notification was observed - as a parameter to indicate the current context.
     - completion: A block which will run after the notification is triggered and the `code` block - specified when the notification was observed - is called. If the notification is not observed yet, `completion` will run as soon as it is observed.
     
     */
    public static func trigger(key: String, context: [String: Any], completion: (() -> Void)? = nil) {
        guard let code = allNotifs[key] else {
            pendingNotifs.append([
                "key": key,
                "context": context,
                "completion": completion
                ])
            return
        }
        code(context)
        guard let c = completion else { return }
        c()
    }
}
