//
//  MainTableView.swift
//  buyList
//
//  Created by ibrahim doğan on 11.10.2018.
//  Copyright © 2018 ibrahimdn. All rights reserved.
//

import UIKit
import SnapKit
import CoreData
class MainTableView: UITableViewController {
    
    var isim = [String]()
    var miktar = [Int]()
    var yer =  [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(mainCell.self, forCellReuseIdentifier: "id123")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItem.Style.done, target: self, action: #selector(add))
        self.title = "CoreData TableView"
        

        self.navigationController?.isNavigationBarHidden = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
         self.navigationItem.rightBarButtonItem = self.editButtonItem
        getInfo()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    func getInfo(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "List")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject]{
                    if let isim = result.value(forKey: "isim") as? String {
                        self.isim.append(isim)
                    }
                    if let yer = result.value(forKey: "yer") as? String {
                        self.yer.append(yer)
                    }
                    if let miktar = result.value(forKey: "miktar") as? Int {
                        self.miktar.append(miktar)
                    }
                }
            }
        } catch {
            print("Error")
        }
    }
    @objc func add(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "addCoreData") as! ViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return isim.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id123", for: indexPath) as! mainCell
        cell.listLabel.text = "İsim: \(isim[indexPath.row]) - Miktar: \(miktar[indexPath.row]) - Yer: \(yer[indexPath.row]) "
        cell.listLabel.textAlignment = .center
        cell.listLabel.lineBreakMode = .byCharWrapping
        cell.contentView.addSubview(cell.listLabel)
        cell.listLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(cell.contentView.snp_leftMargin)
            make.right.equalTo(cell.contentView.snp_rightMargin)
        }
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchReqest = NSFetchRequest<NSFetchRequestResult>(entityName: "List")
            do {
                let results = try context.fetch(fetchReqest)
                for result in results as! [NSManagedObject] {
                    if let name = result.value(forKey: "isim") as? String {
                        if name == isim[indexPath.row] as? String{
                            context.delete(result)
                            isim.remove(at: indexPath.row)
                            miktar.remove(at: indexPath.row)
                            yer.remove(at: indexPath.row)
                            do {
                                try context.save()
                                tableView.reloadData()
                            }catch {
                                print("error")
                            }
                        }
                    }
                }
            } catch {
                print("error")
            }
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
