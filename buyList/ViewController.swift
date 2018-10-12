//
//  ViewController.swift
//  buyList
//
//  Created by ibrahim doğan on 10.10.2018.
//  Copyright © 2018 ibrahimdn. All rights reserved.
//

import UIKit
import SnapKit
import CoreData

class ViewController: UIViewController {
    
    let buy = UITextField()
    let number = UITextField()
    let addButton = UIButton(type: .system)
    let local =  UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }

    func updateView(){
      
        view.addSubview(buy)
        view.addSubview(number)
        view.addSubview(addButton)
        view.addSubview(local)
        
        local.keyboardType = .default
        local.placeholder = "Alınacak Yer"
        local.layer.borderWidth = 1
        local.layer.borderColor = UIColor.lightGray.cgColor
        local.layer.cornerRadius = 5
        local.snp.makeConstraints { (make) in
            
            make.height.equalTo(30)
            make.size.width.equalTo(view.bounds.width * 0.7)
            make.centerX.equalTo(view.snp_centerXWithinMargins)
            make.centerY.equalTo(view.snp_centerYWithinMargins).offset(-140)
        }
        
        buy.keyboardType = .default
        buy.placeholder = "Alınacak Adı"
        buy.layer.borderWidth = 1
        buy.layer.borderColor = UIColor.lightGray.cgColor
        buy.layer.cornerRadius = 5
        buy.snp.makeConstraints { (make) in
        
            make.height.equalTo(30)
            make.size.width.equalTo(view.bounds.width * 0.7)
            make.centerX.equalTo(view.snp_centerXWithinMargins)
            make.centerY.equalTo(view.snp_centerYWithinMargins).offset(-100)
        }
        
        number.keyboardType = .numberPad
        number.placeholder = "Miktar"
        number.layer.borderWidth = 1
        number.layer.borderColor = UIColor.lightGray.cgColor
        number.layer.cornerRadius = 5
        number.snp.makeConstraints { (make) in
            
            make.height.equalTo(30)
            make.size.width.equalTo(view.bounds.width * 0.7)
            make.centerX.equalTo(view.snp_centerXWithinMargins)
            make.centerY.equalTo(view.snp_centerYWithinMargins).offset(-60)
        }
        addButton.addTarget(self, action: #selector(addCoreData), for: .touchUpInside)
        addButton.layer.borderWidth = 2
        addButton.layer.borderColor = UIColor.lightGray.cgColor
        addButton.layer.cornerRadius = 10
        addButton.setTitleColor(UIColor.red, for: .normal)
        addButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        addButton.setTitle("Ekle", for: UIControl.State.normal)
        addButton.backgroundColor = UIColor.lightGray
        addButton.snp.makeConstraints { (make) in
            
            make.height.equalTo(30)
            make.size.width.equalTo(view.bounds.width * 0.7)
            make.centerX.equalTo(view.snp_centerXWithinMargins)
            make.centerY.equalTo(view.snp_centerYWithinMargins)
        }
        
    }
    @objc func addCoreData(sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newBuy = NSEntityDescription.insertNewObject(forEntityName: "List", into: context)
        newBuy.setValue(buy.text, forKey: "isim")
        newBuy.setValue(local.text, forKey: "yer")
        newBuy.setValue(Int(number.text!), forKey: "miktar")
        
        do {
            try context.save()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "mainView") as! MainTableView
            self.navigationController?.popViewController(animated: true)
        }catch {
            print("error")
        }
        
    }

}

