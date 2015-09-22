//
//  ViewController.swift
//  search
//
//  Created by Tanmay Bakshi on 2015-09-18.
//  Copyright © 2015 Tanmay Bakshi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet var tableView: UITableView!
    
    var data = [
                "Roger and me",
                "Toy Story",
                "Inside Out",
                "Charlotte's Web",
                "Life of Pie",
                "The Hunger Games",
                "The Imitation Game",
                "Despicable Me",
                "The Theory of everything",
                "Sponge out of Water",
                "The SpongeBob SquarePants movie",
                "Dawn of the planet of the apes",
                "Captain America: The Winter Soldier",
                "The Lego Movie",
                "Guardians of the Galaxy",
                "The Hobbit",
                "Kite runner",
                "Into the woods",
                "Time lapse",
                "The expendables",
                "Steve Jobs: the documentary"
                ]
    
    var tempData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        if textField.text! != "" {
            tempData = searchIt(data, compare: textField.text!)
            tableView.reloadData()
        } else {
            tempData = []
            tableView.reloadData()
        }
        return true
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempData.count > 0 ? tempData.count : data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell.textLabel!.text = tempData.count > 0 ? tempData[indexPath.row] : data[indexPath.row]
        return cell
    }
    
    func searchIt(list: [String], compare: String) -> [String] {
        
        func levDis(w1: String, w2: String) -> Int {
            
            let (t, s) = (w1.characters, w2.characters)
            
            let empty = Repeat(count: s.count, repeatedValue: 0)
            var mat = [[Int](0...s.count)] + (1...t.count).map{[$0] + empty}
            
            for (i, tLett) in t.enumerate() {
                for (j, sLett) in s.enumerate() {
                    mat[i + 1][j + 1] = tLett == sLett ?
                        mat[i][j] : min(mat[i][j], mat[i][j + 1], mat[i + 1][j]).successor()
                }
            }
            return mat.last!.last!
        }
        
        var finals = [String]()
        
        for i in list {
            
            if i.containsString(compare) {
                
                finals.append(i)
                
            }
            
        }
        
        var finalsInt = [String: Int]()
        
        for i in finals {
            
            finalsInt[i] = levDis(compare, w2: i)
            
        }
        
        finals.sortInPlace({ finalsInt[$0] < finalsInt[$1] })
        
        return finals
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

