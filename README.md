# SwiftNotif
An elegant way to manage posting and observing notifications in Swift.

> Runs in: Swift 4 | iOS 11.0, watchOS 4.0, tvOS 11.0, macOS High Sierra (10.13)

## Why should I use SwiftNotif?

In the NotificationCenter API, you can't post a notification when it is not observed yet, but in SwiftNotif, the notification will stay in a pending queue and will be triggered as soon as it is observed. Also, the syntax is way better and more clean than the NotificationCenter API. You never mess again with selectors and you provide blocks instead. You could even see that a notification is observed or not.

## Installation

Simply copy SwiftNotif.swift to your Xcode project. That's it!

## Usage

**Observing for a Notification**

    SwiftNotif.observe(key: "MyNotif") { context in
       //...
    }
    
**See if a Notification is Observed or not**

    print(SwiftNotif.isObserved(key: "MyNotif"))
    
**Unobserving a Notification**

    SwiftNotif.unobserve(key: "Notif1")
    
**Unobserving all Notifications**

    SwiftNotif.unobserveAllNotifications()
    
**Triggering a Notification**

> Note: If the notification is not yet observed, it will wait to be triggered as soon as it is observed.

    SwiftNotif.trigger(key: "MyNotif", context: ["username": "123"]) {
       // Runs when completed
    }
    
Or:

    SwiftNotif.trigger(key: "MyNotif")
    
    
