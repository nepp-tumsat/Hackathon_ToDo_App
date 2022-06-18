//
//  HomeViewController.swift
//  ToDoApp
//
//  Created by 内山和輝 on 2022/06/16.
//

import UIKit
import PanModal

final class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, URLSessionDelegate, URLSessionDataDelegate {

    var toDoList: [TaskData] = []
    
    var expSum = 0
    var lv = 6
    
    @IBOutlet weak var addButton: UIButton! {
        didSet {
            self.addButton.layer.cornerRadius = 25
        }
    }
    
    @IBOutlet weak var progressBar: UIProgressView! {
        didSet {
            progressBar.transform = CGAffineTransform(scaleX: 1.0, y: 4.0)
            progressBar.progress = 0
        }
    }
    
    @IBOutlet weak var statusView: UIView! {
        didSet {
            statusView.layer.cornerRadius = 25
        }
    }
    
    
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.text = "うっちー"
        }
    }
    
    @IBOutlet weak var lvLabel: UILabel! {
        didSet {
            lvLabel.text = "Lv.\(lv)"
        }
    }
    
    @IBOutlet private weak var toDoTableView: UITableView!
    
    @IBOutlet weak var iconImageView: UIImageView! {
        didSet {
            iconImageView.layer.cornerRadius = 35.5
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoTableView.register(ToDoTableViewCell.nib, forCellReuseIdentifier: ToDoTableViewCell.identifier)
        
        toDoTableView.delegate = self
        toDoTableView.dataSource = self
        
        APIClient.getToDoListAPI(completion: { result in
            switch result {
            case .success(let toDoResponse):
                self.toDoList = toDoResponse
                
                DispatchQueue.main.async {
                    self.toDoTableView.reloadData()
                }
                
//                print(toDoResponse[0].task)
                print("😂😂😂😂😂😂😂😂")
                print("😄😄😄😄😄😄😄😄😄", toDoResponse)
                
            case .failure(let error):
                print("😍😍😍😍😍😍😍😍😍")
                print(error)
            }
        })
        
        print(toDoList)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Thread.sleep(forTimeInterval: 0.1)
       
        APIClient.getToDoListAPI(completion: { result in
            switch result {
            case .success(let toDoResponse):
                self.toDoList = toDoResponse
                print("😅😅😅😅😅😅😅😅😅😅😅😅😅😅😅😅")
                print(self.toDoList)
                print("😅😅😅😅😅😅😅😅😅😅😅😅😅😅😅😅")
                DispatchQueue.main.async {
                    self.toDoTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        })

    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        presentPanModal(AddViewController())
    }
    
    @objc func click() {
        let edit = AddViewController()
        navigationController?.pushViewController(edit, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return ToDoModel.toDoList.count
//        return ToDoModelSample.toDoList.count
        
        return toDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.identifier, for: indexPath) as! ToDoTableViewCell
//        cell.taskLabel?.text = ToDoModel.toDoList[indexPath.row]
//        cell.expLabel?.text = "\(ToDoModel.expList[indexPath.row])exp"
//        cell.taskLabel?.text = ToDoModelSample.toDoList[indexPath.row]
//        cell.expLabel?.text = "\(ToDoModelSample.expList[indexPath.row])exp"
        
        cell.taskLabel?.text = toDoList[indexPath.row].task
        cell.expLabel?.text = "\(toDoList[indexPath.row].exp)exp"
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
        cell.taskLabel?.text = toDoList[indexPath.row].task
        cell.expLabel?.text = "\(toDoList[indexPath.row].exp)exp"
        cell.toDoCircle?.image = UIImage(systemName: "circle.fill")
        cell.toDoCircle?.tintColor = UIColor(212, 132, 116)
//        cell.isUserInteractionEnabled = false
        
        expSum += toDoList[indexPath.row].exp
        
        progressBar.progress = Float(Float(expSum) / 100.0)
        
        print(expSum)
        print(Float(Float(expSum) / 100.0))
        
        if expSum >= 100 {
            DispatchQueue.main.async {
                self.progressBar.progress = 1.0
            }
            expSum = 0
            lv += 1
            lvLabel.text = "Lv.\(lv)"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.progressBar.progress = 0
            }
            
        }
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
