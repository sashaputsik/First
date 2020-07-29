import CoreData
import UIKit

class TableViewController: UITableViewController {
    let dateFormmer = DateFormatter()
    var birthdays = [BirthdayCore]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Happy Birthday Date"
        dateFormmer.dateStyle = .full
        dateFormmer.timeStyle = .none
        tableView.reloadData()
       }
    override func viewWillAppear(_ animated: Bool) {    tableView.reloadData()
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
        tableView.reloadData()
    }
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return birthdays.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let birthayInTable  = birthdays[indexPath.row]
        guard let firstName = birthayInTable.firstName else{return UITableViewCell()}
        guard let lastName = birthayInTable.lastName else{return UITableViewCell()}
        let birthday = birthayInTable.birthdayDate
        cell.textLabel?.text = firstName + " " + lastName
        if let birthdaydate = birthday {
            cell.detailTextLabel?.text = dateFormmer.string(from: birthdaydate)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
        if birthdays.count > indexPath.row  {
            let birthday = birthdays[indexPath.row]
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            context.delete(birthday)
            birthdays.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            if let id = birthday.birthdayId{
                let center = UNUserNotificationCenter.current()
                center.removePendingNotificationRequests(withIdentifiers: [id])
            }
            do {
                try context.save()
            } catch let error as NSError {
                print(error)
            }
        }
        }
        
    }
    
    @IBAction func unwindSegue(unwind: UIStoryboardSegue){
    }
  
    }
   


