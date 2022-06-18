//
//  ToDoTableViewCell.swift
//  ToDoApp
//
//  Created by 内山和輝 on 2022/06/17.
//

import UIKit

final class ToDoTableViewCell: UITableViewCell {
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var expLabel: UILabel!
    @IBOutlet weak var deleteLine: UIView! {
        didSet {
            deleteLine.alpha = 0
        }
    }
    
    @IBOutlet weak var toDoCircle: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
