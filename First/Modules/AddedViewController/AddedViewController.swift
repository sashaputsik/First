import CoreData
import UIKit

class AddedViewController: UIViewController {
 
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    var date = Date()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate  = self
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        guard let firstName = firstNameTextField.text else{return}
        guard let lastName = lastNameTextField.text else{return}
        Birthday().saveBirthaday(of: date, firstName: firstName, lastName: lastName) { (error) -> ()? in
            setAlert(of: error.localizedDescription)
        }
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" && lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""{
        performSegue(withIdentifier: "unwindSegueWithUnwind", sender: nil)
        } else{
            setAlert(of: "Empty Fields")
        }
    }

    
}
    
extension UIViewController{
    func setAlert(of message: String){
        let alert = UIAlertController(title: "Error", message: message , preferredStyle: .alert)
        let okey = UIAlertAction(title: "Okey", style: .default, handler: nil)
        alert.addAction(okey)
        present(alert, animated: true, completion: nil)
        
    }
}

