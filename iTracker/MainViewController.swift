//
//  MainViewController.swift
//  iTracker
//
//  Created by Vladimir on 15/12/2019.
//  Copyright © 2019 Vladimir. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var oneActive = false
    var whenTapped = Date()
    var indexPRow = IndexPath()
    
    var tasks = [Task]()
    var user: User?
    var timer: Timer?
    
    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addTaskPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toAddTaskSegue", sender: nil)
    }
    
    @IBAction func unwindToMainScreen(segue:UIStoryboardSegue){
        guard segue.identifier == "unwindToMainSegue" else { return }
        guard let svcAT = segue.source as? AddTaskViewController else { return }
        svcAT.task.user = user
        self.tasks.append(svcAT.task)
        self.tableView.reloadData()
    }
    
    func curDate() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy"
        let formattedDate = format.string(from: date)
        return formattedDate
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = user!.name
        currentDateLabel.text = curDate()
        
        tableView.tableFooterView = UIView(frame: CGRect.zero ) // убирает разделители пока не добавили ячейку
        
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        
        
        //        var red: CGFloat = 0
        //        var green: CGFloat = 0
        //        var blue: CGFloat = 0
        //        var alpha: CGFloat = 0
        //        addTaskButton.backgroundColor?.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        // Do any additional setup after loading the view.
    }
    
}

extension MainViewController:UITableViewDelegate,UITableViewDataSource {
    
    @objc func updateTimer() {
        guard let visibleRowsIndexPaths = tableView.indexPathsForVisibleRows else {
            return
        }
        
        for indexPath in visibleRowsIndexPaths {
            if indexPath == indexPRow, let cell = tableView.cellForRow(at: indexPath) as? TaskTableViewCell {
                let time = Date().timeIntervalSince(whenTapped)
                tasks[indexPath.row].time += 1
                let timeT = tasks[indexPath.row].time
                print(Int(time))
                print(timeT)
                
                let hoursC = Int(time) / 3600
                let minutesC = Int(time) / 60 % 60
                //        let seconds = Int(time) % 60
                
                let hoursT = timeT / 3600
                let minutesT = timeT / 60 % 60
                
                var currentTime: [String] = []
                var totalTime: [String] = []
                
                if hoursC > 1 && hoursC < 10 {
                    currentTime.append("0\(hoursC):")
                } else if hoursC > 10 {
                    currentTime.append("\(hoursC):")
                }
                if minutesC < 1 {
                    currentTime.append("<01'")
                    
                } else if minutesC < 10 {
                    currentTime.append("0\(minutesC)'")
                } else {
                    currentTime.append("\(minutesC)'")
                }
                if hoursT > 1 && hoursT < 10 {
                    totalTime.append("0\(hoursT):")
                } else if hoursT > 10 {
                    totalTime.append("\(hoursT):")
                }
                if minutesT < 1 {
                    totalTime.append("<01'")
                    
                } else if minutesT < 10 {
                    totalTime.append("0\(minutesT)'")
                } else {
                    totalTime.append("\(minutesT)'")
                }
                //times.append("\(seconds)s")
                
                cell.currentTime.text = currentTime.joined(separator: "")
                cell.totalTime.text = totalTime.joined(separator: "")
                
            }
        }
    }
    
    func createTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                         selector: #selector(updateTimer),
                                         userInfo: nil,
                                         repeats: true)
            timer?.tolerance = 0.1
        }
    }
    func cancelTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count // +1 не надо
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "task", for: indexPath) as! TaskTableViewCell
        
        cell.taskName.text = tasks[indexPath.row].name
        cell.taskImage.image = tasks[indexPath.row].image
        cell.taskImage.tintColor = tasks[indexPath.row].color
        cell.taskDescription.text = tasks[indexPath.row].description
        
        if oneActive == true {
            if cell.backgroundColor == #colorLiteral(red: 0.7147966899, green: 0.7151068653, blue: 0.6896061343, alpha: 1) {
                cell.isUserInteractionEnabled = false
            } else if cell.backgroundColor == tasks[indexPath.row].color {
                cell.taskImage.tintColor = #colorLiteral(red: 0.7147966899, green: 0.7151068653, blue: 0.6896061343, alpha: 1)
                cell.taskActivityIndicator.startAnimating()
            }
        } else {
            cell.isUserInteractionEnabled = true
            cell.taskActivityIndicator.stopAnimating()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as! TaskTableViewCell
        
        switch cell.backgroundColor {
        case #colorLiteral(red: 0.7147966899, green: 0.7151068653, blue: 0.6896061343, alpha: 1): do {
            cell.backgroundColor = tasks[indexPath.row].color
            indexPRow = indexPath
            oneActive = true
            whenTapped = Date()
            createTimer()
            }
        case tasks[indexPath.row].color: do {
            cell.backgroundColor = #colorLiteral(red: 0.7147966899, green: 0.7151068653, blue: 0.6896061343, alpha: 1)
            oneActive = false
            cancelTimer()
            print(tasks[indexPath.row].time)
            if tasks[indexPath.row].time < 60 {
                tasks[indexPath.row].time = 0
                cell.totalTime.text = nil
            }
            cell.currentTime.text = nil
            }
        default:
            cell.backgroundColor = #colorLiteral(red: 0.7147966899, green: 0.7151068653, blue: 0.6896061343, alpha: 1)
        }
        tableView.reloadData()
    }
}



