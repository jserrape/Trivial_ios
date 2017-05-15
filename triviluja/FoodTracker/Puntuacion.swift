//
//  Meal.swift
//  triviluja
//
//  Created by jcsp0003 on 20/04/2017.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import os.log

class Puntuacion: NSObject, NSCoding{
    
    //MARK: Types
    
    struct PropertyKey {
        static let fecha = "fecha"
        static let puntos = "puntos"
        static let aciertos = "aciertos"
    }
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("puntuaciones2")
    
    //MARK: Properties
    
    var fecha: String
    var puntos: Int
    var aciertos: Int
    
    //MARK: Initialization
    
    init?(fecha: String, puntos: Int, aciertos: Int) {
        
        // The name must not be empty
        guard !fecha.isEmpty else {
            return nil
        }
        
        // The rating must be between 0 and 5 inclusively
        guard (puntos >= 0) && (puntos <= 50000) else {
            return nil
        }
        
        // Initialize stored properties.
        self.fecha = fecha
        self.puntos = puntos
        self.aciertos = aciertos
    }
    
    override init() {
        self.fecha = ""
        self.puntos = 0
        self.aciertos = 0
    }
    
    static func > (left: Puntuacion, right: Puntuacion) -> Bool {
        return (left.puntos > right.puntos)
    }
    
    static func < (left: Puntuacion, right: Puntuacion) -> Bool {
        return (left.puntos < right.puntos)
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(fecha, forKey: PropertyKey.fecha)
        aCoder.encode(puntos, forKey: PropertyKey.puntos)
        aCoder.encode(aciertos, forKey: PropertyKey.aciertos)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let fecha = aDecoder.decodeObject(forKey: PropertyKey.fecha) as? String else {
            os_log("Unable to decode the name for a Puntuacion object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        let puntos = aDecoder.decodeInteger(forKey: PropertyKey.puntos)
        
        let aciertos = aDecoder.decodeInteger(forKey: PropertyKey.aciertos)
        
        // Must call designated initializer.
        self.init(fecha: fecha, puntos: puntos, aciertos: aciertos)
        
    }
}

