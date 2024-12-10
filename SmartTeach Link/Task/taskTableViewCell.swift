//
//  taskTableViewCell.swift
//  SmartTeach Link
//
//  Created by Unique Consulting Firm on 10/12/2024.
//

import UIKit

class taskTableViewCell: UITableViewCell {

    @IBOutlet weak var titlelb: UILabel!
    @IBOutlet weak var desclb: UILabel!
    @IBOutlet weak var datelb: UILabel!
    @IBOutlet weak var timeleftlb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
