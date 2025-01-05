//
//  AuthService.swift
//  mobile-application-for-students
//
//  Created by Егорио on 23.12.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthService {
    
    static let shared = AuthService()
    
    private let db = Firestore.firestore()
    private let userDefaults = UserDefaults.standard
    
    private init() {}
    
    // MARK: - User Authentication
    
    public func signIn(with userRequest: LoginUserRequest, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: userRequest.email, password: userRequest.password) { result, error in
            if let error = error {
                completion(error)
                return
            }
            
            // Сохраняем UID после успешного входа
            if let uid = result?.user.uid {
                self.saveUserUIDToLocal(uid)
            }
            
            completion(nil)
        }
    }
    
    public func signUp(with userRequest: RegisterUserRequest, completion: @escaping (Bool, Error?) -> Void) {
        
        let name = userRequest.name
        let surname = userRequest.surname
        let email = userRequest.email
        let password = userRequest.password
        let role = userRequest.role
        let instrument = userRequest.instrument
        let secondInstrument = userRequest.secondInstrument
        let currentStage = userRequest.currentStage
        let currentLesson = userRequest.currentLesson
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(false, error)
                return
            }
            
            guard let resultUser = result?.user else {
                completion(false, nil)
                return
            }
            
            self.db.collection("users")
                .document(resultUser.uid)
                .setData([
                    "name": name,
                    "surname": surname,
                    "email": email,
                    "password": password,
                    "role": role,
                    "instrument": instrument,
                    "secondInstrument": secondInstrument ?? "",
                    "currentStage": currentStage ?? 0,
                    "currentLesson": currentLesson ?? 0
                ]) { error in
                    if let error = error {
                        completion(false, error)
                        return
                    }
                    completion(true, nil)
                }
            
        }
        
    }
    
    public func signOut(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            
            // Очищаем локальные данные при разлогине
            clearUserDataFromLocal()
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
    
    // MARK: - User Data Fetching
    
    public func fetchAndUpdateUserNameIfNeeded(completion: @escaping (Result<String, Error>) -> Void) {
        guard let currentUID = Auth.auth().currentUser?.uid else {
            completion(.failure(NSError(domain: "AuthService", code: 401, userInfo: [NSLocalizedDescriptionKey: "User is not logged in."])))
            return
        }
        
        // Проверяем, совпадает ли сохраненный UID с текущим
        if let savedUID = getSavedUserUID(), savedUID == currentUID {
            // Если UID совпадает, возвращаем сохраненное имя
            if let savedName = userDefaults.string(forKey: "UserName") {
                completion(.success(savedName))
                return
            }
        }
        
        // Если UID не совпадает или имени нет, загружаем данные из Firebase
        fetchUserName { [weak self] result in
            switch result {
            case .success(let name):
                self?.saveUserUIDToLocal(currentUID)
                self?.userDefaults.setValue(name, forKey: "UserName")
                completion(.success(name))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func fetchUserName(completion: @escaping (Result<String, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(.failure(NSError(domain: "AuthService", code: 401, userInfo: [NSLocalizedDescriptionKey: "User is not logged in."])))
            return
        }
        
        db.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let snapshot = snapshot, snapshot.exists, let data = snapshot.data(),
                  let name = data["name"] as? String else {
                completion(.failure(NSError(domain: "AuthService", code: 404, userInfo: [NSLocalizedDescriptionKey: "User document or name field not found."])))
                return
            }
            
            completion(.success(name))
        }
    }
    
    public func fetchUserRole(completion: @escaping (Result<String, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(.failure(NSError(domain: "AuthService", code: 401, userInfo: [NSLocalizedDescriptionKey: "User is not logged in."])))
            return
        }
        
        db.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let snapshot = snapshot, snapshot.exists, let data = snapshot.data(),
                  let role = data["role"] as? String else {
                completion(.failure(NSError(domain: "AuthService", code: 404, userInfo: [NSLocalizedDescriptionKey: "User document or name field not found."])))
                return
            }
            
            completion(.success(role))
        }
    }
    
    // MARK: - Local Storage Management
    
    private func saveUserUIDToLocal(_ uid: String) {
        userDefaults.setValue(uid, forKey: "CurrentUserUID")
    }
    
    private func getSavedUserUID() -> String? {
        return userDefaults.string(forKey: "CurrentUserUID")
    }
    
    private func clearUserDataFromLocal() {
        userDefaults.removeObject(forKey: "CurrentUserUID")
        userDefaults.removeObject(forKey: "UserName")
    }
}
