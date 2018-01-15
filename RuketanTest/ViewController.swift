//
//  ViewController.swift
//  RuketanTest
//
//  Created by Shauket on 1/12/18.
//  Copyright © 2018 Shauket. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tileCount:Int = 5
    private var button : UIButton?
    private var tableView : UITableView?
    
    let colorArray:[UIColor] = [UIColor.red,UIColor.green,UIColor.blue]
    var usedColorCode:[Int:Bool] = [:]
    
    var recentColorCode:Int = -1
    var currentColorCode:Int = Int(arc4random_uniform(3))  //random pick color code
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateUsedColorDict() //populate used color dict with false
        
        self.button = UIButton()
        self.button?.backgroundColor = UIColor.blue
        self.button?.titleLabel?.textColor = UIColor.black
        self.button?.setTitle("Press Me!", for:UIControlState.normal)
        self.button?.addTarget(self, action: #selector(pressButton(_:)), for: UIControlEvents.touchUpInside)
        self.tableView = UITableView()
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.view.addSubview(self.button!)
        self.view.addSubview(self.tableView!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillLayoutSubviews() {
        let frame : CGRect = self.view.frame
        self.button?.frame = CGRect(x:0, y:0, width:100, height:100)
        self.tableView?.frame = CGRect(x:0, y:100, width:frame.width, height:frame.height - 100)
    }
    @objc func pressButton(_ sender : UIButton) {
        //reset to default usedColorCode valuse to false
        populateUsedColorDict()
        
        self.tableView?.reloadData()
    }
    // MARK: UITableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tileCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = UITableViewCell() // You can change this part, too
        
        while recentColorCode == currentColorCode {
            currentColorCode = Int(arc4random_uniform(3))
        }
        
        recentColorCode = currentColorCode
        
        cell.backgroundColor = colorArray[currentColorCode]
        
        if indexPath.row == tileCount-1  {
            if let colorCode = getUnusedColorCode() {
                cell.backgroundColor = colorArray[colorCode]
            }
        }
        else{
            usedColorCode[currentColorCode] = true
        }
        
        return cell
    }
    
    func getUnusedColorCode() -> Int? {
        
        var colorcode:Int?
        for i in 0..<usedColorCode.count {
            if usedColorCode[i] == false {
                colorcode = i
                return colorcode
            }
        }
        return colorcode
    }
    
    func populateUsedColorDict() -> Void {
        usedColorCode = [0:false,1:false,2:false]
    }
}

