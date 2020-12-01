//
//  IteneriesResource.swift
//  DTOKit
//
//  Created by Deepak Shukla on 12/10/2020.
//  Copyright © 2020 Deepak Shukla. All rights reserved.
//

import Foundation
import NetworkKit

public struct BadCharacter: Codable {
    public let id: Int
    public let name: String
    public let birthday: Date?
    public let occupation: [String]
    public let imageUrl: String
    public let status: String
    public let nicName: String
    public let appearance: [Int]?
    public let portrayed: String
    public let category: String
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
        status = try container.decode(String.self, forKey: .status)
        nicName = try container.decode(String.self, forKey: .nicName)
        appearance = try? container.decode([Int].self, forKey: .appearance)
        portrayed = try container.decode(String.self, forKey: .nicName)
        category = try container.decode(String.self, forKey: .nicName)
        saulApearance = try? container.decode([Int].self, forKey: .saulApearance)
    }
}
