
import UIKit
import CoreData
class TableViewController: UITableViewController {

    @IBAction func edit(_ sender: UIBarButtonItem) {
        tableView.isEditing = !tableView.isEditing
        
    }
    
        let dateFormmer = DateFormatter()
        var birthdays = [BirthdayCore]()
        var refresher: UIRefreshControl!
    
    @objc func refresh(){
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
        self.refresher.endRefreshing()
        print("refresh")

    }
        override func viewDidLoad() {
            super.viewDidLoad()
            refresher = UIRefreshControl()
            refresher.tintColor = .lightGray
            refresher.addTarget(self, action: #selector(TableViewController.refresh), for: .valueChanged)
            tableView.addSubview(refresher)
             
            dateFormmer.dateStyle = .full
            dateFormmer.timeStyle = .none
            tableView.reloadData()
        }
    override func viewWillAppear(_ animated: Bool) {
       
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
            let firstName = birthayInTable.firstName ?? ""
            let lastName = birthayInTable.lastName ?? ""
            let birthday = birthayInTable.birthdayDate
            cell.textLabel?.text = firstName + " " + lastName
            
            if let birthdaydate = birthday as Date? {
                
                cell.detailTextLabel?.text = dateFormmer.string(from: birthdaydate)
            }else{
                cell.detailTextLabel?.text = ""
            }

            return cell
        }
       
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
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
  
    
    
    }
   


