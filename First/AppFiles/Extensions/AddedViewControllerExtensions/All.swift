import CoreData
import Foundation
import NotificationCenter

extension AddedViewController{
    func saveToDate(){
        let birthdate = birthdatePicker.date
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newBirthday = BirthdayCore(context: context)
        newBirthday.firstName = firstName
        newBirthday.lastName = lastName
        newBirthday.birthdayDate = birthdate
        newBirthday.birthdayId = UUID().uuidString
        
        let massage = "Today \(firstName) \(lastName) present her HB "
        let content = UNMutableNotificationContent()
        content.body = massage
        content.sound = .default
    
        var dateComponents = Calendar.current.dateComponents([.month, .day], from: birthdate)
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
            let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .actionSheet)
            let okeyAction = UIAlertAction(title: "Okey", style: .default, handler: nil)
            alertController.addAction(okeyAction)
            present(alertController, animated: true, completion: nil)
        }
    }
}
