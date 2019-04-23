//
//  DramaTableViewController.swift
//  interview_prac
//
//  Created by Alexhu on 2019/4/23.
//  Copyright © 2019 Alexhu. All rights reserved.
//

import UIKit

class DramaTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var dramaData = [Drama]() // 儲存JSON資料
    var filteredData = [Drama]()
    var currentRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
        let url: URL = URL(string: "http://www.mocky.io/v2/5a97c59c30000047005c1ed2?fbclid=IwAR265iuLYLgGgUgP9k6lsdxGuOJcW9qWbPFiBbiuUzxhRQVxK2WsCx-fVD0")!
        
        let task = URLSession.shared.dataTask(with: url) {
            (jsonData, response , error)
            in
            //初始化JSON解碼器
            let decoder = JSONDecoder()
            //設定解碼器使用的日期解碼策略
            decoder.dateDecodingStrategy = .iso8601
            //JSON解碼器開始解碼JSON資料到SongResults結構的實體（SongResults.self）
            if let jData = jsonData, let dramaList = try?
                decoder.decode(DramaList.self, from: jData)
            {
                self.dramaData = dramaList.data
                print("陣列：\(self.dramaData)")
                //離線資料集已讀取到JSON資料時
                DispatchQueue.main.async {
                    //重整表格資料
                    self.filteredData = self.dramaData
                    self.tableView.reloadData()
                }
            }
            else
            {
                print("error")
            }
        }
        task.resume()
        
        
        self.searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        print("filteredData: \(filteredData)")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredData.count > 0 ? filteredData.count : 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DramaCell", for: indexPath) as! DramaCell
        
        if filteredData.count < 1{
            cell.dramaPic.image = UIImage(named: "notFound.png")
            cell.dramaName.text = "對不起！"
            cell.dramaRate.text = "你搜尋的關鍵字我找不到"
            cell.dramaPubDate.text = "麻煩你再確認一下QQ"
            return cell
        }
        
        cell.dramaName.text = "片名：\(filteredData[indexPath.row].name)"
        cell.dramaRate.text = "觀眾評分：\(String(filteredData[indexPath.row].rating))"
        let dateStr = (filteredData[indexPath.row].created_at as NSString).substring(to: 10)
        cell.dramaPubDate.text = "上映日期：\(dateStr)"
        
        let task = URLSession.shared.dataTask(with: filteredData[indexPath.row].thumb){
            (picData, response, error) in
            if let photoImage = picData
            {
                DispatchQueue.main.async {
                    cell.dramaPic.image = UIImage(data: photoImage)
                }
            } else {
                DispatchQueue.main.async {
                    cell.dramaPic.image = UIImage(named: "notFound.png")
                }
            }
        }
        task.resume()
        return cell
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //記錄點選欄位的索引值
        currentRow = indexPath.row
        let dramaDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        dramaDetailVC.dramaTableVC = self
        self.show(dramaDetailVC, sender: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        print("[ViewController searchBar] searchText: \(searchText)")
        
        if searchText == "" {
            self.filteredData = self.dramaData
        } else {
            self.filteredData = []
            
            for i in self.dramaData {

                if i.name.hasPrefix(searchText){
                    self.filteredData.append(i)
                }
            }
        }
        self.tableView.reloadData()
        print(filteredData)
    }
}
