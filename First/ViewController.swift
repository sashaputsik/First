
import UIKit
import CoreData


class ViewController: UIViewController {
 
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
   
    @IBOutlet weak var birthdatePicker: UIDatePicker!
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        print("save")
        let birthdate = birthdatePicker.date
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let massage = "Today \(firstName) \(lastName) present her HB "
        let contextUserN = UNMutableNotificationContent()
        let newBirthday = BirthdayCore(context: context)
        
        newBirthday.firstName = firstName
        newBirthday.lastName = lastName
        newBirthday.birthdayDate = birthdate
        newBirthday.birthdayId = UUID().uuidString
        
        contextUserN.body = massage
        contextUserN.sound = .default
        
        var dateComponents = Calendar.current.dateComponents([.month, .day], from: birthdate)
        dateComponents.hour = 17
        dateComponents.minute = 26
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        if let id = newBirthday.birthdayId{
            let request = UNNotificationRequest(identifier: id, content: contextUserN, trigger: trigger)
            let center = UNUserNotificationCenter.current()
            center.add(request, withCompletionHandler: nil)
        }
        do {
            try context.save()
        } catch let error as NSError {
            print(error)
        }
        let views = TableViewController()
        views.tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
         dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTextField.delegate = self
        lastNameTextField.delegate  = self
        birthdatePicker.maximumDate = Date()
    }
}

extension ViewController: UISearchTextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
