//
//  EmployeeModel.swift
//  Employee Directory
//
//  Created by Anujith on 28/05/22.
//

import Foundation
import CoreData

struct EmployeeModel: Codable {
    var phone: String?
    var username: String?
    var id: Int?
    var profileImage: String?
    var email, name: String?
    var company: CompanyData?
    var website: String?
    var address: AddressData?

    enum CodingKeys: String, CodingKey {
        case phone, username, id
        case profileImage = "profile_image"
        case email, name, company, website, address
    }
}

// MARK: - Address
struct AddressData: Codable {
    var city: String?
    var geo: Geo?
    var suite, street, zipcode: String?
}

// MARK: - Geo
struct Geo: Codable {
    var lng, lat: String?
}

// MARK: - Company
struct CompanyData: Codable {
    var name, catchPhrase, bs: String?
}

