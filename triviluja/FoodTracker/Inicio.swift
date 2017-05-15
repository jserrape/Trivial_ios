//
//  Inicio.swift
//  triviluja
//
//  Created by Macosx on 24/4/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import os.log

class Inicio: UIViewController {
    
    var preguntas = [Pregunta]()

    override func viewDidLoad() {
        super.viewDidLoad()

        if loadPreguntas() == nil {
            loadSamplePreguntas()
            savePreguntas()
        }
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func loadSamplePreguntas(){
        
        let photo1 = UIImage(named: "and")
        let photo2 = UIImage(named: "rae")
        let photo3 = UIImage(named: "consola")
        let photo4 = UIImage(named: "guille")
        let photo5 = UIImage(named: "mongo")
        let photo6 = UIImage(named: "sf")
        let photo7 = UIImage(named: "bea")
        let photo8 = UIImage(named: "tierra")
        let photo9 = UIImage(named: "paella")
        
        
        
        guard let pregunta1 = Pregunta(enunciado: "¿Cual es el peor ssoo movil?", correcta: "ios", incorrecta1: "Android", incorrecta2: "Windows phone", incorrecta3: "BlackBerry", photo: photo1) else {
            fatalError("Unable to instantiate pregunta1")
        }
        
        guard let pregunta2 = Pregunta(enunciado: "Articulo masculino plural indeterminado?", correcta: "Unos", incorrecta1: "Unas", incorrecta2: "un", incorrecta3: "una", photo: photo2) else {
            fatalError("Unable to instantiate pregunta2")
        }
        
        guard let pregunta3 = Pregunta(enunciado: "¿Que marca no produce videoconsolas?", correcta: "Dell", incorrecta1: "Sony", incorrecta2: "Nintendo", incorrecta3: "Microsoft", photo: photo3) else {
            fatalError("Unable to instantiate pregunta3")
        }
        
        guard let pregunta4 = Pregunta(enunciado: "Dios representado en el Coloso de Rodas", correcta: "Helios", incorrecta1: "Jesus", incorrecta2: "Eos", incorrecta3: "Guillermo", photo: photo4) else {
            fatalError("Unable to instantiate pregunta4")
        }
        
        guard let pregunta5 = Pregunta(enunciado: "¿Que pais es este?", correcta: "Mongolia", incorrecta1: "Jaen", incorrecta2: "Rusia", incorrecta3: "China", photo: photo5) else {
            fatalError("Unable to instantiate pregunta5")
        }
        
        guard let pregunta6 = Pregunta(enunciado: "¿Que monumento es?", correcta: "La Sagrada Familia", incorrecta1: "La uja", incorrecta2: "Mordor", incorrecta3: "El coliseo", photo: photo6) else {
            fatalError("Unable to instantiate pregunta6")
        }
        
        guard let pregunta7 = Pregunta(enunciado: "101 ...", correcta: "Dalmata", incorrecta1: "Beagle", incorrecta2: "Gato", incorrecta3: "Salchichas", photo: photo7) else {
            fatalError("Unable to instantiate pregunta7")
        }
        
        guard let pregunta8 = Pregunta(enunciado: "Capa externa de la Tierra", correcta: "Corteza", incorrecta1: "Piel", incorrecta2: "Cascara", incorrecta3: "Monda", photo: photo8) else {
            fatalError("Unable to instantiate pregunta8")
        }
        
        guard let pregunta9 = Pregunta(enunciado: "De que pais es la paella", correcta: "España", incorrecta1: "Valencia", incorrecta2: "Mexico", incorrecta3: "Panama", photo: photo9) else {
            fatalError("Unable to instantiate pregunta0")
        }
        
        preguntas += [pregunta1, pregunta2, pregunta3, pregunta4, pregunta5, pregunta6, pregunta7, pregunta8, pregunta9]
        
    }
    
    
    private func savePreguntas() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(preguntas, toFile: Pregunta.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Preguntas successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save preguntas...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadPreguntas() -> [Pregunta]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Pregunta.ArchiveURL.path) as? [Pregunta]
    }


}
