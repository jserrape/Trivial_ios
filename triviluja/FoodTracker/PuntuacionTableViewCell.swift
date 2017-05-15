//
//  PuntuacionTableViewCell.swift
//  triviluja
//
//  Created by jcsp0003 on 20/04/2017.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit

class PuntuacionTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var fechaLabel: UILabel!
    @IBOutlet weak var puntosLabel: UILabel!
    @IBOutlet weak var aciertosLabel: UILabel!
    @IBOutlet weak var numeroLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
