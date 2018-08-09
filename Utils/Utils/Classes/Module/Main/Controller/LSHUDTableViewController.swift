//
//  LSHUDTableViewController.swift
//  Utils
//
//  Created by Lee on 2018/8/9.
//  Copyright © 2018年 Lee. All rights reserved.
//

import UIKit

class LSHUDTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 8
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UITableViewCell.self), for: indexPath)

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Success"
        case 1:
            cell.textLabel?.text = "Error"
        case 2:
            cell.textLabel?.text = "Info"
        case 3:
            cell.textLabel?.text = "Loading"
        case 4:
            cell.textLabel?.text = "Loading with text"
        case 5:
            cell.textLabel?.text = "Text"
        case 6:
            cell.textLabel?.text = "Text2"
        case 7:
            cell.textLabel?.text = "Hide"
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            LSHUD.showSuccess("加载成功")
        case 1:
            LSHUD.showError("加载失败")
        case 2:
            LSHUD.showInfo("请先登录")
        case 3:
            LSHUD.showLoading()
        case 4:
            LSHUD.showLoading("loading...")
        case 5:
            LSHUD.showText("Hello,World!")
        case 6:
            let hud = LSHUD(text: "锄禾日当午汗滴禾下土", type: .text, delay: 0)
            hud.backgroundColor = UIColor(red: 98/255, green: 162/255, blue: 238/255, alpha: 0.9)
            hud.show()
            hud.hide(delay: 3)
        case 7:
            LSHUD.hide()
        default:
            break
        }
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
