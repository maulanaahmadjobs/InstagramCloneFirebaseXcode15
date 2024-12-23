//
//  ViewController.swift
//  InstagramCloneFirebaseXcode15
//
//  Created by west on 30/09/24.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController, UITextFieldDelegate {
//    passwordText = SecureTextField()
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailText.delegate = self
        self.passwordText.delegate = self
        
        passwordText.isSecureTextEntry = true // Menambahkan kode ini hanya menerima paste
        passwordText.autocorrectionType = .no
        
    }
    
//    // Metode untuk menonaktifkan menu copy-paste
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        // Hanya untuk passwordText
//        if textField == passwordText {
//            // Nonaktifkan paste
//            UIPasteboard.general.string = nil
//        }
//        
//        return true
//    }
    
    // Kosongkan clipboard saat passwordText mulai diedit
    // Non-active paste atau yang tampil hanya autofill
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.passwordText {
            UIPasteboard.general.string = nil // Kosongkan clipboard
        }
    }
    
//    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
//        // Nonaktifkan menu copy, paste, cut, dll pada password field
////        if passwordText.isFirstResponder {
////            return false
////        }
//        if action == #selector(paste(_:)) && passwordText.isFirstResponder {
//            // Kosongkan clipboard dan nonaktifkan paste
//            UIPasteboard.general.string = nil
//            return false
//        }
//        return super.canPerformAction(action, withSender: sender)
//
//    }

    @IBAction func signInClicked(_ sender: Any) {
        
//        performSegue(withIdentifier: "toFeedVC", sender: nil)
                
        if emailText.text != "" && passwordText.text != "" {
            
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (authdata, error) in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
            self.makeAlert(title: "Error", message: "Username/Password")
        }
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" {
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (authdata, error) in
                
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
            makeAlert(title: "Error", message: "Username/Password")
        }
    }
    
    func makeAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let oK = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(oK)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            print("viewWillAppear called")
            // Update UI or data before the view appears
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            print("viewDidAppear called")
            // Start tasks that require the view to be visible
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            print("viewWillDisappear called")
            // Save data or stop tasks before the view disappears
        }
        
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            print("viewDidDisappear called")
            // Cleanup tasks
        }
        
    
    // Memanfaatkan Lifecyle UIViewControll bukan lifecyle iOS
    // Setelah copy dari aplikasi lain kemudian buka kembali aplikasi saat ini dan paste di nonactifkan
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("viewWillLayoutSubviews called")
        
        // Cek apakah passwordTextField adalah first responder
        if passwordText.isFirstResponder {
            // Kosongkan clipboard hanya jika pengguna sedang mengetik di password field
            UIPasteboard.general.string = nil
        }
    }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            print("viewDidLayoutSubviews called")
            // Adjust layout after view layout
        }
        
        deinit {
            print("deinit called")
            // Clean up resources
        }
    
    
}

//class SecureTextField: UITextField {
//    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
//        return true // Nonactive copy paste
//    }
//    
//    override var gestureRecognizers: [UIGestureRecognizer]? {
//        return nil // Nonative selection
//    }
//    
//    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
//        return [] // Hilangkan selecsi text
//    }
//}

