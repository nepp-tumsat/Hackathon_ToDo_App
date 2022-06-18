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
    var outputToDoText: String?
    var outputExpText: String?
    
    @IBOutlet weak var toDoTextField: UITextField!
    @IBOutlet weak var expTextField: UITextField!
    
    override func viewDidLoad() {
         super.viewDidLoad()
        expTextField.isEnabled = false
        toDoTextField.delegate = self
        expTextField.delegate = self
         // Do any additional setup after loading the view.
     }

    override func viewWillAppear(_ animated: Bool) {
        toDoTextField.becomeFirstResponder()
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
        
        let nextTag = textField.tag + 1
        if let nextTextField = self.view.viewWithTag(nextTag) {
            self.expTextField.isEnabled = true
            nextTextField.becomeFirstResponder()
        }
        
        if nextTag == 2 {
            outputToDoText = textField.text
            ToDoModel.toDoList.append(outputToDoText!)
            
        } else if nextTag > 2 {
            
            outputExpText = textField.text
            ToDoModel.expList.append(outputExpText!)

            var expInt = Int((outputExpText)!)
            print(expInt, "😇😇😇😇😇😇😇😇😇😇😇😇😇")
            print(type(of: expInt))
            
            let url = URL(string: "http://localhost:8080/tasks")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST" // POSTリクエスト
            request.httpBody = "task=\(outputToDoText!)&userid=1&exp=\(expInt!)&due=2022-04-01".data(using: .utf8) // Bodyに情報を含める
            URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
                print("data: \(String(describing: data))")
                print("response: \(String(describing: response))")
                print("error: \(String(describing: error))")
                print("------------------------------------")
                do{
                    let responseData = try JSONSerialization.jsonObject(with: data!, options: [])
                    print("⚓️⚓️⚓️⚓️⚓️⚓️⚓️⚓️⚓️⚓️⚓️⚓️⚓️")
                    print(responseData)
                }
                catch {
                    print("🤔🤔🤔🤔🤔🤔🤔🤔🤔🤔")
                    print(error)
                }
            }).resume()
            
            self.dismiss(animated: true, completion: nil)
        }
        
        print(ToDoModel.toDoList)
        print(ToDoModel.expList)
        
        
        
        
        
        
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
