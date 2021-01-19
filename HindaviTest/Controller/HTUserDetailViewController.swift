//
//  HTUserDetailViewController.swift
//  HindaviTest
//
//  Created by Sonali on 17/01/21.
//  Copyright © 2021 Sonali. All rights reserved.
//

import UIKit
import KRProgressHUD
import Toast_Swift
import Koloda
import SDWebImage
import CoreData


class HTUserDetailViewController: UIViewController {
    
    @IBOutlet weak var kolodaView: KolodaView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var currentIndex = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Call api for get user list
        self.callApiForGetUserList()
        
    }
    
     //Mark -> View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
  //Mark ->   Call Api For get Userlist
    
    func callApiForGetUserList()  {
        
        if Connectivity.isConnectedToInternet() {
            
            KRProgressHUD.show()
            
            GAService.shared.apiForGetUserList { (isSucess, message, response) in
                
                KRProgressHUD.dismiss()
                if isSucess! {
                    
                    if let userList = response!["results"] as? [[String : Any]] {
                        HTUserList.shared.saveUserData(arrayUsers: userList)
                        
                        self.kolodaView.dataSource = self
                        self.kolodaView.delegate = self
                    }
                } else {
                    
                    self.view.makeToast(message)
                }
            }
        } else {
            self.view.makeToast(GAMessage.networkError)
        }
    }
    
    //Mark ->  IBActions
    
    @IBAction func onFavourite(_ sender: UIButton) {
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let favouriteVC = main.instantiateViewController(withIdentifier: String.init(describing: HTFavouriteUserViewController.self)) as! HTFavouriteUserViewController
        self.navigationController?.pushViewController(favouriteVC, animated: true)
    }
    
    @objc func onLocation(buttonLocation : UIButton)  {
        
        currentIndex = 2
        kolodaView.reloadData()
    }
    
    @objc func onCalendar(buttonCalendar : UIButton)  {
        
        currentIndex = 1
        kolodaView.reloadData()
    }
    
    @objc func onCall(buttoncall : UIButton)  {
        
        currentIndex = 3
        kolodaView.reloadData()
    }
    
    @objc func onLock(buttonLock : UIButton)  {
        
        currentIndex = 4
        kolodaView.reloadData()
    }
    
    @objc func onProfile(buttonProfile: UIButton)  {
        
        currentIndex = 0
        kolodaView.reloadData()
    }
    
}

//Mark -> KolodaViewDelegate

extension HTUserDetailViewController: KolodaViewDelegate {
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        koloda.reloadData()
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
    }
}

//Mark -> KolodaViewDataSource

extension HTUserDetailViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return HTUserList.shared.arrayUserList.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .fast
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        
        let userdata = HTUserList.shared.arrayUserList[index]
        
        switch currentIndex {
        case 1:
            let viewCalendar = Bundle.main.loadNibNamed("HTCalendarView", owner: self, options: nil)?.first as! HTCalendarView
            
            viewCalendar.buttonLocation.addTarget(self, action: #selector(self.onLocation(buttonLocation:)), for: .touchUpInside)
            viewCalendar.buttonProfile.addTarget(self, action: #selector(self.onProfile(buttonProfile:)), for: .touchUpInside)
            viewCalendar.buttonCall.addTarget(self, action: #selector(self.onCall(buttoncall:)), for: .touchUpInside)
            viewCalendar.buttonLock.addTarget(self, action: #selector(self.onLock(buttonLock:)), for: .touchUpInside)
            
            viewCalendar.labelDOB.text = userdata.DOBDetail?.date
            return viewCalendar
            
        case 2:
            let viewLocation = Bundle.main.loadNibNamed("HTLocationView", owner: self, options: nil)?.first as! HTLocationView
            
            viewLocation.buttonProfile.addTarget(self, action: #selector(self.onProfile(buttonProfile:)), for: .touchUpInside)
            viewLocation.buttonCalendar.addTarget(self, action: #selector(self.onCalendar(buttonCalendar:)), for: .touchUpInside)
            viewLocation.buttonCall.addTarget(self, action: #selector(self.onCall(buttoncall:)), for: .touchUpInside)
            viewLocation.buttonLock.addTarget(self, action: #selector(self.onLock(buttonLock:)), for: .touchUpInside)
            
            viewLocation.labelCity.text = "City : \(userdata.locationDetail?.city ?? "")"
            viewLocation.labelState.text = "State : \(userdata.locationDetail?.state ?? "")"
            viewLocation.labelCountry.text = "Country : \(userdata.locationDetail?.country ?? "")";        viewLocation.labelpostCode.text = "PostCode : \(userdata.locationDetail?.postcode ?? "")"
            
            return viewLocation
            
        case 3:
            let viewCall = Bundle.main.loadNibNamed("HTCallView", owner: self, options: nil)?.first as! HTCallView
            
            viewCall.buttonProfile.addTarget(self, action: #selector(self.onProfile(buttonProfile:)), for: .touchUpInside)
            viewCall.buttonLocation.addTarget(self, action: #selector(self.onLocation(buttonLocation:)), for: .touchUpInside)
            viewCall.buttonCalendar.addTarget(self, action: #selector(self.onCalendar(buttonCalendar:)), for: .touchUpInside)
            viewCall.buttonLock.addTarget(self, action: #selector(self.onLock(buttonLock:)), for: .touchUpInside)
            
            viewCall.labelCall.text = "Phone : \(userdata.Phone ?? "")"
            return viewCall
            
            
        case 4:
            let viewLock = Bundle.main.loadNibNamed("HTLockView", owner: self, options: nil)?.first as! HTLockView
            
            viewLock.buttonProfile.addTarget(self, action: #selector(self.onProfile(buttonProfile:)), for: .touchUpInside)
            viewLock.buttonLocation.addTarget(self, action: #selector(self.onLocation(buttonLocation:)), for: .touchUpInside)
            viewLock.buttonCalendar.addTarget(self, action: #selector(self.onCalendar(buttonCalendar:)), for: .touchUpInside)
            viewLock.buttonCall.addTarget(self, action: #selector(self.onCall(buttoncall:)), for: .touchUpInside)
            
            viewLock.labelUserName.text = "UserName : \(userdata.loginDetail?.username ?? "")"
            viewLock.labelPassword.text = "Password : \(userdata.loginDetail?.password ?? "")"
            
            return viewLock
            
        default:
            let view = Bundle.main.loadNibNamed("HTSwipeView", owner: self, options: nil)?.first as! HTSwipeView
            
            view.labelname.text = "\(userdata.nameDetail?.first ?? "") \(userdata.nameDetail?.last ?? "")"
            
            view.buttonLocation.addTarget(self, action: #selector(self.onLocation(buttonLocation:)), for: .touchUpInside)
            view.buttonCalendar.addTarget(self, action: #selector(self.onCalendar(buttonCalendar:)), for: .touchUpInside)
            view.buttonCall.addTarget(self, action: #selector(self.onCall(buttoncall:)), for: .touchUpInside)
            view.buttonLock.addTarget(self, action: #selector(self.onLock(buttonLock:)), for: .touchUpInside)
            
            let userImage = userdata.pictureDetail?.thumbnail!
            view.imageviewUserProfile.sd_imageIndicator = SDWebImageActivityIndicator.gray
            
            view.imageviewUserProfile.sd_setImage(with: URL.init(string: userImage!)) { (image, error, cache, urls) in
                if (error != nil) {
                    // Failed to load image
                    view.imageviewUserProfile.image = UIImage(named: "user")
                } else {
                    // Successful in loading image
                    view.imageviewUserProfile.image = image
                }
            }
            
            return view
        }
        
        
    }
    
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        
        //Mark ->   Save userdata in localDB

        if direction == .right {
            //Save data in core data
            
            let userData = HTUserList.shared.arrayUserList[index]
            
            let context = appDelegate.persistentContainer.viewContext
            
            let favouriteUsers = NSEntityDescription.insertNewObject(forEntityName: "FavouriteUsers", into: context)
            
            favouriteUsers.setValue(userData.nameDetail?.first, forKey: "userName")
            
            do {
                try context.save()
                print("SAVED \(String(describing: userData.nameDetail?.first))")
            }
            catch {
                //Process Error
                NSLog("ERROR: Could not save computer. Error: '\(error)'")
                return
            }
            
        }
        
    }
  
}


