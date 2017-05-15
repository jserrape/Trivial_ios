//
//  ViewController.swift
//  FoodTracker
//
//  Created by Jane Appleseed on 10/17/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Navigation
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let enunciado = nameTextField.text ?? ""
        let correcta = correctaTextField.text ?? ""
        let incorrecta1 = incorrecta1TextField.text ?? ""
        let incorrecta2 = incorrecta2TextField.text ?? ""
        let incorrecta3 = incorrecta3TextField.text ?? ""
        let photo = photoImageView.image
        
        // Set the meal to be passed to preguntaTableViewController after the unwind segue.
        pregunta = Pregunta(enunciado:enunciado, correcta:correcta, incorrecta1:incorrecta1, incorrecta2:incorrecta2, incorrecta3:incorrecta3, photo: photo)
    }
    
    
    
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var incorrecta1TextField: UITextField!
    @IBOutlet weak var incorrecta2TextField: UITextField!
    @IBOutlet weak var incorrecta3TextField: UITextField!
    @IBOutlet weak var correctaTextField: UITextField!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
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
    
    
    /*
     This value is either passed by `preguntaTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new pregunta.
     */
    var pregunta: Pregunta?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
        correctaTextField.delegate = self
        incorrecta1TextField.delegate = self
        incorrecta2TextField.delegate = self
        incorrecta3TextField.delegate = self
        
        // Set up views if editing an existing Meal.
        if let pregunta = pregunta {
            navigationItem.title = pregunta.enunciado
            nameTextField.text   = pregunta.enunciado
            correctaTextField.text   = pregunta.correcta
            incorrecta1TextField.text   = pregunta.incorrecta1
            incorrecta2TextField.text   = pregunta.incorrecta2
            incorrecta3TextField.text   = pregunta.incorrecta3
            photoImageView.image = pregunta.photo

        }
        
        // Enable the Save button only if the text field has a valid Meal name.
        updateSaveButtonState()
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }

    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        // Hide the keyboard.
        //nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    //MARK: Private Methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let enun = nameTextField.text ?? ""
        let correc = correctaTextField.text ?? ""
        let incorrec1 = incorrecta1TextField.text ?? ""
        
        saveButton.isEnabled = !enun.isEmpty && !correc.isEmpty && !incorrec1.isEmpty
    }
}

