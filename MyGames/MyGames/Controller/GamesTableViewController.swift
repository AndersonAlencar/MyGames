//
//  GamesTableViewController.swift
//  MyGames
//
//  Created by Anderson Alencar on 14/08/19.
//  Copyright © 2019 Anderson Alencar. All rights reserved.
//

import UIKit
import CoreData
@available(iOS 13.0, *)
class GamesTableViewController: UITableViewController {


    var fetchedResultsController: NSFetchedResultsController<Game>! // Dá acesso ao coreData
    var label = UILabel()
    
    let searchController = UISearchController(searchResultsController: nil) // podemos escolher a controller de apresentaçao

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]

       
        label.text = "Nenhum jogo cadastrado"
        label.textAlignment = .center
        
        searchController.searchResultsUpdater = self // parecido com o delegate
        //searchController.dimsBackgroundDuringPresentation = false // comportamento de foco da searController (está depreciado)
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.barTintColor = UIColor.black
        
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        loadGames()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier! == "showGame" {
            let gameController = segue.destination as! GameViewController
            
            if let games = fetchedResultsController.fetchedObjects {
                gameController.game = games[tableView.indexPathForSelectedRow!.row]
            }
        }
    }

    
    func loadGames(filtering: String = "") {
        let fetchRequest : NSFetchRequest<Game> = Game.fetchRequest() // esse método retorna um fetchRequest do tipo game constrído
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true) //descrição imutável de como ordenar uma coleção de objetos com base em uma propriedade comum a todos os objetos.
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if !filtering.isEmpty {
            //modo para selecionar entidades desejáveis
            let predicate = NSPredicate(format: "title contains [c] %@", filtering) // %@ equivale a dizer que : title contains filtering //// [c] significa que a string não é case sensitive e aceita pesquisas maisculas e minusculas na string
            fetchRequest.predicate = predicate
        }

        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do{
            try fetchedResultsController.performFetch() //Depois de executar esse método, você pode acessar os objetos buscados do receptor com a propriedade fetchedObjects.

        } catch {
            print(error.localizedDescription)
        }

    }
    
    
    
    @IBAction func addNewGame(_ sender: Any) {
        performSegue(withIdentifier: "addGame", sender: nil)
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let count = fetchedResultsController.fetchedObjects?.count ?? 0
        
        tableView.backgroundView = count == 0 ? label : nil
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GameTableViewCell

        guard let game = fetchedResultsController.fetchedObjects?[indexPath.row] else { return cell }
        
        cell.prepare(with: game)
        
        return cell
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            guard let game = fetchedResultsController.fetchedObjects?[indexPath.row] else {return}
            context.delete(game)
        }
    }
}

@available(iOS 13.0, *)
extension GamesTableViewController: NSFetchedResultsControllerDelegate {
    
    //Sempre que algum objeto for modificado esse método é disparado
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
            case .delete:
                
                if let indexPath = indexPath {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
                break
            default:
                tableView.reloadData()
        }
    }
    
}

@available(iOS 13.0, *)
extension GamesTableViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        //
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        loadGames()
        tableView.reloadData()

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loadGames(filtering: searchBar.text! )
        tableView.reloadData()
    }
    
    
    
}
