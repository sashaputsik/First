import Foundation
import UserNotifications
import UIKit

class Birthday{
    
    func saveBirthaday(of date: Date, firstName: String, lastName: String, errorCompletionHandler: ((NSError)->()?)){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newBirthday = BirthdayCore(context: context)
        newBirthday.firstName = firstName
        newBirthday.lastName = lastName
        newBirthday.birthdayDate = date
        newBirthday.birthdayId = UUID().uuidString
        
        let massage = "Today \(firstName) \(lastName) present her HB "
        let content = UNMutableNotificationContent()
        content.body = massage
        content.sound = .default
    
        var dateComponents = Calendar.current.dateComponents([.month, .day], from: date)
        dateComponents.hour = 17
        dateComponents.minute = 00
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        if let id = newBirthday.birthdayId{
            let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
            let center = UNUserNotificationCenter.current()
            center.add(request, withCompletionHandler: nil)
        }
        
        do {
            try context.save()
        } catch let error as NSError {
            errorCompletionHandler(error)
        }
    }
}
