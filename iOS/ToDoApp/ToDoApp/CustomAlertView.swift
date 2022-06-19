//
//  CutomAlertView.swift
//  ToDoApp
//
//  Created by 内山和輝 on 2022/06/19.
//

import UIKit

class CustomAlertView: UIView {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        loadNib()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func loadNib(){
        guard let view =  UINib(nibName: "CustomAlertView", bundle: nil).instantiate(withOwner: self, options: nil).first as? CustomAlertView else {
            return
        }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
