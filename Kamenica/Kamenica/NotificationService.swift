// https://medium.com/ivymobility-developers/push-notifications-in-ios-swift-5-2-11415817b189

import UserNotifications
import UIKit

class NotificationService: NSObject, UNUserNotificationCenterDelegate {
  
  private override init() { }
  static let sharedInstance = NotificationService()
  
  let center = UNUserNotificationCenter.current()
  
  func authorizeNotification() {
    let options: UNAuthorizationOptions = [.alert, .badge, .sound]
    center.requestAuthorization(options: options) { (granted, error) in
      guard granted else {
        print("User Denied the permission to receive Push")
        return
      }
      self.center.delegate = self
    }
  }
  
  func requestTimerNotification(_ busListItem: BusListItem) {
    let content = UNMutableNotificationContent()
    content.title = "Autobus \(busListItem.line)"
    content.body = "Podsetnik da autobus \(busListItem.line) kreće za 15 minuta"
    content.categoryIdentifier = "alarm"
    content.sound = UNNotificationSound.default
    
//    let alarmDate = Calendar.current.date(byAdding: .minute, value: -15, to: busListItem.date)!
    let today = Date()
    let alarmDate = Calendar.current.date(byAdding: .minute, value: 1, to: today)!
    var dateComponents = DateComponents()
    dateComponents.hour = Calendar.current.component(.hour, from: alarmDate)
    dateComponents.minute = Calendar.current.component(.minute, from: alarmDate)
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
    let request = UNNotificationRequest(identifier: busListItem.id.uuidString, content: content, trigger: trigger)
    self.center.add(request)
  }
  
  func registerCategories() {
    let show = UNNotificationAction(identifier: "show", title: "Još detalja…", options: .foreground)
    let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [])
    center.setNotificationCategories([category])
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    switch response.actionIdentifier {
      case UNNotificationDefaultActionIdentifier:
        // the user swiped to unlock
        print("Default identifier")
      case "show":
        // the user tapped our "show more info…" button
        print("Show more information…")
        break
      default:
        break
    }
    completionHandler()
  }
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    NotificationCenter.default.post(name: NSNotification.Name.init("alarmoff"), object: nil, userInfo: ["itemUuid": notification.request.identifier])
    removePendingNotifications(uuid: notification.request.identifier)
    let options: UNNotificationPresentationOptions = [.badge, .banner, .sound]
    completionHandler(options)
  }

  func removePendingNotifications(_ busListItem: BusListItem) {
    removePendingNotifications(uuid: busListItem.id.uuidString)
  }
  
  func removePendingNotifications(uuid: String) {
    center.getPendingNotificationRequests(completionHandler: { [unowned self] requests in
      let pendingTimerRequests = requests.filter { return $0.identifier == uuid }.map{ $0.identifier }
      center.removePendingNotificationRequests(withIdentifiers: pendingTimerRequests)
    })
  }
  
  func removeAllPendingNotifications() {
    center.removeAllPendingNotificationRequests()
  }
}
