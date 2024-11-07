//
//  CarrucelCollectionViewCell.swift
//  Greenify
//
//  Created by Diego Soltri on 21/10/24.
//

import UIKit

// Protocolo para notificar al delegado sobre la selección del botón
protocol CarrucelCollectionViewCellDelegate: AnyObject {
    func didTapButton(with actividad: Actividades)
}

class CarrucelCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var buttonView: UIButton!
    weak var delegate: CarrucelCollectionViewCellDelegate? // Delegado para notificar la selección
    private var actividad: Actividades? // Almacena la actividad actual
    
    static var lastSelectedCell: CarrucelCollectionViewCell? // Referencia estática a la última celda seleccionada
    
    override func awakeFromNib() {
            super.awakeFromNib()
            setupButton()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // Restablecer la apariencia cada vez que se reutilice la celda
        resetButtonAppearance()
    }
    
    private func setupButton() {
        buttonView.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside) // Detectar cuando se toca
        styleButton(isSelected: false)
        buttonView.backgroundColor = UIColor(red: 243/255, green: 255/255, blue: 144/255, alpha: 1) // Fondo original
        buttonView.setTitleColor(UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1), for: .normal) // Texto original
        buttonView.layer.cornerRadius = 10 // Ajusta el radio de los bordes redondeados
        buttonView.layer.masksToBounds = true // Asegúrate de que los bordes se recorten
        buttonView.clipsToBounds = true // Recorta el contenido fuera de los bordes redondeados
        buttonView.tintColor = UIColor.clear // Evita el color azul
           
    }
    
    func setup(with actividades: Actividades) {
        self.actividad = actividades
        buttonView.setTitle(actividades.tittle, for: .normal)
        resetButtonAppearance() // Restablecer la apariencia del botón al estado original cuando no está seleccionado
    }
    
    @objc private func buttonTapped() {
        CarrucelCollectionViewCell.lastSelectedCell?.resetButtonAppearance() // Restablecer la última celda seleccionada
        CarrucelCollectionViewCell.lastSelectedCell = self // Actualizar la referencia a la celda actual
        styleButton(isSelected: true) // Establecer estilo de selección
        // NoTIFICAR EL DELEGADO SOBRE LA ACTIVIDAD SELECCIONADA
        if let actividad = actividad {
            delegate?.didTapButton(with: actividad)
        }
    }
    
    // Actualizar el estilo del botón según su estado de selección
    private func styleButton(isSelected: Bool) {
        buttonView.isSelected = isSelected
        if isSelected {
            buttonView.layer.backgroundColor = UIColor(red: 5/255, green: 146/255, blue: 18/255, alpha: 1).cgColor
            buttonView.setTitleColor(.white, for: .normal)
            buttonView.setTitleColor(.white, for: .selected)
            buttonView.setTitleColor(.white, for: .highlighted)
            buttonView.setTitleColor(.white, for: .disabled)
        } else {
            let originalTextColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
            buttonView.layer.backgroundColor = UIColor(red: 243/255, green: 255/255, blue: 144/255, alpha: 1).cgColor
            buttonView.setTitleColor(originalTextColor, for: .normal)
            buttonView.setTitleColor(originalTextColor, for: .selected)
            buttonView.setTitleColor(originalTextColor, for: .highlighted)
            buttonView.setTitleColor(originalTextColor, for: .disabled)
        }
        
        // Forzar el redibujado del botón
        buttonView.setNeedsLayout()
        buttonView.layoutIfNeeded()
    }
    
    // Restablecer apariencia de la celda cuando no está seleccionada
    private func resetButtonAppearance() {
        styleButton(isSelected: false)
    }
    
}



