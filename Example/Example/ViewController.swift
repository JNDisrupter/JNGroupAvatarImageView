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
        user1.name = "Jayel Zaghmoutt"
        user1.imageUrl = "https://avatars3.githubusercontent.com/u/5199603"
        
        let user2 = User()
        user2.name = "Mohammad Nabulsi"
        user2.imageUrl = "https://avatars3.githubusercontent.com/u/8538687"
        
        let user3 = User()
        user3.name = "Steve Jobs"
        user3.imageUrl = "https://pi.tedcdn.com/r/pe.tedcdn.com/images/ted/0ef62e4df27b4ba7294de889fdbc33e476a08ec9_254x191.jpg?"
        
        let user4 = User()
        user4.name = "Ronald Wayne"
        
        let user5 = User()
        user5.name = "Steve Wozniak"
        
        // Setup group avatar image view
        self.groupAvatarImageView.setup(avatars: Array([user1,user2,user3,user4,user5].prefix(upTo: self.itemIndex + 1)) , avatarsMargin : 2.0 , separatorColor : UIColor.black , showInitails : true, initialTextColor : UIColor.black)
        
        // Add border container
        self.groupAvatarImageView.layer.borderColor = UIColor.black.cgColor
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

