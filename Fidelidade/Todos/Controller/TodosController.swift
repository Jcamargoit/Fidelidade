//  Todos.swift
//  FrameworkTest
//  Created by Juninho on 26/11/21.


import UIKit

class TodosController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var minhatabview: UITableView!
    
    var listAll = TodosViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        setup()
    }
    
    
    func setup(){
        APIService().load(resource: TodosModel.Get) { [weak self] result in
            switch result {
            case .success(let orders):
                self?.listAll.todosViewModel = orders
                self?.minhatabview.reloadData()
            case .failure(let error):
                print("Error ", error)
            }
        }
    }
    
    
    /// Tamanhop table vcelula
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 84
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        self.minhatabview.reloadData()
    }
    
    
    //quantidade de Setions (quantidade Categorias)
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    //Quantidade de celulas por categoria
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.listAll.todosViewModel.count
        
    }
    
    
    //Alimentar a celula com id
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:
                                                    indexPath) as! TodosCelula
        let vm = self.listAll.todosViewModel(at: indexPath.row)
        
        cell.titulo.text = vm.title
        cell.sw.isOn = vm.completed
        
        return cell
    }
}

