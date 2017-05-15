//
//  Final.swift
//  triviluja
//
//  Created by Macosx on 17/4/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit

class Final: UIViewController {


    @IBOutlet weak var puntuacionLabel: UILabel!
    @IBOutlet weak var aciertosLabel: UILabel!
    @IBOutlet weak var fallosLabel: UILabel!
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var textoLabel: UILabel!
    @IBOutlet weak var imagenLabel: UIImageView!
    
    var puntos=""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cargarLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    private func cargarLabels(){
        var puntuaciones = [Puntuacion]()
        print(puntuaciones.count)
        
        if let savedPuntuaciones = cargarPuntuaciones() {
            puntuaciones = savedPuntuaciones
        }
        
        print(puntuaciones.count)
        
        let partida = puntuaciones[puntuaciones.count-1]
        
        var mayor = puntuaciones[0].puntos
        var z = 0
        while z < puntuaciones.count{
            if mayor < puntuaciones[z].puntos{
                mayor = puntuaciones[z].puntos
            }
            z += 1
        }
        puntos = String(describing: partida.puntos)
        puntuacionLabel.text = "Puntuacion: " + String(describing: partida.puntos)
        aciertosLabel.text = "Aciertos: " + String(describing: partida.aciertos)
        fallosLabel.text = "Fallos: " + String(describing: 7-partida.aciertos)
        recordLabel.text = "Record: " + String(mayor)
        
        if partida.puntos < 210{
            textoLabel.text = "MUY MAL JUGADO"
            imagenLabel.image = #imageLiteral(resourceName: "mal")
        }else if partida.puntos < 420{
            textoLabel.text = "¡BIEN HECHO!"
            imagenLabel.image = #imageLiteral(resourceName: "bien")
        }else{
            textoLabel.text = "¡EXCELENTE!"
            imagenLabel.image = #imageLiteral(resourceName: "excelente")
        }
        
    }
    
    // Funcion para twittear la puntuación obtenida en la última partida
    @IBAction func twitter(_ sender: UIButton) {
        let tweetText = "👍 He conseguido " + puntos + " puntos en TrivilUja :D 👍"
        
        let shareString = "https://twitter.com/intent/tweet?text=\(tweetText)"
        
        let escapedShareString = shareString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url = URL(string: escapedShareString)
        
        UIApplication.shared.openURL(url!)
    }
    
    private func cargarPuntuaciones() -> [Puntuacion]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Puntuacion.ArchiveURL.path) as? [Puntuacion]
    }
    
    

}
