//
//  ArchieveLectureViewController.swift
//  SmartTeach Link
//
//  Created by Unique Consulting Firm on 10/12/2024.
//

import UIKit

class ArchieveLectureViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    
    var lecture: [Lectures] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.dataSource = self
        TableView.delegate = self
        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       

        if let savedData = UserDefaults.standard.array(forKey: "lectures") as? [Data] {
            let decoder = JSONDecoder()
            lecture = savedData.compactMap { data in
                do {
                    let productsData = try decoder.decode(Lectures.self, from: data)
                    return productsData
                } catch {
                    print("Error decoding product: \(error.localizedDescription)")
                    return nil
                }
            }
        }
        noDataLabel.text = "No History Found"// Set the message
        // Show or hide the table view and label based on data availability
               if lecture.isEmpty {
                   TableView.isHidden = true
                   noDataLabel.isHidden = false  // Show the label when there's no data
               } else {
                   TableView.isHidden = false
                   noDataLabel.isHidden = true   // Hide the label when data is available
               }
        print(lecture)  // Check if data is loaded
        TableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lecture.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ArrchieveTableViewCell
        
        let rec = lecture[indexPath.item]
        cell.titlelb.text = rec.title
        cell.sectionlb.text = rec.section
        cell.datelb.text = rec.date
       
        let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "dd-MM-yyyy hh:mm a" // Match the format used in `StartTiming.date`
         guard let lectureDate = dateFormatter.date(from: rec.date) else {
             cell.timeleftlb.text = "Invalid Date"
             cell.timeleftlb.textColor = .gray
             return cell
         }
         
         // Calculate the time left
         let currentDate = Date()
         let timeInterval = lectureDate.timeIntervalSince(currentDate)
         if timeInterval <= 0 {
             cell.timeleftlb.text = "Lecture Started"
             cell.timeleftlb.textColor = .gray
         } else {
             let minutesLeft = Int(timeInterval / 60)
             let hoursLeft = minutesLeft / 60
             let remainingTime = hoursLeft > 0 ? "\(hoursLeft)h \(minutesLeft % 60)m left" : "\(minutesLeft)m left"
             
             cell.timeleftlb.text = "Time Left : \(remainingTime)"
             cell.timeleftlb.textColor = minutesLeft < 60 ? .red : .black // Red for less than 1 hour
         }
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }


}
