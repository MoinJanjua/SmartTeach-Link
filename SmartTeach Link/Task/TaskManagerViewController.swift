//
//  TaskManagerViewController.swift
//  SmartTeach Link
//
//  Created by Unique Consulting Firm on 10/12/2024.
//

import UIKit

class TaskManagerViewController: UIViewController {

    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var desctf: UITextView!
    @IBOutlet weak var notifySwitcch: UISwitch!
    @IBOutlet weak var StartTiming: UIDatePicker!
    
    
    var lecture = [Lectures]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notifySwitcch.isOn = true
        // Do any additional setup after loading the view.
    }
    
    
     func saveData()
    {
        guard let title = titleTF.text, !title.isEmpty
              
        else {
            showAlert(title: "Error", message: "Please fill in all fields.")
            return
        }
        
        
        let date = StartTiming.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm a" // Customize format as needed
        let strdate = dateFormatter.string(from: date)
        let currentdate = dateFormatter.string(from: Date())
        let id = generateCustomerId()
        
        let rec = Lectures(
            id: "\(id)",
            title: title,
            section: "",
            date: strdate,
            startdate: currentdate,
            other: desctf.text
        )
        
        saveCreateSaleDetail(rec)
        if notifySwitcch.isOn {
                scheduleNotification(for: title, at: date)
            }
        
    }
    
    func saveCreateSaleDetail(_ order: Lectures) {
        var orders = UserDefaults.standard.object(forKey: "task") as? [Data] ?? []
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(order)
            orders.append(data)
            UserDefaults.standard.set(orders, forKey: "task")
            clearTextFields()
           
        } catch {
            print("Error encoding medication: \(error.localizedDescription)")
        }
        showAlert(title: "Success", message: "The task has been successfully saved.")
        

    }

    
    func scheduleNotification(for title: String, at date: Date) {
        let notificationCenter = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Upcoming Assignment"
        content.body = "Your task titled '\(title)' is scheduled in 10 minutes."
        content.sound = .default
        
        // Calculate the trigger date (10 minutes before the lecture)
        let triggerDate = date.addingTimeInterval(-10 * 60) // 10 minutes earlier
        let triggerComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: triggerDate)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerComponents, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // Add the notification request
        notificationCenter.add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully!")
            }
        }
    }


    func clearTextFields() {
        titleTF.text = ""
        desctf.text = ""
    }
    
    @IBAction func SaveButton(_ sender: Any) {
        saveData()
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }


}
