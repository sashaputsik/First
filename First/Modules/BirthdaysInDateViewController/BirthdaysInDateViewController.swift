import UIKit

class BirthdaysInDateViewController: UIViewController {

    @IBOutlet private(set) var tableView: UITableView!
    public var date = Date()
    public var birthdaysInDate = [BirthdayCore]()
    public var dateForrmater: DateFormatter{
        let dateForm = DateFormatter()
        dateForm.dateFormat = "HH:mm"
        return dateForm
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(addedBirthday))
    }
    
    @objc
    private func addedBirthday(){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "AddedViewController") as? AddedViewController else{return }
        vc.date = date
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

