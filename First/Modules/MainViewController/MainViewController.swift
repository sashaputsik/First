import CoreData
import FSCalendar
import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var hieghtTableView: NSLayoutConstraint!
    @IBOutlet weak var hiddenTableViewButton: UIButton!
    fileprivate var isHiddenTableView = false
    public var dateFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Happy Birthday Date"
        tableView.delegate = self
        tableView.dataSource = self
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.select(Date())
        tableView.reloadData()
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeTableView))
        swipe.direction = isHiddenTableView ? .up : .down
        swipe.numberOfTouchesRequired = 1
        hiddenTableViewButton.addGestureRecognizer(swipe)
       }
    override func viewWillAppear(_ animated: Bool) {
        Birthday().fetchBirthdayRequest()
        tableView.reloadData()
    }
    
    @IBAction func unwindSegue(unwind: UIStoryboardSegue){
        calendarView.reloadData()  
    }
    
    @IBAction func addedBirthday(_ sender: UIBarButtonItem) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "AddedViewController") as? AddedViewController else{return}
        guard let date = calendarView.selectedDate else{return setAlert(of: "Select any date") }
        vc.date = date
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func setHiddenTableView(_ sender: UIButton) {
        isHiddenTableView = !isHiddenTableView
        hieghtTableView.constant = isHiddenTableView ? 25 : 238
    }
    
    //MARK: Handler
    @objc
    private func swipeTableView(){
        isHiddenTableView = !isHiddenTableView
        hieghtTableView.constant = isHiddenTableView ? 25 : 238
    }
    
}


