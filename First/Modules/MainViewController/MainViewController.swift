import CoreData
import FSCalendar
import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var calendarView: FSCalendar!
    public var dateFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Birthday().fetchBirthdayRequest()
        calendarView.reloadData()
    }
       
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Happy Birthday Date"
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.select(Date())
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
}


