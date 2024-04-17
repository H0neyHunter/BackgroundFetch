//
//  LocalNotification.swift
//  life_motivation_admin
//
//  Created by Ümit Örs on 2.12.2023.
//

import Foundation
import UserNotifications

class LocalNotification {
    struct notifyStruct {
        var title:String
        var body :String
        var timeInterval : Double
    }
    var notifyList = [notifyStruct]()
    
    func createNotification() {
        let notify1 = notifyStruct(title: "Merhaba", body: "Bu bir bildirim", timeInterval: 1)
        let notify2 = notifyStruct(title: "Nasılsın?", body: "Umarım iyisindir", timeInterval: 1)
        let notify3 = notifyStruct(title: "Görüşürüz", body: "Hoşçakal", timeInterval: 1)
        self.notifyList.append(notify1)
        self.notifyList.append(notify2)
        self.notifyList.append(notify3)
        let random = Int.random(in: 0..<self.notifyList.count)
        let notify = self.notifyList[random]
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                let content = UNMutableNotificationContent()
                content.title = notify.title
                content.body = notify.body
                content.sound = UNNotificationSound.default
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: notify.timeInterval, repeats: false)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                center.add(request)
            }
        }
    }
}
