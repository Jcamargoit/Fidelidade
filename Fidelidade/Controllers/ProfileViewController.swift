//  ProfileViewController.swift
//  Fidelidade
//
//  Created by Juninho on 17/12/21.

import UIKit
import Observable
import GoogleUtilities

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var ivBackground: UIImageView!
    @IBOutlet weak var ivProfile: UIImageView!
    @IBOutlet weak var viewNewBank: UIView!{
        didSet{
            self.viewNewBank.layer.borderColor = UIColor(red: (38/255), green: (47/255), blue: (143/255), alpha: 1.0).cgColor
        }
    }
    
    private var disposal = Disposal()
    
    private lazy var profileViewModel = ProfileViewModel()
    
    //mudar a cor do relógio
    var statusBarLightStyle = true {
        didSet(newValue) {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    var imagBase64 = ImagBase64()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observes()
        loadUserImage()
        //True Branco False Preto DidLoad
        self.statusBarLightStyle = true
    }
    
    //Metodo para mudar a cor do relógio - Fora do DidLoad
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.statusBarLightStyle ? .lightContent : .default
    }
    
    func loadUserImage() {
        if let imagem = UserDefaults.standard.string(forKey: UserDefaultsKeys.userImageProfile.rawValue){
            let image = imagBase64.convertBase64ToImage(imageString: imagem)
            self.ivProfile.image = image
            self.ivBackground.image = image
            self.profileViewModel.blurImageView(image: self.ivBackground)
            self.ivProfile.setRounded()
        }
    }
    
    func observes() {
        profileViewModel.logoutIsFinished.observe(DispatchQueue.main) { [weak self] result, oldValue in
            guard let result = result else{
                return
            }
            if result {
                self?.performSegue(withIdentifier: "openChoiseFromMyAccount", sender: self)
            }else{
                self?.simplePopUp(title: "Atenção", mensage: "Não foi possível deslogar")
            }
        }.add(to: &disposal)
    }
    
    @IBAction func upImage(_ sender: UIButton) {
        metodoFoto()
    }
    
    
    @IBAction func tappedBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func tappedEdit(_ sender: UIButton) {
    }
    
    @IBAction func tappedLogout(_ sender: UIButton) {
        profileViewModel.handleLogout()
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
            
            UserDefaults.standard.set(imagBase64.convertImageToBase64(image: selectedImage), forKey: UserDefaultsKeys.userImageProfile.rawValue)
            
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
