import Foundation
import UIKit

extension UITableViewCell{
    static var id: String{
        return "cell"
    }
}

//MARK: UITableViewDataSource
extension MainViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return birthdays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.id, for: indexPath)
        let birthayInTable  = birthdays[indexPath.row]
        let birthday = birthayInTable.birthdayDate
        guard let firstName = birthayInTable.firstName else{return UITableViewCell()}
        guard let lastName = birthayInTable.lastName else{return UITableViewCell()}
        guard let birthdayDate = birthday else{return UITableViewCell()}
        cell.textLabel?.text = firstName + " " + lastName
        cell.detailTextLabel?.text = dateFormatter.string(from: birthdayDate)
        
        return cell
    }
}

//MARK: UITableViewDelegate
extension MainViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            if birthdays.count > indexPath.row  {
                Birthday().removeBirthday(indexPath: indexPath, tableView: tableView)
                calendarView.reloadData()
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

