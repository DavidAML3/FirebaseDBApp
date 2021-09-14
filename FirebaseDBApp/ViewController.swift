//
//  ViewController.swift
//  FirebaseDBApp
//
//  Created by David Andres Mejia Lopez on 13/09/21.
//

import FirebaseDatabase
import UIKit

class ViewController: UIViewController {
    
    private let database = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        database.getData { _, snapshot in
            if snapshot.exists() {
                print("Got data \(snapshot.value!)")
            } else {
                print("No data available")
            }
        }
        
        database.childByAutoId().observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                return
            }
            
            print("Value: \(value)")
        })
        
        let button = UIButton(frame: CGRect(x: 20, y: 200, width: view.frame.size.width-40, height: 50))
        button.setTitle("Add Entry", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .link
        view.addSubview(button)
        button.addTarget(self, action: #selector(addNewEntry), for: .touchUpInside)
    }
    
    @objc private func addNewEntry() {
        let object: [String: Any] = [
            "name": "iOS Academy",
            "Youtube": "yes",
            "working": true
        ]
        
        database.observe(.childAdded) { (snapshot) in
            print(snapshot.value!)
        }
        
        database.childByAutoId().setValue(object)
    }


}

