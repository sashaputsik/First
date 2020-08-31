import Foundation
import UIKit
import UserNotifications

extension MainViewController: UNUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case "id":
            let activityController = UIActivityViewController(activityItems: [], applicationActivities: [])
            present(activityController, animated: true, completion: nil)
        default: break
            //print("dsfsdfs")
        }
    }
}
