//
//  HomeViewController.swift
//  ToDoApp
//
//  Created by 内山和輝 on 2022/06/16.
//

import UIKit
import PanModal

final class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, URLSessionDelegate, URLSessionDataDelegate {

//    let ToDoList = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K"]

    @IBOutlet weak var addButton: UIButton! {
        didSet {
            self.addButton.layer.cornerRadius = 25
        }
    }
    @IBOutlet weak var progressBar: UIProgressView! {
        didSet {
            progressBar.transform = CGAffineTransform(scaleX: 1.0, y: 8.0)
        }
    }
    
    
    @IBOutlet private weak var toDoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoTableView.register(ToDoTableViewCell.nib, forCellReuseIdentifier: ToDoTableViewCell.identifier)
        
        toDoTableView.delegate = self
        toDoTableView.dataSource = self
        
        let url = URL(string: "http://localhost:8080/users/1/tasks")!  //URLを生成
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data , response, error in
           if let error = error {
               print(error.localizedDescription)
               print("通信が失敗しました")
               return
           }
           
           guard let data = data,
                 let response = response as? HTTPURLResponse else {
               print("データもしくはレスポンスがnilの状態です")
               return
           }
           
           if response.statusCode == 200 {
               // パターン1
               // 結果：通信結果のJSONをStringで得る。  -> { "id": 1, "name": "GOOD" }
               print("😍😍😍😍😍😍😍😍😍😍😍😍")
               print(String(data: data, encoding: .utf8)!)
               
           } else {
               print("statusCode:\(response.statusCode)")
           }
        }).resume()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        toDoTableView.reloadData()
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        presentPanModal(AddViewController())
    }
    
    @objc func click() {
        let edit = AddViewController()
        navigationController?.pushViewController(edit, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToDoModel.toDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.identifier, for: indexPath) as! ToDoTableViewCell
        cell.taskLabel?.text = ToDoModel.toDoList[indexPath.row]
        cell.expLabel?.text = "\(ToDoModel.expList[indexPath.row])exp"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ToDoModel.toDoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.identifier, for: indexPath) as! ToDoTableViewCell
        cell.deleteLine.alpha = 1
        cell.taskLabel?.text = ToDoModel.toDoList[indexPath.row]
        cell.expLabel?.text = "\(ToDoModel.expList[indexPath.row])exp"
//        cell.selectionStyle = .none
        print("\(indexPath.row)番目の行が選択されました。")
        
        
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
