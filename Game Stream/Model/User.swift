//
//  User.swift
//  Game Stream
//
//  Created by David Giron on 18/10/25.
//

import Foundation

struct User: Codable, Identifiable {
    let id: UUID
    var username: String
    var email: String
    var password: String
    var imageName: String?
}
