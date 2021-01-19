//
//  HTFavouriteUserViewController.swift
//  HindaviTest
//
//  Created by Sonali on 18/01/21.
//  Copyright © 2021 Sonali. All rights reserved.
//

import UIKit
import CoreData

class HTFavouriteUserViewController: UIViewController {
    
    @IBOutlet weak var tableviewList: UITableView!
    var arrayUserList = [NSManagedObject]()
    let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableviewList.register(UINib.init(nibName: String(describing: HTFavouriteUserData.self), bundle: nil), forCellReuseIdentifier: String(describing: HTFavouriteUserData.self))
        
        fetchFavouriteUserRecords()
        
    }
    
    //Mark ->   Fetch userdata in localDB
    
    func fetchFavouriteUserRecords()  {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedObjContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavouriteUsers")
        do {
            arrayUserList = try managedObjContext.fetch(fetchRequest)
            
            tableviewList.reloadData()
        } catch let error as NSError {
            print("Error while fetching the data:: ",error.description)
        }
        
    }
}


