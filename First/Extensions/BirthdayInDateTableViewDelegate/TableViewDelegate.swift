import Foundation
import UIKit

//MARK: UITableViewDataSource
extension BirthdaysInDateViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return birthdaysInDate.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.id,
                                                 for: indexPath)
        guard   let firstName = birthdaysInDate[indexPath.row].firstName,
                let lastName = birthdaysInDate[indexPath.row].lastName,
            let notificationTime = birthdaysInDate[indexPath.row].notificationTime else{return UITableViewCell()}
        cell.textLabel?.text = firstName + " " + lastName
        cell.detailTextLabel?.text = dateForrmater.string(from: notificationTime)
        return cell
    }
    
    
}

//MARK: UITableViewDelegate
extension BirthdaysInDateViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            guard let lastName = birthdaysInDate[indexPath.row].lastName else{return }
            Birthday().removeBirthday(lastName: lastName,
                                      indexPath: indexPath,
                                      tableView: tableView)
            birthdaysInDate.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}

private extension UITableViewCell{
    static var id: String{
        return "cell"
    }
}
