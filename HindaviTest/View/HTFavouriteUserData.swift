//
//  HTFavouriteUserData.swift
//  HindaviTest
//
//  Created by Sonali on 18/01/21.
//  Copyright © 2021 Sonali. All rights reserved.
//

import UIKit

class HTFavouriteUserData: UITableViewCell {
    
    @IBOutlet weak var labelUserName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

//Mark -> UITableviewDataSource & Delegate

extension HTFavouriteUserViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrayUserList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let userCell = tableviewList.dequeueReusableCell(withIdentifier: String(describing: HTFavouriteUserData.self)) as! HTFavouriteUserData
        let userData = self.arrayUserList[indexPath.row]
        
        userCell.labelUserName.text = userData.value(forKey: "userName") as? String ?? ""
        return userCell
        
    }
}
