//
//  DataStructure.swift
//  interview_prac
//
//  Created by Alexhu on 2019/4/23.
//  Copyright © 2019 Alexhu. All rights reserved.
//

import Foundation

struct Drama: Codable {
    var drama_id: Int
    var name: String
    var total_views: Int
    var created_at: String
    var thumb: URL
    var rating: Double
}

struct DramaList: Codable {
    var data: [Drama]
}
