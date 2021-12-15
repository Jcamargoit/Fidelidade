//  Albuns.swift
//  FrameworkTest
//  Created by Juninho on 26/11/21.

import UIKit

class AlbunsController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var minhatabview: UITableView!
    
    var listAlbum = AlbunsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        setup()
    }
    
    func setup(){
        APIService().load(resource: AlbunsModel.Get) { [weak self] result in
            switch result {
            case .success(let orders):
                self?.listAlbum.albunsViewModel = orders
                self?.minhatabview.reloadData()
            case .failure(let error):
                print("Error ", error)
            }
        }
    }
    
    /// Tamanhop table vcelula
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    
    //quantidade de Setions (quantidade Categorias)
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.minhatabview.reloadData()
    }
    
    
    //Quantidade de celulas por categoria
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listAlbum.albunsViewModel.count
    }
    
    
    //Alimentar a celula com id
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:
                                                    indexPath) as! AlbunsCelula
        
        let vm = self.listAlbum.albunsViewModel(at: indexPath.row)
        cell.titulo.text = vm.title
        
        return cell
    }
}

