import Foundation
import UIKit

//MARK: UITableViewDataSource
extension BirthdaysInDateViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return birthdaysInDate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.id, for: indexPath)
        guard   let firstName = birthdaysInDate[indexPath.row].firstName,
                let lastName = birthdaysInDate[indexPath.row].lastName else{return UITableViewCell()}
        cell.textLabel?.text = firstName + " " + lastName
        return cell
    }
    
    
}

//MARK: UITableViewDelegate
extension BirthdaysInDateViewController: UITableViewDelegate{
    
}

extension UITableViewCell{
    static var id: String{
        return "cell"
    }
}
