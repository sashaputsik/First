import Foundation
import CoreData
import UserNotifications
import UIKit


var birthdays = [BirthdayCore]()

class Birthday{
    //MARK: Добавление в Базу Данных
    func saveBirthaday(of date: Date, notificationTime: Date, firstName: String, lastName: String, errorCompletionHandler: ((NSError)->()?)){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newBirthday = BirthdayCore(context: context)
        newBirthday.firstName = firstName
        newBirthday.lastName = lastName
        newBirthday.birthdayDate = date
        newBirthday.birthdayId = UUID().uuidString
        newBirthday.notificationTime = notificationTime
        
        let massage = "Today \(firstName) \(lastName) present her HB "
        let content = UNMutableNotificationContent()
        content.body = massage
        content.sound = .default
        let timeComponents = Calendar.current.dateComponents([.hour, .minute], from: notificationTime)
        var dateComponents = Calendar.current.dateComponents([.month, .day], from: date)
        dateComponents.hour = timeComponents.hour
        dateComponents.minute = timeComponents.minute
        let shareAction = UNNotificationAction(identifier: "id", title: "Share", options: .foreground)
        let category = UNNotificationCategory(identifier: "idC", actions: [shareAction], intentIdentifiers: [], options: [])
        content.categoryIdentifier = "idC"
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        if let id = newBirthday.birthdayId{
            let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
            let center = UNUserNotificationCenter.current()
            center.add(request, withCompletionHandler: nil)
            center.setNotificationCategories([category])
        }
        
        do {
            try context.save()
        } catch let error as NSError {
            errorCompletionHandler(error)
        }
    }
    
    //MARK: Удаление из базы данных
    func removeBirthday(lastName: String, indexPath: IndexPath, tableView: UITableView){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        var i = -1
        for birthday in birthdays{
            i += 1
            if lastName == birthday.lastName {
                context.delete(birthday)
                birthdays.remove(at: i)
                
                if let id = birthday.birthdayId{
                    let center = UNUserNotificationCenter.current()
                    center.removePendingNotificationRequests(withIdentifiers: [id])
                }
            }
        }
        do {
            try context.save()
            
        } catch let error as NSError {
            print(error)
        }
    }
    
    //MARK: Получение данных из базы данных
    func fetchBirthdayRequest(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let sort = NSSortDescriptor(key: "birthdayDate", ascending: true)
        let fetch = BirthdayCore.fetchRequest() as NSFetchRequest<BirthdayCore>
        fetch.sortDescriptors = [sort]
        
        do {
            birthdays = try context.fetch(fetch)
        } catch let error as NSError {
            print(error)
        }
    }
}
