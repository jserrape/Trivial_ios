//
//  PuntuacionTableViewController.swift
//  triviluja
//
//  Created by jcsp0003 on 20/04/2017.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit

class PuntuacionTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var puntuaciones = [Puntuacion]()
    var cont = 1

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let savedPreguntas = cargarPuntuaciones() {
            puntuaciones += savedPreguntas
        }
        
        var i = 0
        var aux = Puntuacion()
        while i < puntuaciones.count-1 {
            var j = 0
            while j < puntuaciones.count-i-1 {
                if puntuaciones[j+1] > puntuaciones[j]{
                    aux=puntuaciones[j+1];
                    puntuaciones[j+1]=puntuaciones[j];
                    puntuaciones[j]=aux;                }
                j+=1
            }
            i+=1
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
        return puntuaciones.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "PuntuacionTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PuntuacionTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let puntuacion = puntuaciones[indexPath.row]
        
        cell.fechaLabel.text = puntuacion.fecha
        cell.puntosLabel.text = String(puntuacion.puntos) + " Puntos"
        cell.aciertosLabel.text = String(puntuacion.aciertos) + " Aciertos"
        cell.numeroLabel.text = String(cont) + "º"
        
        
        if cont % 2 == 0{
            cell.backgroundColor = UIColor.brown
        }else{
            cell.backgroundColor = UIColor.cyan
        }
        
        cont+=1
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Private Methods
    
    private func loadSamplePuntuaciones() {
        
        let date = Date()
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "es_EC")
        
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        
        var fecha = ""
        fecha = dateFormatter.string(from: date)
        
        guard let p1 = Puntuacion(fecha: fecha, puntos: 400, aciertos: 3) else {
            fatalError("Unable to instantiate p1")
        }
        
        guard let p2 = Puntuacion(fecha: fecha, puntos: 0, aciertos: 0) else {
            fatalError("Unable to instantiate p1")
        }
        
        guard let p3 = Puntuacion(fecha: fecha, puntos: 500, aciertos: 5) else {
            fatalError("Unable to instantiate p1")
        }
        
        puntuaciones += [p1, p2, p3]
    }
    
    private func cargarPuntuaciones() -> [Puntuacion]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Puntuacion.ArchiveURL.path) as? [Puntuacion]
    }

}
