//
//  AddViewController.swift
//  ToDoApp
//
//  Created by 内山和輝 on 2022/06/17.
//

import UIKit
import PanModal

final class AddViewController: UIViewController {
    
    var button: UIBarButtonItem!
    var outputText: String?
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
         super.viewDidLoad()
         
        textField.delegate = self
         // Do any additional setup after loading the view.
     }

    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
        outputText = textField.text
        ToDoModel.ToDoList.append(outputText!)
        print(ToDoModel.ToDoList)
        return true
    }
}

extension AddViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    var shortFormHeight: PanModalHeight {
        return .contentHeight(400)
    }
    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(200)
    }
    var panModalBackgroundColor: UIColor {
        return UIColor.black.withAlphaComponent(0.2)
    }
    var anchorModalToLongForm: Bool {
        return false
    }
    var shouldRoundTopCorners: Bool {
        return true
    }
    var showDragIndicator: Bool {
        return false
    }
    var isUserInteractionEnabled: Bool {
        return true
    }
}
