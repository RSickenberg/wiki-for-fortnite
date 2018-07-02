//
//  MoreTableViewController.swift
//  fortnite_wiki
//
//  Created by Romain Sickenberg on 22.06.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//

import UIKit

class MoreCell: UITableViewCell {
    @IBOutlet weak var mainLabel: UILabel!
}

class MoreTableViewController: UITableViewController {

    @IBOutlet var moreTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareVisuals()
    }
    
    func prepareVisuals() {
        self.moreTableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favorties", for: indexPath) as! MoreCell
        cell.backgroundColor = UIColor(hexString:"547FF8")
        cell.textLabel?.textColor = UIColor.white
        cell.layoutMargins.bottom = CGFloat(10)
        
        switch indexPath.section {
        case 0:
            cell.mainLabel.text = "Your Favorites."
            break
        case 1:
            cell.mainLabel.text = "Contact."
            break
        case 2:
            cell.mainLabel.text = "Licences."
            break
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            performSegue(withIdentifier: "moreToFav", sender: self)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Interactions"
        } else if section == 1 {
            return "About"
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section > 1 {
            return CGFloat(0)
        }
        return CGFloat(20)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
