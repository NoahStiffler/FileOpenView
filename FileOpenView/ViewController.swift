//
//  ViewController.swift
//  FileOpenView
//
//  Created by Noah Stiffler on 5/1/20.
//  Copyright © 2020 Noah Stiffler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var fName: UITextField!
    @IBOutlet weak var lName: UITextField!
    @IBOutlet weak var sSNumber: UITextField!
    @IBOutlet weak var dateOfBirth: UITextField!
    
    
    
    @IBAction func saveButton(_ sender: Any) {
        
        let csvLine:String = "\(fName.text!) \(lName.text!)! Your Social Security Number is \(sSNumber.text!), and your date of birth is \(dateOfBirth.text!) is this correct?\n"
        
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        
        let docDir:String=paths[0]
        
        let resultsFile:String=(docDir as NSString) .appendingPathComponent("textOutput.csv")
        
        
        
        if !FileManager.default.fileExists(atPath: resultsFile) {
            FileManager.default.createFile(atPath: resultsFile,contents:nil, attributes: nil)
        }
        
        let fileHandle:FileHandle=FileHandle(forUpdatingAtPath:resultsFile)!
        fileHandle.seekToEndOfFile()
        fileHandle.write(csvLine.data(using: String.Encoding.utf8)!)
        
        fName.text = ""
        lName.text = ""
        sSNumber.text = ""
        dateOfBirth.text = ""
        
    }
    
    @IBAction func showResults(_ sender: Any) {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let docDir:String=paths[0]
        let resultsFile:String=(docDir as NSString) .appendingPathComponent("textOutput.csv")
        
        
        if FileManager.default.fileExists(atPath: resultsFile) {
            let fileHandle:FileHandle = FileHandle(forReadingAtPath:resultsFile)!
            
            let resultsData:String!=NSString(data: fileHandle.availableData, encoding: String.Encoding.utf8.rawValue)! as String
            
          //  fileHandle.closeFile()
            
         //   textOutput?.text=resultsData
            
            let popUp = UIAlertController(title: "Yoink", message: (resultsData), preferredStyle: .alert)
            popUp.addAction(UIAlertAction(title: NSLocalizedString("Darn!", comment: "Default action"), style: .`default`, handler: { _ in }))
            self.present(popUp,animated: true)
            
            fileHandle.closeFile()
        }
        else{
            
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

