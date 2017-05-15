//
//  Juego.swift
//  triviluja
//
//  Created by jcsp0003 on 13/04/2017.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import os.log
import AVFoundation

class Juego: UIViewController {
    
    //MARK: Properties
    //  ()
    //  []
    //  = ""
    // {}
    
    var soundError = AVAudioPlayer()
    var soundCorrecta = AVAudioPlayer()
    
    var pulsarBoton = true
    var preguntaCorrecta = -1
    var segundos = 30
    var timer = Timer()
    var puntosC = 0
    var nPregunta = -1
    var contPregunta = 1
    
    var aciertos = 0
    
    var siguiente = Timer()
    var realizadas = [String]()
    
    @IBOutlet weak var progreso: UIProgressView!
    @IBOutlet weak var tiempo: UILabel!
    @IBOutlet weak var puntos: UILabel!
    @IBOutlet weak var nPreguntaText: UILabel!
    
    
    @IBOutlet weak var enunciadoText: UITextView!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var boton1: UIButton!
    @IBOutlet weak var boton2: UIButton!
    @IBOutlet weak var boton3: UIButton!
    @IBOutlet weak var boton4: UIButton!
    
    @IBAction func accionBoton1(_ sender: UIButton) {
        timer.invalidate()
        if pulsarBoton == true {
            pulsarBoton = false
            if preguntaCorrecta == 1 {
                soundCorrecta.play()
                boton1.backgroundColor = UIColor.green
                puntosC += segundos*3
                puntos.text = String(puntosC)
                aciertos += 1
            } else {
                soundError.play()
                boton1.backgroundColor = UIColor.red
            
                if preguntaCorrecta == 2 {
                    boton2.backgroundColor = UIColor.green
                } else {
                    if preguntaCorrecta == 3 {
                        boton3.backgroundColor = UIColor.green
                    } else {
                        boton4.backgroundColor = UIColor.green
                    }
                }
            }
            siguiente = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(Juego.comprobacion), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func accionBoton2(_ sender: UIButton) {
        timer.invalidate()
        if pulsarBoton == true {
            pulsarBoton = false
            if preguntaCorrecta == 2 {
                soundCorrecta.play()
                boton2.backgroundColor = UIColor.green
                puntosC += segundos*3
                puntos.text = String(puntosC)
                aciertos += 1
            } else {
                soundError.play()
                boton2.backgroundColor = UIColor.red
            
                if preguntaCorrecta == 1 {
                    boton1.backgroundColor = UIColor.green
                } else {
                    if preguntaCorrecta == 3 {
                        boton3.backgroundColor = UIColor.green
                    } else {
                        boton4.backgroundColor = UIColor.green
                    }
                }
            }
            siguiente = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(Juego.comprobacion), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func accionBoton3(_ sender: UIButton) {
        timer.invalidate()
        if pulsarBoton == true {
            pulsarBoton = false
            if preguntaCorrecta == 3 {
                soundCorrecta.play()
                boton3.backgroundColor = UIColor.green
                puntosC += segundos*3
                puntos.text = String(puntosC)
                aciertos += 1
            } else {
                soundError.play()
                boton3.backgroundColor = UIColor.red
            
                if preguntaCorrecta == 1 {
                    boton1.backgroundColor = UIColor.green
                } else {
                    if preguntaCorrecta == 2 {
                        boton2.backgroundColor = UIColor.green
                    } else {
                        boton4.backgroundColor = UIColor.green
                    }
                }
            }
            siguiente = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(Juego.comprobacion), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func accionBoton4(_ sender: UIButton) {
        timer.invalidate()
        if pulsarBoton == true {
            pulsarBoton = false
            if preguntaCorrecta == 4 {
                soundCorrecta.play()
                boton4.backgroundColor = UIColor.green
                puntosC += segundos*3
                puntos.text = String(puntosC)
                aciertos += 1
            } else {
                soundError.play()
                boton4.backgroundColor = UIColor.red
            
                if preguntaCorrecta == 1 {
                    boton1.backgroundColor = UIColor.green
                } else {
                    if preguntaCorrecta == 2 {
                        boton2.backgroundColor = UIColor.green
                    } else {
                        boton3.backgroundColor = UIColor.green
                    }
                }
            }
            siguiente = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(Juego.comprobacion), userInfo: nil, repeats: true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            soundError = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "error", ofType: "mp3")!))
            soundCorrecta = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "correct", ofType: "mp3")!))
            soundError.prepareToPlay()
            soundCorrecta.prepareToPlay()
        }catch{
            print(error)
        }
        
        progreso.progressTintColor = UIColor.blue
        
        if let savedPreguntas = loadPreguntas() {
            let nPregunta = Int(arc4random_uniform((UInt32(savedPreguntas.count))))
            realizadas.append(savedPreguntas[nPregunta].enunciado)
            print(savedPreguntas[nPregunta].enunciado)
            
            var posiciones = [1, 2, 3, 4]
            let pos1 = posiciones.remove(at: Int(arc4random_uniform((UInt32(posiciones.count)))))
            preguntaCorrecta = pos1
            let pos2 = posiciones.remove(at: Int(arc4random_uniform((UInt32(posiciones.count)))))
            let pos3 = posiciones.remove(at: Int(arc4random_uniform((UInt32(posiciones.count)))))
            let pos4 = posiciones.remove(at: Int(arc4random_uniform((UInt32(posiciones.count)))))
            
            enunciadoText.text = savedPreguntas[nPregunta].enunciado
            enunciadoText.textAlignment = .center
            
            photo.image = savedPreguntas[nPregunta].photo
            
            //VOY A COLOCAR LA RESPUESTA CORRECTA
            switch pos1 {
            case 1:
                boton1.setTitle(savedPreguntas[nPregunta].correcta, for: .normal)
            case 2:
                boton2.setTitle(savedPreguntas[nPregunta].correcta, for: .normal)
            case 3:
                boton3.setTitle(savedPreguntas[nPregunta].correcta, for: .normal)
            case 4:
                boton4.setTitle(savedPreguntas[nPregunta].correcta, for: .normal)
            default:
                print("DEEEEEP")
            }
            
            
            //VOY A COLOCAR LA RESPUESTA INCORRECTA1
            switch pos2 {
            case 1:
                boton1.setTitle(savedPreguntas[nPregunta].incorrecta1, for: .normal)
            case 2:
                boton2.setTitle(savedPreguntas[nPregunta].incorrecta1, for: .normal)
            case 3:
                boton3.setTitle(savedPreguntas[nPregunta].incorrecta1, for: .normal)
            case 4:
                boton4.setTitle(savedPreguntas[nPregunta].incorrecta1, for: .normal)
            default:
                print("DEEEEEP")
            }
            
            
            //VOY A COLOCAR LA RESPUESTA INCORRECTA2
            switch pos3 {
            case 1:
                boton1.setTitle(savedPreguntas[nPregunta].incorrecta2, for: .normal)
            case 2:
                boton2.setTitle(savedPreguntas[nPregunta].incorrecta2, for: .normal)
            case 3:
                boton3.setTitle(savedPreguntas[nPregunta].incorrecta2, for: .normal)
            case 4:
                boton4.setTitle(savedPreguntas[nPregunta].incorrecta2, for: .normal)
            default:
                print("DEEEEEP")
            }
            
            //VOY A COLOCAR LA RESPUESTA INCORRECTA3
            switch pos4 {
            case 1:
                boton1.setTitle(savedPreguntas[nPregunta].incorrecta3, for: .normal)
            case 2:
                boton2.setTitle(savedPreguntas[nPregunta].incorrecta3, for: .normal)
            case 3:
                boton3.setTitle(savedPreguntas[nPregunta].incorrecta3, for: .normal)
            case 4:
                boton4.setTitle(savedPreguntas[nPregunta].incorrecta3, for: .normal)
            default:
                print("DEEEEEP")
            }
            
            //EMPIEZA EL TIEMPO
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Juego.counter), userInfo: nil, repeats: true)
            
            //PONER LA PUNTUACION
            puntos.text=String(puntosC)
            
            //PONGO EL COLOR A LOS BOTONES
            boton1.backgroundColor = UIColor.yellow
            boton2.backgroundColor = UIColor.yellow
            boton3.backgroundColor = UIColor.yellow
            boton4.backgroundColor = UIColor.yellow
            
            nPreguntaText.text = String(contPregunta)+"/7"
        }else {
            // Load the sample data.
            //loadSamplePreguntas()
        }
    }
    
    func counter(){
        segundos -= 1
        tiempo.text = String(segundos)
        
        let progresoo = (100.0 * Float(segundos) / 30.0) / 100.0

        let animated = progresoo != 0
        progreso.setProgress(progresoo, animated: animated)
        
        
        if (segundos == 10 ){
            progreso.progressTintColor = UIColor.red
        }
        
        if (segundos == 0 ){
            soundError.play()
            timer.invalidate()
            pulsarBoton = false
            if preguntaCorrecta == 1 {
                boton1.backgroundColor = UIColor.red
            } else {
                if preguntaCorrecta == 2 {
                    boton2.backgroundColor = UIColor.red
                } else {
                    if preguntaCorrecta == 3 {
                        boton3.backgroundColor = UIColor.red
                    } else {
                        boton4.backgroundColor = UIColor.red
                    }
                }
            }
            siguiente = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(Juego.comprobacion), userInfo: nil, repeats: true)
        }
    }
    
    func comprobacion(){
        siguiente.invalidate()
        if(contPregunta == 7 ){
            guardarPuntuaciones()
            
            soundError.stop()
            soundCorrecta.stop()
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let miVistaDos = storyBoard.instantiateViewController(withIdentifier: "Final") as! Final
            self.present(miVistaDos, animated:true, completion:nil)
        }else{
            reinicio()
        }
    }
    
    
    func reinicio(){
        pulsarBoton = true
        preguntaCorrecta = -1
        segundos = 30
        timer = Timer()
        contPregunta += 1
        progreso.progressTintColor = UIColor.blue
        
        //PONGO EL COLOR A LOS BOTONES
        boton1.backgroundColor = UIColor.yellow
        boton2.backgroundColor = UIColor.yellow
        boton3.backgroundColor = UIColor.yellow
        boton4.backgroundColor = UIColor.yellow
        
        //CARGO LA PREGUNTA
        if var savedPreguntas = loadPreguntas() {
            var nPregunta = Int(arc4random_uniform((UInt32(savedPreguntas.count))))
            var sigo = true
            while sigo {
                if(realizadas.contains(savedPreguntas[nPregunta].enunciado)){
                    savedPreguntas.remove(at: nPregunta)
                    nPregunta = Int(arc4random_uniform((UInt32(savedPreguntas.count))))
                }else{
                    sigo = false
                }
            }
            print(savedPreguntas[nPregunta].enunciado)
            
            realizadas.append(savedPreguntas[nPregunta].enunciado)
            
            var posiciones = [1, 2, 3, 4]
            let pos1 = posiciones.remove(at: Int(arc4random_uniform((UInt32(posiciones.count)))))
            preguntaCorrecta = pos1
            let pos2 = posiciones.remove(at: Int(arc4random_uniform((UInt32(posiciones.count)))))
            let pos3 = posiciones.remove(at: Int(arc4random_uniform((UInt32(posiciones.count)))))
            let pos4 = posiciones.remove(at: Int(arc4random_uniform((UInt32(posiciones.count)))))
            
            enunciadoText.text = savedPreguntas[nPregunta].enunciado
            enunciadoText.textAlignment = .center
            
            photo.image = savedPreguntas[nPregunta].photo
            
            //VOY A COLOCAR LA RESPUESTA CORRECTA
            switch pos1 {
            case 1:
                boton1.setTitle(savedPreguntas[nPregunta].correcta, for: .normal)
            case 2:
                boton2.setTitle(savedPreguntas[nPregunta].correcta, for: .normal)
            case 3:
                boton3.setTitle(savedPreguntas[nPregunta].correcta, for: .normal)
            case 4:
                boton4.setTitle(savedPreguntas[nPregunta].correcta, for: .normal)
            default:
                print("DEEEEEP")
            }
            
            
            //VOY A COLOCAR LA RESPUESTA INCORRECTA1
            switch pos2 {
            case 1:
                boton1.setTitle(savedPreguntas[nPregunta].incorrecta1, for: .normal)
            case 2:
                boton2.setTitle(savedPreguntas[nPregunta].incorrecta1, for: .normal)
            case 3:
                boton3.setTitle(savedPreguntas[nPregunta].incorrecta1, for: .normal)
            case 4:
                boton4.setTitle(savedPreguntas[nPregunta].incorrecta1, for: .normal)
            default:
                print("DEEEEEP")
            }
            
            
            //VOY A COLOCAR LA RESPUESTA INCORRECTA2
            switch pos3 {
            case 1:
                boton1.setTitle(savedPreguntas[nPregunta].incorrecta2, for: .normal)
            case 2:
                boton2.setTitle(savedPreguntas[nPregunta].incorrecta2, for: .normal)
            case 3:
                boton3.setTitle(savedPreguntas[nPregunta].incorrecta2, for: .normal)
            case 4:
                boton4.setTitle(savedPreguntas[nPregunta].incorrecta2, for: .normal)
            default:
                print("DEEEEEP")
            }
            
            //VOY A COLOCAR LA RESPUESTA INCORRECTA3
            switch pos4 {
            case 1:
                boton1.setTitle(savedPreguntas[nPregunta].incorrecta3, for: .normal)
            case 2:
                boton2.setTitle(savedPreguntas[nPregunta].incorrecta3, for: .normal)
            case 3:
                boton3.setTitle(savedPreguntas[nPregunta].incorrecta3, for: .normal)
            case 4:
                boton4.setTitle(savedPreguntas[nPregunta].incorrecta3, for: .normal)
            default:
                print("DEEEEEP")
            }
            
            //EMPIEZA EL TIEMPO
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Juego.counter), userInfo: nil, repeats: true)
            
            //PONER LA PUNTUACION
            puntos.text=String(puntosC)
            
            //PONGO EL COLOR A LOS BOTONES
            boton1.backgroundColor = UIColor.yellow
            boton2.backgroundColor = UIColor.yellow
            boton3.backgroundColor = UIColor.yellow
            boton4.backgroundColor = UIColor.yellow
            
            nPreguntaText.text = String(contPregunta)+"/7"
        }else {
            // Load the sample data.
            //loadSamplePreguntas()
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    private func loadPreguntas() -> [Pregunta]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Pregunta.ArchiveURL.path) as? [Pregunta]
    }
    
    
    private func cargarPuntuaciones() -> [Puntuacion]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Puntuacion.ArchiveURL.path) as? [Puntuacion]
    }
    
    private func guardarPuntuaciones() {
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_EC")
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        var fecha = ""
        fecha = dateFormatter.string(from: date)
        
        
        var puntuaciones = [Puntuacion]()
        
        if let savedPuntuaciones = cargarPuntuaciones() {
            puntuaciones = savedPuntuaciones
        }
        
        guard let p = Puntuacion(fecha: fecha, puntos: puntosC, aciertos: aciertos) else {
            fatalError("Unable to instantiate p")
        }
        
        puntuaciones += [p]
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(puntuaciones, toFile: Puntuacion.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Puntuaciones successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save puntuaciones...", log: OSLog.default, type: .error)
        }
        
        print("CORRECTO")
    }

}
