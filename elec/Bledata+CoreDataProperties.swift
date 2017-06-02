//
//  Bledata+CoreDataProperties.swift
//  elec
//
//  Created by user on 9/2/17.
//  Copyright © 2017 user. All rights reserved.
//

import Foundation
import CoreData


extension Bledata {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bledata> {
        return NSFetchRequest<Bledata>(entityName: "Bledata");
    }

    @NSManaged public var uuidcore: String?

}
