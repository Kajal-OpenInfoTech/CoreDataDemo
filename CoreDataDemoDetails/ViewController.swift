//
//  ViewController.swift
//  CoreDataDemoDetails
//
//  Created by Mac 1 on 3/23/18.
//  Copyright © 2018 OpenInfoTech. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var txtMobile: UITextField!
    
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtUserName: UITextField!
    
    var newUser : NSManagedObject!
    var context : NSManagedObjectContext!
    var predicate : NSPredicate!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationItem.title = "Enter New User"
        
        self.txtMobile.delegate = self
        self.txtEmail.delegate = self
        self.txtUserName.delegate = self
        
        
    }

   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.txtUserName.resignFirstResponder()
        self.txtEmail.resignFirstResponder()
        self.txtMobile.resignFirstResponder()
       return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
      if textField == txtEmail
      {
       if isValidEmail(testStr: txtEmail.text!) != true
       {
       var alert = UIAlertController(title: "Failure", message: "Enter valid Email", preferredStyle: .alert)
        
        var action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
        }
      }
        
        if textField == txtMobile
        {
            if isValidMobileNumber(MobileNumber: txtMobile.text!) != true
            {
                var alert = UIAlertController(title: "Failure", message: "Enter valid Mobile Number", preferredStyle: .alert)
                
                var action = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                alert.addAction(action)
                
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    @IBAction func Save(_ sender: Any) {
        context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Database", in: context)
        newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        let valueAutoInc = AppDelegate.primaryIDS
        let pID = AutoIncreamentID (id: valueAutoInc!)
       
        print("printitng pUD's \(pID)")
       
        
        newUser.setValue(pID, forKey: "detailID")
        newUser.setValue(txtUserName.text, forKey: "firstName")
        newUser.setValue(txtEmail.text, forKey: "email")
        newUser.setValue(txtMobile.text, forKey: "mobileNumber")
        
        do
        {
            try! context.save()
            Alert(title: "Success", message: "Data Saved successfully")
        }
        catch
        {
            print("Unable to insert data")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 func Alert(title : String,message : String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
        let action = UIAlertAction(title: "OK", style: .default) { (_) in
        let fvc = self.navigationController?.popViewController(animated: true)
         }
    
      alert.addAction(action)
      self.present(alert, animated: true, completion: nil)
    }
    
    func AutoIncreamentID(id : Int16) -> Int16
    {
        var NewID : Int16!
        let request = NSFetchRequest<NSFetchRequestResult>(entityName : "Database")
        request.fetchLimit = 1
        request.sortDescriptors = [NSSortDescriptor(key: "detailID", ascending: false)]
     
        let result = try! context.fetch(request)
        print(result)
        for ID in result as! [NSManagedObject]
        {
           let d = ID as! Database
            NewID = d.detailID
        }
        print(id)
        var valueID  = id
            if NewID >= valueID
             {
                valueID = NewID + 1
                AppDelegate.primaryIDS = valueID
             }
        else
            {
                valueID = valueID + 1
                AppDelegate.primaryIDS = valueID
             }

        print(AppDelegate.primaryIDS)
        return AppDelegate.primaryIDS
    }
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func isValidMobileNumber(MobileNumber : String) ->Bool
    {
        let telefonRegex = "^[0-9]{10}$"
        let mobileTest = NSPredicate(format: "SELF MATCHES %@", telefonRegex)
        return mobileTest.evaluate(with:MobileNumber)
    }
}

