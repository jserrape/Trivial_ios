//
//  pregunta.swift
//  triviluja
//
//  Created by Macosx on 27/3/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import os.log

class Pregunta: NSObject, NSCoding{

    //MARK: Properties
    var enunciado: String
    var correcta: String
    var incorrecta1: String
    var incorrecta2: String
    var incorrecta3: String
    var photo: UIImage?
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("pregunta2")
    
    
    //MARK: Types
    struct PropertyKey {
        static let enunciado = "enunciado"
        static let correcta = "correcta"
        static let incorrecta1 = "incorrecta1"
        static let incorrecta2 = "incorrecta2"
        static let incorrecta3 = "incorrecta3"
        static let photo = "photo"
    }
    
    //MARK: Initialization
    
    init?(enunciado: String, correcta: String, incorrecta1: String, incorrecta2: String, incorrecta3: String, photo: UIImage?){
        
        guard !enunciado.isEmpty || !correcta.isEmpty || !incorrecta1.isEmpty || !incorrecta2.isEmpty || !incorrecta3.isEmpty else{
            return nil
        }
        
        self.enunciado = enunciado
        self.correcta = correcta
        self.incorrecta1 = incorrecta1				
        self.incorrecta2 = incorrecta2
        self.incorrecta3 = incorrecta3
        self.photo = photo
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(enunciado, forKey: PropertyKey.enunciado)
        aCoder.encode(correcta, forKey: PropertyKey.correcta)
        aCoder.encode(incorrecta1, forKey: PropertyKey.incorrecta1)
        aCoder.encode(incorrecta2, forKey: PropertyKey.incorrecta2)
        aCoder.encode(incorrecta3, forKey: PropertyKey.incorrecta3)
        aCoder.encode(photo, forKey: PropertyKey.photo)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // is required. If we cannot decode a name string, the initializer should fail.
        guard let enunciado = aDecoder.decodeObject(forKey: PropertyKey.enunciado) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let correcta = aDecoder.decodeObject(forKey: PropertyKey.correcta) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let incorrecta1 = aDecoder.decodeObject(forKey: PropertyKey.incorrecta1) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let incorrecta2 = aDecoder.decodeObject(forKey: PropertyKey.incorrecta2) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let incorrecta3 = aDecoder.decodeObject(forKey: PropertyKey.incorrecta3) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Pregunta, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        
        // Must call designated initializer.
        self.init(enunciado: enunciado, correcta: correcta, incorrecta1: incorrecta1, incorrecta2: incorrecta2, incorrecta3: incorrecta3, photo: photo )
    }

}
