//
//  ProfileViewController.swift
//  Fidelidade
//
//  Created by Juninho on 17/12/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var ivBackground: UIImageView!
    @IBOutlet weak var ivProfile: UIImageView!
    
    @IBOutlet weak var btnNewBank: UIButton!{
        didSet{
            self.btnNewBank.layer.borderColor = UIColor(red: (38/255), green: (47/255), blue: (143/255), alpha: 1.0).cgColor
        }
    }
    
    var profileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       // self.ivProfile.image =  UserDefaults.standard.(forKey: "TokenAcesso") ?? ""
    }
    
    @IBAction func upImage(_ sender: UIButton) {
        metodoFoto()
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func edit(_ sender: UIButton) {
    }
    
    
    //  RETIRAR MENU INFERIOR
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    //  RETIRAR MENU Superor
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func metodoFoto()  {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Câmera", style: .default , handler:{ (UIAlertAction)in
            
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = .camera
            self.present(picker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Galeria", style: .default , handler:{ (UIAlertAction)in
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler:{ (UIAlertAction)in
        }))
        self.present(alert, animated: true, completion: {
        })
    }
    
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var selectedImageFromPicker: UIImage?
        selectedImageFromPicker = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!
        
        if let selectedImage = selectedImageFromPicker {
            self.ivProfile.image = selectedImage
            self.ivBackground.image = selectedImage
            self.viewTop.backgroundColor = .white
            self.ivProfile.setRounded()
            
            // UserDefaults.standard.set(selectedImage, forKey: "imagem")
            
            self.profileViewModel.blurImageView(image: self.ivBackground)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    //Retorno quando cancelar a ação
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("canceled picker")
        dismiss(animated: true, completion: nil)
    }
    
}

