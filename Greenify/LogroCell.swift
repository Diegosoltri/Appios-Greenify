//
//  LogroCell.swift
//  Greenify
//
//  Created by Diego Soltri on 10/11/24.
//

import UIKit

class LogroCell: UITableViewCell {
    
    @IBOutlet weak var logroImageView: UIImageView!
    @IBOutlet weak var progresoView: UIProgressView!
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var estrellasLabel: UILabel!
    
    
    func configurarCon(logro: Logro) {
        // Imprimir el logro recibido para ver si contiene datos correctos
        print("Configurando celda con logro:")
        print("Título: \(logro.titulo)")
        print("Estrellas actuales: \(logro.estrellasActuales)")
        print("Estrellas requeridas: \(logro.estrellasRequeridas)")
        print("Nombre de imagen: \(logro.imagenNombre)")

        // Configuración del título del logro
        tituloLabel?.text = logro.titulo

        // Configuración de las estrellas (actuales / requeridas)
        estrellasLabel?.text = "\(logro.estrellasActuales) / \(logro.estrellasRequeridas)"
        print("Estrellas label configurada con: \(estrellasLabel?.text ?? "")")

        // Configurar la imagen del logro
        if let imagen = logro.obtenerImagen() {
            logroImageView?.image = imagen
            print("Imagen configurada correctamente.")
        } else {
            print("Error: La imagen no se pudo cargar para \(logro.imagenNombre).")
        }

        // Calcular el progreso (0 a 1) para el UIProgressView
        let progreso = Float(logro.estrellasActuales) / Float(logro.estrellasRequeridas)
        progresoView?.progress = progreso
        print("Progreso configurado en: \(progreso)")

        // Opcional: cambiar el color de `UIProgressView` cuando esté completo
        progresoView?.progressTintColor = logro.estaDesbloqueado ? .green : .systemBlue
        print("Color de progreso configurado en: \(progresoView?.progressTintColor?.description ?? "default")")
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
