//
//  JNGroupAvatarImageView.swift
//  JNGroupAvatarImageView
//
//  Created by JNDisrupter on 9/19/17.
//  Copyright © 2017 JNDisrupter. All rights reserved.
//

import Foundation
import JNAvatarWithInitials

/**
 Images layout direction
 
 ````
 case rtl
 case ltr
 ````
 */
public enum ImagesLayoutDirection {
    
    /// Layout images from right to left
    case rightToLeft
    
    /// Layout images from left to right
    case leftToRight
}

/// JNGroupAvatarImageView
open class JNGroupAvatarImageView : UIView {
    
    /**
     Default initializer
     */
    init() {
        super.init(frame: CGRect())
    }
    
    /**
     Initializer method with CGRect
     */
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup view
        self.setupView()
    }
    
    /**
     Initializer method with NSCoder
     */
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Setup view
        self.setupView()
    }
    
    /**
     Layout subviews
     */
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        // Inset Threshold
        let insetsThreshold = self.layer.cornerRadius / (self.frame.width / 2)
        
        // Avatar image Inset
        let avatarImageInset = (self.frame.size.width / 2) / 3 * insetsThreshold
        
        // Get views
        let views = self.subviews.filter({$0 is JNAvatarWithInitials})
        
        // Check if there is three images
        if views.count >= 3 {
            
            // Start index
            let startIndex = views.count == 3 ? 1 : 0
            
            // Iterate views
            for index in startIndex..<views.count {
                
                // Get avatar image as JNAvatarWithInitials
                if let avatarImage = views[index] as? JNAvatarWithInitials {
                    
                    if (index + views.count) % 2 == 0 {
                        avatarImage.initialLabelInset = UIEdgeInsets(top: avatarImageInset, left: 0, bottom: 0, right: 0)
                    } else {
                        avatarImage.initialLabelInset = UIEdgeInsets(top: 0, left: 0, bottom: avatarImageInset , right: 0)
                    }
                }
            }
        }
    }
    
    /**
     Sets up the view by loading it from the xib file and setting its frame
     */
    private func setupView() {
        
        // Setup view
        self.clipsToBounds = true
        
        // Set background color
        self.backgroundColor = UIColor.white
    }
    
    /**
     Reset view
     */
    private func resetView() {
        
        // Reset image
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    /**
     Setup view
     - parameter avatars: The array of avatars to draw the maximum number of avatars is 4 if provided more than 4 the first 4 will be used
     - parameter imagesLayoutDirection: The images layout direction
     - parameter avatarsMargin: The margin between avatars default is 0.0
     - parameter placeHolderImage: Place holder image default is nil
     - parameter separatorColor: The Separator color
     - parameter showInitails: boolean to indicate if the initials should show if the image is failed, default is false
     - parameter initialsFont: The font to use for initials
     - parameter initialTextColor: The text color to use for initials
     */
    open func setup(avatars : [JNGroupAvatar] , imagesLayoutDirection : ImagesLayoutDirection = ImagesLayoutDirection.rightToLeft , avatarsMargin : CGFloat = 0.0 , separatorColor : UIColor = UIColor.gray, placeHolderImage : UIImage! = nil , showInitails : Bool = false , initialsFont : UIFont = UIFont.systemFont(ofSize: 14) , initialTextColor : UIColor = UIColor.black) {
        
        // Reset view
        self.resetView()
        
        // Check if avatars array is empty then add image from placeholder image
        if avatars.isEmpty && placeHolderImage != nil {
            
            // Create JNAvatarWithInitials
            let avatarView = JNAvatarWithInitials(frame: CGRect.zero)
            
            // Set content model
            avatarView.avatarContentMode = UIView.ContentMode.scaleAspectFill
            
             // Setup avatar view
            avatarView.setup(image: placeHolderImage, placeHolderImage: placeHolderImage, fullName: "", showInitails: false)
            
            // Add as subview
            self.addSubview(avatarView)
        } else {
            
            // Add images
            for i in 0..<min(4, avatars.count) {
                
                // Get item
                let avatar = avatars[i]
                
                // Create JNAvatarWithInitials
                let avatarView = JNAvatarWithInitials(frame: CGRect.zero)
                
                // Set content model
                avatarView.avatarContentMode = UIView.ContentMode.scaleAspectFill
                
                // Set font
                avatarView.initialsFont = initialsFont
                
                // Set text color
                avatarView.initialTextColor = initialTextColor
                
                // Get Avatar Image URL
                let avatarImageURL = avatar.getGroupAvatarImageUrl()
                
                // Setup avatar view
                if let image = avatar.getGroupAvatarImage(), avatarImageURL.isEmpty {
                    avatarView.setup(image : image , placeHolderImage: placeHolderImage, fullName: avatar.getGroupAvatarDisplayName(),showInitails : showInitails)
                } else {
                    avatarView.setup(imageUrl : avatarImageURL , placeHolderImage: placeHolderImage, fullName: avatar.getGroupAvatarDisplayName(),showInitails : showInitails)
                }
                
                // Add as subview
                self.addSubview(avatarView)
            }
        }
        
        // Add constraints
        self.addConstraints(avatarsMargin,imagesLayoutDirection:imagesLayoutDirection)
        
        // Get views
        let views = self.subviews
        
        // Build separaters array
        var separatorsView : [UIView] = []
        
        // Add separaters
        if views.count == 2 {
            
            // Create separator view
            let separatorView = UIView()
            
            // Set separator color
            separatorView.backgroundColor = separatorColor
            
            // Add as subview
            self.addSubview(separatorView)
            
            // Add separator view
            separatorsView.append(separatorView)
        } else if views.count > 2 {
            
            // Create two separator views
            for _ in 0..<2 {
                
                // Create separator view
                let separatorView = UIView()
                
                // Set separator color
                separatorView.backgroundColor = separatorColor
                
                // Add as subview
                self.addSubview(separatorView)
                
                // Add separator view
                separatorsView.append(separatorView)
            }
        }
        
        // Add separator views constraints
        self.addSeparatorsConstraints(avatarsMargin, imagesLayoutDirection: imagesLayoutDirection , avatarsViewCount : views.count , separatorViews : separatorsView)
    }
    
    /**
     Add constraints
     - parameter avatarsMargin: The margin between avatars
     - parameter imagesLayoutDirection: The images layout direction
     */
    private func addSeparatorsConstraints(_ avatarsMargin : CGFloat , imagesLayoutDirection : ImagesLayoutDirection , avatarsViewCount : Int , separatorViews : [UIView]) {
        
        // Iterate items
        for (index, view) in separatorViews.enumerated() {
            
            // Set auto translating auto layout
            view.translatesAutoresizingMaskIntoConstraints = false
            
            // Check if one item
            if avatarsViewCount == 2 {
                
                // Add constraints
                view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
                view.widthAnchor.constraint(equalToConstant: avatarsMargin).isActive = true
                view.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            } else if avatarsViewCount == 3 {
                
                // Check if first item
                if index == 0 {
                    
                    // Add constraints
                    view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                    view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
                    view.widthAnchor.constraint(equalToConstant: avatarsMargin).isActive = true
                    view.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
                }
                    
                    // Check if second item
                else if index == 1 {
                    
                    // Set constrain
                    view.heightAnchor.constraint(equalToConstant: avatarsMargin).isActive = true
                    view.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
                    view.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
                    
                    // Check images layout direction
                    if imagesLayoutDirection == ImagesLayoutDirection.rightToLeft {
                        view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
                    } else {
                        view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
                    }
                }
            } else if avatarsViewCount == 4 {
                
                // Check if first item
                if index == 0 {
                    
                    // Add constraints
                    view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                    view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
                    view.widthAnchor.constraint(equalToConstant: avatarsMargin).isActive = true
                    view.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
                }
                    
                    // Check if second item
                else if index == 1 {
                    
                    // Set constrains
                    view.heightAnchor.constraint(equalToConstant: avatarsMargin).isActive = true
                    view.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
                    view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
                    view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
                }
            }
        }
    }
    
    /**
     Add constraints
     - parameter avatarsMargin: The margin between avatars
     - parameter imagesLayoutDirection: The images layout direction
     */
    private func addConstraints(_ avatarsMargin : CGFloat , imagesLayoutDirection : ImagesLayoutDirection) {
        
        // Get views
        let views = self.subviews
        
        // Iterate items
        for (index, view) in views.enumerated() {
            
            // Check if view is JNAvatarWithInitilas
            if let view = view as? JNAvatarWithInitials {
                
                // Set auto translating auto layout
                view.translatesAutoresizingMaskIntoConstraints = false
                
                // Check if one item
                if views.count == 1 {
                    
                    // Add constraints
                    view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
                    view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                    view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
                    view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
                    
                } else if views.count == 2 {
                    
                    // Add constraints
                    view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                    view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
                    
                    // Check if first item
                    if index == 0 {
                        
                        // Check images layout direction
                        if imagesLayoutDirection == ImagesLayoutDirection.rightToLeft {
                            view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
                        } else {
                            view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
                        }
                    } else if index == 1 {
                        
                        // Check images layout direction
                        if imagesLayoutDirection == ImagesLayoutDirection.rightToLeft {
                            view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
                        } else {
                            view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
                        }
                    }
                } else if views.count == 3 {
                    
                    // Check if first item
                    if index == 0 {
                        
                        // Add constraints
                        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                        view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
                        
                        // Check images layout direction
                        if imagesLayoutDirection == ImagesLayoutDirection.rightToLeft {
                            view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
                        } else {
                            view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
                        }
                        
                    } else if index == 1 {
                        
                        // Add constraints
                        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                        
                        // Check images layout direction
                        if imagesLayoutDirection == ImagesLayoutDirection.rightToLeft {
                            view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
                        } else {
                            view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
                        }
                        
                        // Add height constraints
                        view.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5, constant: -avatarsMargin / 2).isActive = true
                    } else if index == 2 {
                        
                        // Add constraints
                        view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
                        
                        // Check images layout direction
                        if imagesLayoutDirection == ImagesLayoutDirection.rightToLeft {
                            view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
                        } else {
                            view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
                        }
                        
                        // Add height constraints
                        view.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5, constant: -avatarsMargin / 2).isActive = true
                    }
                } else if views.count == 4 {
                    
                    // Add height constraints
                    view.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5, constant: -avatarsMargin / 2).isActive = true
                    
                    // Check if first item
                    if index == 0 || index == 1 {
                        
                        // Check images layout direction
                        if imagesLayoutDirection == ImagesLayoutDirection.rightToLeft {
                            view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
                        } else {
                            view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
                        }
                        
                        if index == 0 {
                            
                            // Add constraints
                            view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                        } else {
                            
                            // Add constraints
                            view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
                        }
                    } else if index == 2 || index == 3 {
                        
                        // Check images layout direction
                        if imagesLayoutDirection == ImagesLayoutDirection.rightToLeft {
                            view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
                        } else {
                            view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
                        }
                        
                        if index == 2 {
                            view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                        } else {
                            view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
                        }
                    }
                }
                
                // Add width constraints
                view.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: views.count > 1 ? 0.5 : 1, constant: views.count > 1 ? (-avatarsMargin / 2) : 0).isActive = true
            }
        }
    }
}
