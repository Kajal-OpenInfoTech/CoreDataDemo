//
//  UpdateViewController.swift
//  CoreDataDemoDetails
//
//  Created by Mac 1 on 3/26/18.
//  Copyright © 2018 OpenInfoTech. All rights reserved.
//

import UIKit
import CoreData

class UpdateViewController: UIViewController,UITextFieldDelegate {

    var updateUser : NSManagedObject!
    var context : NSManagedObjectContext!
    @IBOutlet var txtUserName: UITextField!
    @IBOutlet var txtEmailID: UITextField!
    @IBOutlet var txtMobileNumber: UITextField!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var objUpdate = Users()
    var AllDataArray = [Users]()
    var tagIndex : Int!
    var predicate : NSPredicate!
    var userID : Int16!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        txtMobileNumber.text = objUpdate.mobile
        txtEmailID.text = objUpdate.email
        txtUserName.text = objUpdate.name
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtUserName.resignFirstResponder()
        txtEmailID.resignFirstResponder()
        txtMobileNumber.resignFirstResponder()
        return true
    }

    @IBAction func Update(_ sender: AnyObject) {
        userID = objUpdate.userID!
        context = appDelegate.persistentContainer.viewContext
        print(userID)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName : "Database")
        predicate = NSPredicate(format: "detailID == %d" , userID)
        request.predicate = predicate
        //try? request.execute()
        
        do {
            let result = try! context.fetch(request)
            
            for data in result as! [NSManagedObject] {

                data.setValue(txtMobileNumber.text, forKey: "mobileNumber")
                data.setValue(txtEmailID.text, forKey: "email")
                data.setValue(txtUserName.text, forKey: "firstName")
                  do
                   {
                     try!context.save()
                    
                    let alert = UIAlertController(title: "Successes", message: "Data Updated Successfully", preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                        self.navigationController?.popViewController(animated: true)
                    })
                    
                    alert.addAction(action)
                    
                    self.present(alert, animated: true, completion: nil)
                    
                   }
                    catch
                   {
                     print(error)
                   }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
