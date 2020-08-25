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
        guard let firstName = firstNameTextField.text else{return}
        guard let lastName = lastNameTextField.text else{return}
        Birthday().saveBirthaday(of: birthdatePicker.date, firstName: firstName, lastName: lastName) { (error) -> ()? in
            setAlert(of: error.localizedDescription)
        }
        performSegue(withIdentifier: "unwindSegueWithUnwind", sender: nil)
    }

    
}
    
extension AddedViewController{
    func setAlert(of message: String){
        let alert = UIAlertController(title: "Error", message: message , preferredStyle: .alert)
        let okey = UIAlertAction(title: "Okey", style: .default, handler: nil)
        alert.addAction(okey)
        present(alert, animated: true, completion: nil)
        
    }
}
