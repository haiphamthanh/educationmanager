//
//  AppColor.swift
//  ASHManager
//
//  Created by PhanDuyHai on 12/22/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

import UIColor_Hex_Swift

struct AppColor {
	static let primary: String = "#F5891F"
	static let loginButtonBackgorund: String = "#F1F2F2"
	static let registerButtonBackground: String = "#414042"
	static let currentPageControlColor: String = "#414042"
	static let pageControllColor: String = "#BCBEC0"
	static let collectionViewBackground: String = "#E9E9E9"
	static let descriptionTextColor: String = "#F45b73"
	static let titleColor: String = "#F23654"
	static let appTintColor: String = "#F57E2A"
	static let distanceTextColor: String = "#C7C7C7"
	static let deadlineTextColor: String = "#C7C7C7"
	static let rewardPointTextColor: String = "#C7C7C7"
	static let personJoinedTextColor: String = "#C7C7C7"
	static let winnerTextColor: String = "#C7C7C7"
	static let buttonMorTextColor: String = "#BABABA"
	static let personJoinedNumberColor: String = "#70AD47"
	static let appRedColor: String = "#FF0000"
	static let appBlueColor: String = "#0000FF"
	static let appWhiteColor: String = "#FFFFFF"
	static let appBlackColor: String = "#000000"
	static let appPinkyColor: String = "#EE305E"
	static let appZeroColor: String = "#D8D8D8"
	static let appFullfillColor: String = "#0800FF"
	static let appGrayColor: String = "#D2D2D2"
	static let appHeaderRewardHistory: String = "#FF6566"
	static let appNavigationBarColor: String = "#F2F2F2"
}

/** Get color with hex */
extension UIColor {
	static func colorWithHex(_ hex: String) -> UIColor {
		return UIColor(hex)
	}
}
