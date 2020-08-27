import CoreData
import UIKit
import FSCalendar

class CalendarViewController: UIViewController {

    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.appearance.eventOffset = CGPoint(x: 1, y: 1)
        calendarView.appearance.eventSelectionColor = .black
        calendarView.swipeToChooseGesture.isEnabled = true
    }

}

extension CalendarViewController: FSCalendarDelegate{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date)
        for birthday in birthdays{
            if dateFormatter.string(from: birthday.birthdayDate!) == dateFormatter.string(from: date){
                guard let firstName = birthday.firstName, let lastName = birthday.lastName else{return}
                nameLabel.text = firstName + " " + lastName
                dateLabel.text = dateFormatter.string(from: date)
            }
//            else{
//                nameLabel.textColor = .lightGray
//                dateLabel.text = ""
//                nameLabel.text = "Событий нет"
//            }
        }
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        for birthday in birthdays{
            if dateFormatter.string(from: birthday.birthdayDate!) == dateFormatter.string(from: date){
                return 1
            }
        }
        return 0
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        calendar.reloadData()
    }
}

extension CalendarViewController: FSCalendarDataSource{
    
}
