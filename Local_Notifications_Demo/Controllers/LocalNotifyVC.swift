//
//  LocalNotifyVC.swift
//  Local_Notifications_Demo
//
//  Created by Bhumita Panara on 15/05/23.
//

import UIKit
import UserNotifications

class LocalNotifyVC: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var lblError: UILabel!
    
    //MARK: - VARIABLES
    let center = UNUserNotificationCenter.current()
    
    //MARK: - UI VIEW CONTROLLER LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //MARK: - OTHER METHODS
    
    func getAccessRequest(){
        // Step - 1: Ask for permission
        center.requestAuthorization(options: [.alert, .sound]) { grantedPermission, error in
            
            
            //Step - 2: Handle if user denies
            if !grantedPermission{
                DispatchQueue.main.async {
                    self.lblError.isHidden = false
                    self.lblError.text = "You have to allow notification permission in order to test them."
                }
            }else{
                self.sendNotification()
                DispatchQueue.main.async {
                    self.lblError.isHidden = true
                }
            }
        }
    }
    
    func sendNotification(){
        
        //Step - 3: Create the Notification Content
        let content = UNMutableNotificationContent()
        content.title = "Hello, there!"
        content.body = "Working with local notifications"
        
        //Step - 4: Notification Trigger
        let date = Date().addingTimeInterval(15)
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute,.second], from: date)
        
//        dateComponents.weekday = 3
//        dateComponents.hour = 11
//        dateComponents.minute = 19
        
        let triggerData = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // Step - 5: Requesting with given data
        let uuidString = UUID().uuidString
        let req = UNNotificationRequest(identifier: uuidString, content: content, trigger: triggerData)
        
        //Step - 6: Register the request
        center.add(req) { error in
            if error != nil{
                self.lblError.isHidden = false
                self.lblError.text = "\(error)"
            }
        }
    }
    
    @IBAction func onClickBtnSend(_ sender: UIButton) {
        getAccessRequest()
    }
    
}

