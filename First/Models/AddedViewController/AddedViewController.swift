import CoreData
import UIKit

class AddedViewController: UIViewController {
 
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
   
    @IBOutlet weak var birthdatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTextField.delegate = self
        lastNameTextField.delegate  = self
        birthdatePicker.maximumDate = Date()
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        saveToDate()
        performSegue(withIdentifier: "unwindSegueWithUnwind", sender: nil)
    }

    
}
    
