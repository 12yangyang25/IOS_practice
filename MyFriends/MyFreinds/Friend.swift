//
//  Friend.swift
//  MyFreinds
//
//  Created by 양가연 on 2023/02/02.
//


import Foundation

//{
//    "name":"하나",
//    "age":22,
//    "address_info": {
//        "country":"대한민국",
//        "city":"울산"
//    }
//}

struct Address:Codable{
    let country: String
    let city: String
}

struct Friend:Codable {
    
    let name: String
    let age: Int
    let addressInfo:Address
    
    var nameAndAge: String{
        return self.name + "\(self.age)"
    }
    var fullAddress: String{
        return addressInfo.city + ", " + addressInfo.country
    }
    enum CodingKeys:String, CodingKey{
        case name, age
        case addressInfo = "address_info"
    }
    
}
