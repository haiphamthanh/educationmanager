//
//  IntroViewController.swift
//  ASHManager
//
//  Created by PhanDuyHai on 12/22/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import UIKit
import EAIntroView

class IntroViewController: BaseViewController {
    
    fileprivate let introView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    fileprivate let loginButton: UIButton = {
        let bt = UIButton()
        bt.backgroundColor = UIColor.lightGray
        bt.setTitle(LocalizedString.titleButtonLoginIntroduct(), for: .normal)
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()
    
    fileprivate let registerButton: UIButton = {
        let bt = UIButton()
        bt.backgroundColor = UIColor.darkGray
        bt.setTitle(LocalizedString.titleButtonRegisterIntroduct(), for: .normal)
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()
    
    fileprivate let titleIconView1: IntroView = {
        let v = IntroView()
        v.logoImageView.image = #imageLiteral(resourceName: "Intro1")
        v.titleIntroLabel.text = LocalizedString.titleIntroduct()
        v.contentTitleLabel.text = LocalizedString.titleHeadingIntroduct()
        v.contentIntroLabel.text = LocalizedString.contentIntroduct()
        return v
    }()
    
    fileprivate let titleIconView2: IntroView = {
        let v = IntroView()
        v.logoImageView.image = #imageLiteral(resourceName: "Intro2")
        v.titleIntroLabel.text = LocalizedString.titleIntroduct()
        v.contentTitleLabel.text = LocalizedString.titleHeadingIntroduct()
        v.contentIntroLabel.text = LocalizedString.contentIntroduct()
        return v
    }()
    
    fileprivate let titleIconView3: IntroView = {
        let v = IntroView()
        v.logoImageView.image = #imageLiteral(resourceName: "Intro3")
        v.titleIntroLabel.text = LocalizedString.titleIntroduct()
        v.contentTitleLabel.text = LocalizedString.titleHeadingIntroduct()
        v.contentIntroLabel.text = LocalizedString.contentIntroduct()
        return v
    }()
    
    fileprivate let titleIconView4: IntroView = {
        let v = IntroView()
        v.logoImageView.image = #imageLiteral(resourceName: "Intro4")
        v.titleIntroLabel.text = LocalizedString.titleIntroduct()
        v.contentTitleLabel.text = LocalizedString.titleHeadingIntroduct()
        v.contentIntroLabel.text = LocalizedString.contentIntroduct()
        return v
    }()
    
    fileprivate let titleIconView5: IntroView = {
        let v = IntroView()
        v.logoImageView.image = #imageLiteral(resourceName: "Intro5")
        v.titleIntroLabel.text = LocalizedString.titleIntroduct()
        v.contentTitleLabel.text = LocalizedString.titleHeadingIntroduct()
        v.contentIntroLabel.text = LocalizedString.contentIntroduct()
        return v
    }()
    
    fileprivate let titleIconView6: IntroView = {
        let v = IntroView()
        v.logoImageView.image = #imageLiteral(resourceName: "Intro6")
        //v.logoImageView.image = #imageLiteral(resourceName: "Intro5")
        v.titleIntroLabel.text = LocalizedString.titleIntroduct()
        v.contentTitleLabel.text = LocalizedString.titleHeadingIntroduct()
        v.contentTitleLabel.textColor = UIColor.darkGray
        return v
    }()
    
    override class func storyNameProvider() -> String {
        return "IntroStoryboard"
    }
    
    override func viewDidLoad() {
        self.view.addSubview(self.introView)
        self.view.addSubview(self.registerButton)
        self.view.addSubview(self.loginButton)
        self.addContrains()
        self.addIntroView()
        self.loginButton.addTarget(self, action: #selector(tapLoginButton), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    fileprivate func addContrains() {
        var bottomHeight: CGFloat = 55
        if (Device.isIphone5 || Device.isIphone4OrLess) {
            bottomHeight = 50
        }
        self.introView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        self.introView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.introView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.introView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -bottomHeight).isActive = true
        
        self.registerButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.registerButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        self.registerButton.heightAnchor.constraint(equalToConstant: bottomHeight).isActive = true
        self.registerButton.widthAnchor.constraint(equalToConstant: Device.screenWidth / 2).isActive = true
        
        self.loginButton.leftAnchor.constraint(equalTo: self.registerButton.rightAnchor, constant: 0).isActive = true
        self.loginButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.loginButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        self.loginButton.heightAnchor.constraint(equalToConstant: bottomHeight).isActive = true
        
    }
    
    fileprivate func addIntroView() {
        let page1 = EAIntroPage()
        page1.bgColor = UIColor(white: 0.85, alpha: 0.9)
        page1.titleIconView = self.titleIconView1
        page1.titleIconView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 50)
        
        
        let page2 = EAIntroPage()
        page2.bgColor = UIColor(white: 0.85, alpha: 0.9)
        page2.titleIconView = self.titleIconView2
        page2.titleIconView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 50)
        
        
        let page3 = EAIntroPage()
        page3.bgColor = UIColor(white: 0.85, alpha: 0.9)
        page3.titleIconView = self.titleIconView3
        page3.titleIconView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 50)
        
        let page4 = EAIntroPage()
        page4.bgColor = UIColor(white: 0.85, alpha: 0.9)
        page4.titleIconView = self.titleIconView4
        page4.titleIconView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 50)
        
        let page5 = EAIntroPage()
        page5.bgColor = UIColor(white: 0.85, alpha: 0.9)
        page5.titleIconView = self.titleIconView5
        page5.titleIconView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 50)
        
        let page6 = EAIntroPage()
        page6.bgColor = UIColor(white: 0.85, alpha: 0.9)
        page6.titleIconView = self.titleIconView6
        page6.titleIconView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 50)
        
        let eaIntroView = EAIntroView(frame: self.introView.bounds, andPages: [page1, page2, page3, page4, page5, page6])
        
        //        eaIntroView?.skipButtonAlignment = EAViewAlignment.right
        //        eaIntroView?.skipButtonY = 50
        //        eaIntroView?.skipButton.setTitleColor(.black, for: .normal)
        //eaIntroView?.skipButton.titleLabel?.font = AppFontName.LIGHT.size(.body)
        eaIntroView?.skipButton.isHidden = true
        eaIntroView?.skipButton.isEnabled = true
        eaIntroView?.pageControlY = 42
        eaIntroView?.pageControl.currentPageIndicatorTintColor = .darkGray
        eaIntroView?.pageControl.pageIndicatorTintColor = UIColor.lightGray
        
        eaIntroView?.show(in: self.introView, animateDuration: 0.3)
    }
    
    @objc func tapLoginButton() {
        let storyboard = UIStoryboard(name: "ResetPassStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ResetPasswordViewController")
        self.navigationController?.pushViewController(vc, animated: true)
 
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

