//
//  AddTaskViewController.swift
//  iTracker
//
//  Created by Vladimir on 16/12/2019.
//  Copyright © 2019 Vladimir. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController{
    
    let colorArray:[UIColor] = [#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1),#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1),#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1),#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1),#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)]
    let imageArray:[UIImage] = [UIImage.init(systemName: "doc.fill")!,UIImage.init(systemName: "keyboard")!,UIImage.init(systemName: "book.fill")!,UIImage.init(systemName: "pencil")!,UIImage.init(systemName: "person.fill")!,UIImage.init(systemName: "zzz")!,UIImage.init(systemName: "play.fill")!,UIImage.init(systemName: "music.mic")!,UIImage.init(systemName: "heart.fill")!,UIImage.init(systemName: "camera.fill")!]
    var cellType = 0
    var task = Task()
    
    @IBOutlet weak var colView: UICollectionView!
    @IBOutlet weak var tabView: UITableView!
    
    @IBAction func createTaskButtonPressed(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
        self.colView.isHidden = true
        if task.name.isEmpty || task.description.isEmpty {
            let alert = UIAlertController(title: "Invalid task data", message: "Please enter valid task data", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Are you sure to create task: \(task.name) with description: \(task.description)?", message: nil, preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Yes", style: .default, handler: { action -> Void in
                self.performSegue(withIdentifier: "unwindToMainSegue", sender: nil) })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            alert.addAction(yesAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func nameTextField(_ sender: UITextField) {
        task.name = sender.text!
    }
    @IBAction func nameTextFieldEdSt(_ sender: UITextField) {
        self.colView.isHidden = true
    }
    
    
    @IBAction func selectIconButtonPressed(_ sender: UIButton) {
        
        self.view.endEditing(true)
        cellType = 1
        colView.reloadData()
        colView.isHidden = false
        
    }
    @IBAction func selectColorButtonPressed(_ sender: UIButton) {
        
        self.view.endEditing(true)
        cellType = 0
        colView.reloadData()
        colView.isHidden = false
    }
    
    @IBAction func descTextField(_ sender: UITextField) {
        task.description = sender.text!
    }
    @IBAction func descTextFieldEdSt(_ sender: UITextField) {
        self.colView.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.tabView.reloadData()
        colView.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colView.isHidden = true
        
    }
    
    
}

extension AddTaskViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0: do {
            let cell = tableView.dequeueReusableCell(withIdentifier: "taskName", for: indexPath) as? TaskNameTableViewCell
            return cell!
            }
        case 1: do {
            let cell = tableView.dequeueReusableCell(withIdentifier: "taskImage", for: indexPath) as? TaskImageTableViewCell
            cell!.selectIconButton.setBackgroundImage(task.image, for: .normal)
            cell!.selectIconButton.tintColor = task.color
            return cell!
            }
        case 2: do {
            let cell = tableView.dequeueReusableCell(withIdentifier: "taskColor", for: indexPath) as? TaskColorTableViewCell
            cell!.selectColorButton.layer.cornerRadius = 0.5 * cell!.selectColorButton.bounds.size.width
            cell!.selectColorButton.backgroundColor = task.color
            return cell!
            }
        case 3: do {
            let cell = tableView.dequeueReusableCell(withIdentifier: "taskDescription", for: indexPath) as? TaskDescriptionTableViewCell
            return cell!
            }
        default:
            return UITableViewCell()
        }
    }
}

extension AddTaskViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch cellType {
        case 0: do { return colorArray.count }
        case 1: do { return imageArray.count }
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if cellType == 0 {
            let cell = colView.dequeueReusableCell(withReuseIdentifier: "imageColor", for: indexPath)
            cell.backgroundColor = colorArray[indexPath.row]
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 0.5
            return cell
        } else if cellType == 1 {
            let cell = colView.dequeueReusableCell(withReuseIdentifier: "image", for: indexPath) as! SelectImageCollectionViewCell
            cell.imageView.image = imageArray[indexPath.row]
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderWidth = 0.5
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if cellType == 0 {
            task.color = collectionView.cellForItem(at: indexPath)!.backgroundColor!
        } else if cellType == 1 {
            let cell = collectionView.cellForItem(at: indexPath) as! SelectImageCollectionViewCell
            task.image = cell.imageView.image!
        }
        tabView.reloadData()
    }
}

//class SelectIconCollectionViewCell: UICollectionViewCell {
//
//}

