//
//  ChineseViewController.swift
//  English
//
//  Created by Kao on 2019/11/23.
//  Copyright © 2019 SHIH-YING PAN. All rights reserved.
//

import UIKit

class ChineseViewController: UIViewController {
    
    var vocabulary:String?
    var sentence:String?
    var alphabet:String?
     var lines = [String]()
    var index = 0
    
    @IBOutlet weak var vocabularyLabel: UILabel!
    
    @IBOutlet weak var sentenceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //判斷alphabet有沒有值，有的話顯示出來
        if let alphabetfile = alphabet{
            //取得Asset內的檔案名稱，與NSDataAsset(name: , bundle: )的差異在於bundle是用告知詳細位置
            let asset = NSDataAsset(name:alphabetfile )
            //取得asset的資料，encoding：看檔案的編碼是用什麼格式
            if let data = asset?.data{
                let content = String(data: data, encoding:.utf16)
                //因為txt中太多行，要進行拆字，用換行去切開，取得對應字母的單字
                if let lines = content?.components(separatedBy: "\n"){
                    self.lines = lines
                }
                showChinese()
                
            }
        }
        
        
    }
    
    //顯示英文單字與句子
    func showChinese(){
        //取得對應字母的單字的第幾項
        //承接全域變數(lines)
        let line = lines[index]
        
        //再進行切割
        let  array = line.components(separatedBy: "\t")
        vocabularyLabel.text = array[1]
        sentenceLabel.text =  array[3]
    }
    
   
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
