//
//  AuthViewModel.swift
//  Game Stream
//
//  Created by David Giron on 16/10/25.
//

import SwiftUI
import Combine

@MainActor
class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var userName = ""
    @Published var profileImage: UIImage?
    
    @Published var isLoggedIn = false
    @Published var loginError: String?
    @Published var currentUser: User?
    
    private let usersKey = "users"
    private let currentUserKey = "currentUser"
    
    init() {
        createDefaultUserIfNeeded()
        loadCurrentUser()
    }
    
    func login() {
        let users = getAllUsers()
        
        guard let user = users.first(where: { user in
            user.email == self.email && user.password == self.password
        })else{
            loginError = "Correo o contraseña incorrecta"
            print("Credenciales incorrectas")
            return
        }
        
        currentUser = user
        isLoggedIn = true
        UserDefaults.standard.set(user.email, forKey: currentUserKey)
        
        if let imageName = user.imageName {
            profileImage = ImageManager.loadImage(named: imageName)
        }
        
        resetFields()
        print("Inicio de sesión correcto.")
    }
    
    func logout() {
        
        resetFields()
        
        isLoggedIn = false
        profileImage = nil
        currentUser = nil
        UserDefaults.standard.removeObject(forKey: currentUserKey)
    }
    
    func register() {
        
        var isFormValid: Bool {
            let nameValid = !userName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            let emailValid = !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            let passwordValid = !password.isEmpty
            let confirmValid = !confirmPassword.isEmpty

            return nameValid && emailValid && passwordValid && confirmValid
        }
        
        guard isFormValid else {
            loginError = "Completa todos los campos obligatorios."
            return
        }
        guard password == confirmPassword else {
            loginError = "Las contraseñas no coinciden"
            return
        }
        
        var users = getAllUsers()
        
        guard !users.contains(where: { $0.email == self.email }) else {
            loginError = "El correo ya está registrado"
            print("El correo ya está registrado.")
            return
        }
        
        let userID = UUID()
        let imageName = "user_\(userID).jpg"
        
        if let image = profileImage {
            ImageManager.saveImage(image, withName: imageName)
        }
        
        let newUser = User(id: userID, username: userName, email: email, password: password, imageName: profileImage != nil ? imageName : nil)
        
        users.append(newUser)
        saveUsers(users)
        
        currentUser = newUser
        isLoggedIn = true
        UserDefaults.standard.set(newUser.email, forKey: currentUserKey)
        
        resetFields()
        print("Usuario registrado correctamente.")
    }
    
    func update() -> Bool {
        guard var user = currentUser else {
            loginError = "No hay usuario activo."
            return false
        }

        var users = getAllUsers()
        
        let trimmedName = userName.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedName.isEmpty {
            user.username = trimmedName
        }
    
        if !password.isEmpty || !confirmPassword.isEmpty {
            guard password == confirmPassword else {
                loginError = "Las contraseñas no coinciden."
                return false
            }
            user.password = password
        }
        
        if let image = profileImage {
            if let existingImageName = user.imageName {
                ImageManager.saveImage(image, withName: existingImageName)
            } else {
                let newImageName = "user_\(user.id).jpg"
                ImageManager.saveImage(image, withName: newImageName)
                user.imageName = newImageName
            }
        }
        
        if let index = users.firstIndex(where: { $0.id == user.id }) {
            users[index] = user
            saveUsers(users)
        }
        
        currentUser = user
        if let imageName = user.imageName {
            profileImage = ImageManager.loadImage(named: imageName)
        }
        
        resetFields()
        loginError = nil
        print("Usuario actualizado correctamente.")
        
        return true
    }
    
    func getUserProfileImage () -> Image? {
        if let imageName = currentUser?.imageName, let image = ImageManager.loadImage(named: imageName){
            return Image(uiImage: image)
        }
        return nil
    }

    private func resetFields () {
        email = ""
        password = ""
        confirmPassword = ""
        userName = ""
        loginError = nil
    }
    
    //Auxiliary Funcs
    
    //UserDefaults
    
    private func getAllUsers() -> [User] {
        guard let data = UserDefaults.standard.data(forKey: usersKey) else {
            return []
        }
        let decoder = JSONDecoder()
        guard let users = try? decoder.decode([User].self, from: data) else {
            return []
        }
        return users
    }
    
    private func saveUsers(_ users: [User]) {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(users) else { return }
        UserDefaults.standard.set(data, forKey: usersKey)
    }
    
    private func loadCurrentUser() {
        guard let email = UserDefaults.standard.string(forKey: currentUserKey) else { return }
        let users = getAllUsers()
        if let user = users.first(where: { $0.email == email }) {
            currentUser = user
            isLoggedIn = true
            if let imageName = user.imageName {
                profileImage = ImageManager.loadImage(named: imageName)
            }
        }
    }
    
    private func createDefaultUserIfNeeded() {
        var users = getAllUsers()
        guard users.isEmpty else { return }

        let defaultUser = User(
            id: UUID(),
            username: "admin",
            email: "Admin",
            password: "admin",
            imageName: nil
        )
        
        users.append(defaultUser)
        saveUsers(users)
    }
}
