//
//  StockTableViewController.swift
//  stockBS
//
//  Created by Steven Wang on 2016/5/24.
//  Copyright © 2016年 ka666wang. All rights reserved.
//

import UIKit

class StockTableViewController: UITableViewController {

    
    var stockArray=[[String:String]]()
    
    
    // MARK: - Table view data source

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return 0
        return self.stockArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Stock_ID", forIndexPath: indexPath) as! StockTableViewCell

        // Configure the cell...

        let stock=self.stockArray[indexPath.row]
        cell.noLabel.text = stock["no"]
        cell.nameLabel.text = stock["name"]
        
        return cell
    }
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(StockTableViewController.AddStockNoti(_:)) , name: "AddStockNoti", object: nil)
        
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths.first
        
        let path = (documentsDirectory! as NSString).stringByAppendingPathComponent("stock.txt")
        
        
        let array = NSArray(contentsOfFile: path)
        
        if let array = array {
            self.stockArray = array as! [[String : String]]
        }
        
    }
    
    func AddStockNoti(noti:NSNotification){
        
        let stock = noti.userInfo!["stock"] as! [String:String]
        self.stockArray.insert(stock, atIndex: 0)
        
        self.save()
        
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    func save() {
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths.first
        let path = (documentsDirectory! as NSString).stringByAppendingPathComponent("stock.txt")
        
        (self.stockArray as NSArray).writeToFile(path, atomically: true)
    }
    
    
    //刪除
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        
        self.stockArray.removeAtIndex(indexPath.row)   //刪除Array
        
        self.save() //寫入file
        
        //刪除tableViewCell
        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic  )
    }

    
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
