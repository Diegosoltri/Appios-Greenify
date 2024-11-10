//
//  SwiftUIView.swift
//  Greenify
// CODIGO PARA QR
//  Created by Diego Soltri on 08/11/24.
//

import SwiftUI
import CodeScanner
import AVFoundation

struct SwiftUIView: View {
    // Callback para manejar el código escaneado
    var completion: (String) -> Void

    var body: some View {
        CodeScannerView(
            codeTypes: [.qr],
            simulatedData: "Ejemplo QR Data",
            videoCaptureDevice: AVCaptureDevice.zoomedCameraForQRCode(withMinimumCodeSize: 20),
            completion: { result in
                switch result {
                case .success(let scanResult):
                    completion(scanResult.string) // Aquí usamos scanResult.string para extraer el valor String del resultado escaneado
                case .failure(let error):
                    print("Error al escanear el QR: \(error.localizedDescription)")
                }
            }
        )
    }
}


