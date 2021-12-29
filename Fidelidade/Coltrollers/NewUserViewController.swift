//
//  NewUserViewController.swift
//  Fidelidade
//
//  Created by Juninho on 15/12/21.
//

import UIKit

class NewUserViewController: UIViewController {
    
    @IBOutlet weak var tfNomeCompleto: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfCpf: UITextField!{
        didSet{
            self.tfCpf.delegate = self
        }
    }
    @IBOutlet weak var viewNext: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func next(_ sender: UIButton) {
        verificationTextField()
    }
    
    
    func verificationTextField(){
        if tfNomeCompleto.text!.isEmpty{
            simplePopUp(title: "", mensage: "É necessário digitar o nome completo")
        }else  if tfEmail.text!.isEmpty{
            simplePopUp(title: "", mensage: "É necessário digitar o e-mail")
        }else  if tfCpf.text!.isEmpty{
            simplePopUp(title: "", mensage: "Necessário digitar o cpf")
        }else{
            if tfCpf.text!.isValidCPF{
                self.performSegue(withIdentifier: "openNewUserTowFromNewUser", sender: self)
            }else{
                simplePopUp(title: "Atenção", mensage: "Por favor digite um CPF válido")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "openNewUserTowFromNewUser":
            let vc = segue.destination as! NewUserTwoViewController
            
            vc.nomeCompleto = self.tfNomeCompleto.text ?? ""
            vc.email = self.tfEmail.text ?? ""
            vc.cpf = self.tfCpf.text ?? ""
            
        default:
            break;
        }
    }
}

extension Collection where Element == Int {
    var digitoCPF: Int {
        var number = count + 2
        let digit = 11 - reduce(into: 0) {
            number -= 1
            $0 += $1 * number
        } % 11
        return digit > 9 ? 0 : digit
    }
}

extension StringProtocol {
    var isValidCPF: Bool {
        let numbers = compactMap(\.wholeNumberValue)
        guard numbers.count == 11 && Set(numbers).count != 1 else { return false }
        return numbers.prefix(9).digitoCPF == numbers[9] &&
        numbers.prefix(10).digitoCPF == numbers[10]
    }
}

extension NewUserViewController: UITextFieldDelegate {
    
    //Quantidade de caracter
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = (textField.text ?? "").count + string.count - range.length
        if(textField == self.tfCpf) {
            return newLength <= 11
        }
        return true
    }
    
    // Clicar em qualquer lugar da tela e excultar a ação
    func textFieldDidEndEditing(_ textField: UITextField) {
        verificationTextField()
    }
    

    
}
