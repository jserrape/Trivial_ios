//
//  preguntaTableViewController.swift
//  triviluja
//
//  Created by Macosx on 3/4/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import os.log

class preguntaTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var preguntas = [Pregunta]()
    
    @IBAction func volver(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddPreguntaMode = presentingViewController is UINavigationController
        
        if isPresentingInAddPreguntaMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The ViewController is not inside a navigation controller.")
        }
    }
    //[0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load any saved meals, otherwise load sample data.
        if let savedPreguntas = loadPreguntas() {
            preguntas += savedPreguntas
        }else {
            // Load the sample data.
            loadSamplePreguntas()
            savePreguntas()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return preguntas.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "preguntaTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? preguntaTableViewCell  else {
            fatalError("The dequeued cell is not an instance of preguntaTableViewCell.")
        }
        
        // Fetches the appropriate pregunta for the data source layout.
        let pregunta = preguntas[indexPath.row]
        
        cell.enunciadoLabel.text = pregunta.enunciado
        
        
        return cell
    }
    
    
    
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
     }
    
    
    
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            preguntas.remove(at: indexPath.row)
            savePreguntas()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
     }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    ///*        
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new pregunta.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let pDetailViewController = segue.destination as? ViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMealCell = sender as? preguntaTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedP = preguntas[indexPath.row]
            pDetailViewController.pregunta = selectedP
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
     }
    
     //*/
    
    
    
    //MARK: Actions
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ViewController, let pregunta = sourceViewController.pregunta {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                preguntas[selectedIndexPath.row] = pregunta
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new pregunta.
                let newIndexPath = IndexPath(row: preguntas.count, section: 0)
                
                preguntas.append(pregunta)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            savePreguntas()
        }
    }
    
    
    
    //MARK: Private methods
    
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
