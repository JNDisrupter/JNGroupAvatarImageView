//
//  ViewController.swift
//  Example
//
//  Created by JNDisrupter on 10/12/17.
//  Copyright © 2017 JNDisrupter. All rights reserved.
//

import UIKit
import JNGroupAvatarImageView

class ViewController: UIViewController {

    var itemIndex = 0
    
    // Group avatar image view
    @IBOutlet weak var groupAvatarImageView: JNGroupAvatarImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let user1 = User()
        user1.name = "Steve Wozniak"
        user1.imageUrl = "https://upload.wikimedia.org/wikipedia/commons/f/f6/Steve_Wozniak.jpg"
        
        let user2 = User()
        user2.name = "Sophia Teutschler"
        user2.imageUrl = "https://media.licdn.com/mpr/mpr/shrinknp_200_200/AAEAAQAAAAAAAAfgAAAAJDVhZDdkZWEwLTllMGItNDJiNS1hYTBhLWI1MmNhMmJiZDYxMA.jpg"
        
        let user3 = User()
        user3.name = "Steve Jobs"
        user3.imageUrl = "https://pi.tedcdn.com/r/pe.tedcdn.com/images/ted/0ef62e4df27b4ba7294de889fdbc33e476a08ec9_254x191.jpg?"
        
        let user4 = User()
        user4.name = "Ronald Wayne"
        
        let user5 = User()
        user5.name = "Steve Wozniak"
        
        // Setup group avatar image view
        self.groupAvatarImageView.setup(avatars: Array([user1,user2,user3,user4,user5].prefix(upTo: self.itemIndex + 1)) , avatarsMargin : 2.0 , separatorColor : UIColor.gray , showInitails : true, initialTextColor : UIColor.black)
        
        // Add border container
        self.groupAvatarImageView.layer.borderColor = UIColor.gray.cgColor
        self.groupAvatarImageView.layer.borderWidth = 2
        
        if self.itemIndex >= 4 {
            self.groupAvatarImageView.alpha = 0
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Set corner radius
        self.groupAvatarImageView.layer.cornerRadius = self.groupAvatarImageView.bounds.size.height / 2
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.3) {
            self.groupAvatarImageView.alpha = 1
        }
    }
    
    class User : JNGroupAvatar {
        
        var name = ""
        var imageUrl = ""
        
        func getImageUrl() -> String {
            return self.imageUrl
        }
        
        func getDisplayName() -> String {
            return self.name
        }
    }
}

