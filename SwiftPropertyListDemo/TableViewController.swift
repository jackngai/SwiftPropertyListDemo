//
//  TableViewController.swift
//  SwiftPropertyListDemo
//
//  Created by Jack Ngai on 5/30/17.
//  Copyright © 2017 Jack Ngai. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var isColorInverted = true
    var color1 = UIColor(
        red: 0.3,
        green: 0.3,
        blue: 0.0,
        alpha: 1.0)
    let color2 = UIColor(
        white: 0.9,
        alpha: 1.0)
    var pies = [
        "Pizza",
        "Chicken Pot",
        "Shepherd's"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        readPropertyList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pies.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Pies"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = pies[indexPath.row]
        if isColorInverted {
            cell.backgroundColor = color2
            cell.textLabel?.textColor = color1
        } else {
            cell.backgroundColor = color1
            cell.textLabel?.textColor = color2
        }
        return cell
    }

    func readPropertyList(){
        var format = PropertyListSerialization.PropertyListFormat.xml //format of the property list
        var plistData:[String:AnyObject] = [:] // our data
        let plistPath:String? = Bundle.main.path(forResource: "data", ofType: "plist")!
        let plistXML = FileManager.default.contents(atPath: plistPath!)!
            
        do{
            plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &format)
                as! [String:AnyObject]
            
            isColorInverted = plistData["Inverse Colors"] as! Bool
            let red = plistData["Red"] as! CGFloat
            let green = plistData["Green"] as! CGFloat
            let blue = plistData["Blue"] as! CGFloat
            color1 = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
            pies = plistData["Pies"] as! [String]

        }
        catch{
            print("Error reading plist: \(error), format: \(format)")
        }
        

        


        
        
    }
    
}

