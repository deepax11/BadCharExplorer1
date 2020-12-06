//
//  IteneriesResource.swift
//  DTOKit
//
//  Created by Deepak Shukla on 12/10/2020.
//  Copyright © 2020 Deepak Shukla. All rights reserved.
//

import Foundation
import NetworkKit

public struct BreakingBadCharacter: Codable {
    
    public let id: Int
    public let name: String
    public let birthday: Date?
    public let occupation: [String]
    public let imageUrl: String
    public let status: LifeStatus // status: "Alive", Deceased, Presumed dead

    public let nicName: String
    public let appearance: [Season]?
    public let portrayed: String
    public let category: String //category: "Breaking Bad, Better Call Saul",

    public let saulApearance: [Int]?
    
    enum CodingKeys: String, CodingKey { 
        case id = "char_id"
        case name
        case birthday
        case occupation
        case imageUrl = "img"
        case status
        case nicName = "nickname"
        case appearance
        case portrayed
        case category
        case saulApearance = "better_call_saul_appearance"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        birthday = try? container.decode(Date.self, forKey: .birthday)
        occupation = try container.decode([String].self, forKey: .occupation)
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
        status = try container.decode(LifeStatus.self, forKey: .status)
        nicName = try container.decode(String.self, forKey: .nicName)
        appearance = try? container.decode([Season].self, forKey: .appearance)
        portrayed = try container.decode(String.self, forKey: .nicName)
        category = try container.decode(String.self, forKey: .nicName)
        saulApearance = try? container.decode([Int].self, forKey: .saulApearance)
    }
}

public enum LifeStatus: String, Codable {
    case alive = "Alive"
    case deceased = "Deceased"
    case presumedDead = "Presumed dead"
    case unknown = "Unknown"
}


public enum Season: Int, Codable, CaseIterable {
    case none = 0
    case season1 = 1
    case season2 = 2
    case season3 = 3
    case season4 = 4
    case season5 = 5
}

