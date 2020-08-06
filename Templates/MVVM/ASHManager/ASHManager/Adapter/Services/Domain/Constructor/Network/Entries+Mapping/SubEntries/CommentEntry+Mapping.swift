//
//  CommentEntry+Mapping.swift
//  ASHManager
//
//  Created by KhoaLA on 5/31/18.
//  Copyright © 2018 Asahi. All rights reserved.
//

import ObjectMapper

extension CommentEntry: ImmutableMappable {
	init(map: Map) throws {
		comment = try map.value("comment")
		ownerId = try map.value("owner_id")
		articleId = try map.value("article_id")
		status = try map.value("status")
		createAt = try map.value("created_at")
		owner_name = (try? map.value("owner_name")) ?? ""
		avatar = try map.value("avatar")
	}
	
	func toData() -> CommentData {
		return CommentData(comment: comment,
						   ownerId: ownerId,
						   articleId: articleId,
						   status: status,
						   createAt: createAt,
						   owner_name: owner_name,
						   avatar: avatar)
	}
}
