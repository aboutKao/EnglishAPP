//
//  FavoriteTableViewController.swift
//  English
//
//  Created by Kao on 2019/11/24.
//  Copyright © 2019 SHIH-YING PAN. All rights reserved.
//

import UIKit

class FavoriteTableViewController: UITableViewController {
    
    var favArray = [[String]]()
    
    
    func save(favVocabulary:[[String]]){
        if let data = try?JSONEncoder().encode(favVocabulary) {
            UserDefaults.standard.setValue(data, forKey: "favVocabulary")
        }
    }
    
    
    func getFavVocabularys() -> [[String]]{
        if let data = UserDefaults.standard.data(forKey: "favVocabulary"){
            if let favVocabularys = try? JSONDecoder().decode([[String]].self, from: data){
                return favVocabularys
            }
        }
        return [[String]]()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        favArray = getFavVocabularys()
        tableView.reloadData()
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        
        let line = favArray[indexPath.row]
        let line2 = line[0].description
        let line3 = line[1].description
        
        
        
//        let word2 = word.components(separatedBy: "\t").description as String
        cell.textLabel?.text = line2
        cell.detailTextLabel?.text = line3
        // Configure the cell...
        print(getFavVocabularys())

        return cell
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            favArray.remove(at: indexPath.row)
            save(favVocabulary:favArray)
            tableView.reloadData()
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
