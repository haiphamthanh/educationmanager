//
//  ImageServiceProtocol.swift
//  Angiang Education
//
//  Created by 7i3u7u on 10/15/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import UIKit

protocol ImageServiceProtocol {
	// Menu
	var logo: UIImage { get }
	
	// Menu
	var leftMenuIcon: UIImage { get }
	var rightMenuIcon: UIImage { get }
	
	// Intro
	var intros: [UIImage] { get }
	
	// Home
	var tabbars: [UIImage] { get }
	
	// User profile
	var avatar: UIImage { get }
}
