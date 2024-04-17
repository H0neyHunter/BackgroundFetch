//
//  MyBGTaskService.swift
//  life_motivation_admin
//
//  Created by Ümit Örs on 5.12.2023.
//

import Foundation
import BackgroundTasks

class MyBGTaskService {
    let refreshBGIdentifier = "com.usyssoft.testbg.refresh"
    func BgRegister() {
        let success = BGTaskScheduler.shared.register(forTaskWithIdentifier: refreshBGIdentifier, using: nil) { task in
            self.handleAppRefreshTask(task: task as! BGAppRefreshTask)
        }
        let message = "Registered background fetch task " + (success ? "successfully" : "unsuccessfully")
        guard success else { preconditionFailure(message) }
        print(message)
    }
    
    func handleAppRefreshTask(task: BGAppRefreshTask) {
        scheduleBackground()
        BGTaskScheduler.shared.cancelAllTaskRequests()
        task.expirationHandler = {
            task.setTaskCompleted(success: false)
        }
        LocalNotification().createNotification()
        
        task.setTaskCompleted(success: true)
    }
    func scheduleBackground() {
        let fetchtask = BGAppRefreshTaskRequest(identifier: refreshBGIdentifier)
        /*
        let fetchtask = BGProcessingTaskRequest(identifier: refreshBGIdentifier)
        fetchtask.requiresExternalPower = false
        fetchtask.requiresNetworkConnectivity = true*/
        fetchtask.earliestBeginDate = Date(timeIntervalSinceNow: 10 )
        do {
          try BGTaskScheduler.shared.submit(fetchtask)
        } catch {
        }
    }
    func cancelAllTaskRequests() {
        BGTaskScheduler.shared.cancelAllTaskRequests()
    }
    /*
    func scheduleBackground() {
        let calendar = Calendar.current
        let now = Date()
        
        // Saat, dakika ve saniyeyi belirleyin
        var dateComponents = DateComponents()
        dateComponents.hour = 14 // Saati burada ayarlayabilirsiniz
        dateComponents.minute = 31 // Dakikayı burada ayarlayabilirsiniz
        dateComponents.second = 0 // Saniyeyi burada ayarlayabilirsiniz
        
        // Eğer belirlediğiniz zaman bugün geçtiyse, bir sonraki güne ayarlayın
        let notificationDate = calendar.nextDate(after: now, matching: dateComponents, matchingPolicy: .nextTime) ?? now
        
        let fetchtask = BGAppRefreshTaskRequest(identifier: refreshBGIdentifier)
        fetchtask.earliestBeginDate = notificationDate
        do {
          try BGTaskScheduler.shared.submit(fetchtask)
            
        } catch {
          print("Unable to submit task: \(error.localizedDescription)")
        }
    }*/
}
