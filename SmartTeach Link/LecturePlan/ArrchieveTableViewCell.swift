//
//  ArrchieveTableViewCell.swift
//  SmartTeach Link
//
//  Created by Unique Consulting Firm on 10/12/2024.
//

import UIKit

class ArrchieveTableViewCell: UITableViewCell {

    @IBOutlet weak var titlelb: UILabel!
    @IBOutlet weak var sectionlb: UILabel!
    @IBOutlet weak var datelb: UILabel!
    @IBOutlet weak var timeleftlb: UILabel!
    @IBOutlet weak var bgview: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgview.layer.cornerRadius = 18
       // Set up shadow properties
        bgview.layer.shadowColor = UIColor.white.cgColor
        bgview.layer.shadowOffset = CGSize(width: 0, height: 2)
        bgview.layer.shadowOpacity = 0.3
        bgview.layer.shadowRadius = 4.0
        bgview.layer.masksToBounds = false
       // Set background opacity
        bgview.alpha = 1.5 // Adjust opacity as needed
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
