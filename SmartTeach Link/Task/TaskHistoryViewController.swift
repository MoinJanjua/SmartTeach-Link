//
//  TaskHistoryViewController.swift
//  SmartTeach Link
//
//  Created by Unique Consulting Firm on 10/12/2024.
//

import UIKit

class TaskHistoryViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var addbtn: UIButton!
    
    var lecture: [Lectures] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.dataSource = self
        TableView.delegate = self
       
        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        roundCorner(button: addbtn)
        if let savedData = UserDefaults.standard.array(forKey: "task") as? [Data] {
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
        noDataLabel.text = "No History Found" // Set the message
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellH", for: indexPath) as! taskTableViewCell
        
        let rec = lecture[indexPath.item]
        cell.titlelb.text = rec.title
        cell.desclb.text = rec.other
        cell.datelb.text = rec.startdate
        cell.timeleftlb.text = "Task Completion Date : \(rec.date)"
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }

    
    @IBAction func addButton(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "TaskManagerViewController") as! TaskManagerViewController
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.modalTransitionStyle = .crossDissolve
        self.present(newViewController, animated: true, completion: nil)
    }

}
