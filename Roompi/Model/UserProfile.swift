//
//  SigninModel.swift
//  Roompi
//
//  Created by irwan on 03/02/21.
//
import Foundation

struct UserProfile: Codable {
    let userId: String
    let username: String
    let type: String
    let photo: String
    let gender: String
    let birthDate: String
    let token: String
}
