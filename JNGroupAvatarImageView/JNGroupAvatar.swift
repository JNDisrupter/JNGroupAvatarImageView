//
//  JNGroupAvatar.swift
//  JNGroupAvatarImageView
//
//  Created by JNDisrupter on 9/19/17.
//  Copyright © 2017 JNDisrupter. All rights reserved.
//

/// JNGroupAvatar
public protocol JNGroupAvatar {
    
    /**
       Get display name
     - Returns: The display name for the avatar
     */
    func getGroupAvatarDisplayName() -> String
    
    /**
       Get Avatar image url
     - Returns: The image url
     */
    func getGroupAvatarImageUrl() -> String
    
    /**
     Get Avatar image
     - Returns: The UIImage
     */
    func getGroupAvatarImage() -> UIImage?
}
