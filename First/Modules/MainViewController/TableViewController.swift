import CoreData
import UIKit

class TableViewController: UITableViewController {
    let dateFormmer = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Happy Birthday Date"
        dateFormmer.dateStyle = .full
        dateFormmer.timeStyle = .none
        tableView.reloadData()
       }
    override func viewWillAppear(_ animated: Bool) {    tableView.reloadData()
        Birthday().fetchBirthdayRequest()
        tableView.reloadData()
    }
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return birthdays.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.id, for: indexPath)
        let birthayInTable  = birthdays[indexPath.row]
        let birthday = birthayInTable.birthdayDate
        guard let firstName = birthayInTable.firstName else{return UITableViewCell()}
        guard let lastName = birthayInTable.lastName else{return UITableViewCell()}
        guard let birthdayDate = birthday else{return UITableViewCell()}
        cell.textLabel?.text = firstName + " " + lastName
        cell.detailTextLabel?.text = dateFormmer.string(from: birthdayDate)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            if birthdays.count > indexPath.row  {
                Birthday().removeBirthday(indexPath: indexPath, tableView: tableView)
            }
        }
        
    }
    
    @IBAction func unwindSegue(unwind: UIStoryboardSegue){
    }
}
   


extension UITableViewCell{
    static var id: String{
        return "cell"
    }
}

