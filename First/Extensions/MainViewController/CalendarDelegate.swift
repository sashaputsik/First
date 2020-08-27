import Foundation
import FSCalendar

extension MainViewController: FSCalendarDelegate, FSCalendarDataSource{
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        for birthday in birthdays{
            guard let birthdayDate = birthday.birthdayDate else{return 0}
            if dateFormatter.string(from: birthdayDate) == dateFormatter.string(from: date){
                return 1
            }
        }
        return 0
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        calendar.reloadData()
    }
}
