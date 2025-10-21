//
//  SaveData.swift
//  Game Stream
//
//  Created by David Giron on 14/10/25.
//

import SwiftUI

class SaveData {
    var correo: String = ""
    var contrasena: String = ""
    var nombre: String = ""
    
    func saveData(correo: String, contrasena: String, nombre: String) -> Bool {
        print("Dentro de la función guardar datos obtube: \(correo) + \(contrasena) + \(nombre)")
        
        //Guardar datos pequeños
        UserDefaults.standard.set([correo, contrasena, nombre], forKey: "userData")
        
        return true
    }
    
    func getData() -> [String] {
        let userData: [String] = UserDefaults.standard.stringArray(forKey: "userData") ?? []
        print("Estoy en el metodo recuperarDatos y recupere: \(userData)")
        return userData
    }
    
    func validate(correo: String, contrasena: String) -> Bool {
        var correoGuardado = ""
        var contrasenaGuardado = ""
        
        print("Revisando si tengo datos en user defaults con el correo \(correo) y la contraseña \(contrasena)")
        
        let userData = getData()
        if !userData.isEmpty {
            correoGuardado = userData[0]
            contrasenaGuardado = userData[1]
            if correo == correoGuardado && contrasena == contrasenaGuardado {
                return true
            }else{
                print("Correo o contraseña incorrectos")
                return false
            }
        }else{
            print("No hay datos de usuario guardados en el user defaults")
            return false
        }
    }
}
