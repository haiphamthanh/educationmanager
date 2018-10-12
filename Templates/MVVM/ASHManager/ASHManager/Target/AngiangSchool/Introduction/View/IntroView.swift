//
//  IntroView.swift
//  ASHManager
//
//  Created by PhanDuyHai on 12/22/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import Foundation
import EAIntroView

class IntroView: UIView {
    var bottomHeight: CGFloat = 55
    let logoImageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    let iconImageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        img.image = UIImage(named: "IntroLogo")
        return img
    }()
    
    let titleIntroLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.textColor = UIColor.color(AppColor.primary)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 55)
        //lb.font =
        return lb
    }()
    
    let contentTitleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .center
        lb.textColor = .white
        //lb.font =
        return lb
    }()
    
    let contentIntroLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .center
        lb.numberOfLines = 10
        lb.textColor = .white
        //lb.font =
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if (Device.isIphone5 || Device.isIphone4OrLess) {
            self.bottomHeight = 50
        }
        self.addSubview(self.logoImageView)
        self.addSubview(iconImageView)
        self.addSubview(titleIntroLabel)
        self.addSubview(contentTitleLabel)
        self.addSubview(contentIntroLabel)
        self.addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func addConstraints() {
        let views = ["logoImageView": self.logoImageView]
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[logoImageView]-50-|", options: [], metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[logoImageView]|", options: [], metrics: nil, views: views))
        //
        self.addConstraint(NSLayoutConstraint.init(item: self.logoImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
        self.contentTitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        self.contentTitleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -(bottomHeight / 2)).isActive = true
        self.contentTitleLabel.widthAnchor.constraint(equalToConstant: Device.screenWidth - 20).isActive = true
        self.contentTitleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.titleIntroLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        self.titleIntroLabel.bottomAnchor.constraint(equalTo: self.contentTitleLabel.topAnchor, constant: -10).isActive = true
        self.titleIntroLabel.widthAnchor.constraint(equalToConstant: Device.screenWidth - 20).isActive = true
        self.titleIntroLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        self.iconImageView.bottomAnchor.constraint(equalTo: self.titleIntroLabel.topAnchor, constant: -10).isActive = true
        self.iconImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.iconImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.contentIntroLabel.topAnchor.constraint(equalTo: self.contentTitleLabel.bottomAnchor, constant: 10).isActive = true
        //self.contentIntroLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        self.contentIntroLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        self.contentIntroLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        self.contentIntroLabel.heightAnchor.constraint(equalToConstant: Device.screenHeight / 4 - 20).isActive = true
    }
}

