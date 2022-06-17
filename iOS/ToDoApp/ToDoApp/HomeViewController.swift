//
//  HomeViewController.swift
//  ToDoApp
//
//  Created by 内山和輝 on 2022/06/16.
//

import UIKit

final class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

//    let ToDoList = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K"]

    private var barButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIButton! {
        didSet {
            self.addButton.layer.cornerRadius = 25
        }
    }
    
    @IBOutlet private weak var toDoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoTableView.register(ToDoTableViewCell.nib, forCellReuseIdentifier: ToDoTableViewCell.identifier)
        
        toDoTableView.delegate = self
        toDoTableView.dataSource = self
        
        title = "ToDoリスト"
        barButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(click))
        navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func click() {
        let edit = AddViewController()
        navigationController?.pushViewController(edit, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToDoModel.ToDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.identifier, for: indexPath) as! ToDoTableViewCell
        cell.textLabel?.text = ToDoModel.ToDoList[indexPath.row]
        return cell
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
