//
//  TableViewController.swift
//  CoreDataDemoDetails
//
//  Created by Mac 1 on 3/23/18.
//  Copyright © 2018 OpenInfoTech. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {

    var objArray = [Users]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context : NSManagedObjectContext!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // var newUser : NSManagedObject!
        
     context  = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName : "Database")
        request.returnsObjectsAsFaults = false
        do {
            let result = try! context.fetch(request)

            for data in result as! [NSManagedObject] {

                 let d = data as! Database

                let firstName = d.value(forKey: "firstName") as? String ?? ""
                let email = d.value(forKey: "email") as? String ?? ""
                let mobileNumber = d.value(forKey: "mobileNumber") as? String ?? ""
                let userID = d.value(forKey: "detailID") as? Int16

                print(userID)
                var objUser = Users()

                objUser.userID = userID
                objUser.email = email
                objUser.mobile = mobileNumber
                objUser.name = firstName


                 print(data.objectID)
                objArray.append(objUser)
            }
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        objArray.removeAll()
        context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName : "Database")
        request.returnsObjectsAsFaults = false
        do {
            let result = try! context.fetch(request)

            if result.count > 0
            {
             for data in result as! [NSManagedObject] {

                let d = data as! Database

                let firstName = d.value(forKey: "firstName") as? String ?? ""
                let email = d.value(forKey: "email") as? String ?? ""
                let mobileNumber = d.value(forKey: "mobileNumber") as? String ?? ""
                let userID = d.value(forKey: "detailID") as? Int16

                let objUser = Users()

                objUser.userID = userID
                objUser.email = email
                objUser.mobile = mobileNumber
                objUser.name = firstName

                objArray.append(objUser)
             }
            }
        }

        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
   
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if objArray.count == 0
        {
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "No data available"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
          
        }
        else
        {
            tableView.separatorStyle = .singleLine
            tableView.backgroundView = nil
        }
        
        return objArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell

        cell.btnDelete.tag = indexPath.row
        cell.btnEdit.tag = indexPath.row
    
        cell.txtName.text = objArray[indexPath.row].name
        cell.txtEmail.text = objArray[indexPath.row].email
        cell.txtMobileNumber.text = objArray[indexPath.row].mobile

        print(objArray[indexPath.row].userID)
        return cell
    }
    
    @IBAction func Delete(_ sender: AnyObject) {

        let request = NSFetchRequest<NSFetchRequestResult>(entityName : "Database")
        request.returnsObjectsAsFaults = false

        let result = try! context.fetch(request)
        
        let data = result as! [NSManagedObject]
      
         let object = data[sender.tag]
        context.delete(object)
        
        objArray.remove(at: sender.tag)
      
        //tableView.deleteRows(at: sender.tag, with: .automatic)
        
        try! context.save()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
       
//        CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.table];
//        NSIndexPath *indexPath = [self.table indexPathForRowAtPoint:buttonPosition];
//        [self.arraylist removeObjectAtIndex:indexPath.row];
//        [self.table deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//
//        let buttonPossition =
//        buttonPossition
    }
    
    
    @IBAction func Edit(_ sender: AnyObject) {
       let svc = self.storyboard?.instantiateViewController(withIdentifier: "UpdateViewController") as! UpdateViewController
        
        svc.objUpdate = objArray[sender.tag]
        svc.tagIndex = sender.tag
      
        self.navigationController?.pushViewController(svc, animated: true)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
