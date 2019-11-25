//
//  EnglishViewController.swift
//  English
//
//  Created by Kao on 2019/11/21.
//  Copyright © 2019 SHIH-YING PAN. All rights reserved.
////

import UIKit
import AVFoundation

class EnglishViewController: UIViewController {
    
    //傳資料來這頁要設一個變數來存
    var alphabet:String?
    //用來存現在讀到第幾個單字
    var index = 0
    //英文單字
    var lines = [String]()
    
    var array = [String]()
    var favArray = [[String]]()
    
    @IBAction func goToChinese(segue:UIStoryboardSegue){
    }
    
    @IBOutlet weak var saveOutlet: UIButton!
    @IBOutlet weak var vocabularyLabel: UILabel!
    @IBOutlet weak var sentenceLabel: UILabel!
    //vocabularyLabel
    //sentenceLabel
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favArray = EnglishViewController.getFavVocabularys()
        
        //判斷alphabet有沒有值，有的話顯示出來
        if let alphabetfile = alphabet{
            //取得Asset內的檔案名稱，與NSDataAsset(name: , bundle: )的差異在於bundle是用告知詳細位置
            let asset = NSDataAsset(name:alphabetfile )
            //取得asset的資料，encoding：看檔案的編碼是用什麼格式
            if let data = asset?.data{
                let content = String(data: data, encoding:.utf16)
                //因為txt中太多行，要進行拆字
                //用換行去切開，取得對應字母的單字
                if let lines = content?.components(separatedBy: "\n"){
                    self.lines = lines
                }
                show()
                
            }
        }
    }
    
    //顯示英文單字與句子
    func show(){
        //取得對應字母的單字的第幾項
        //承接全域變數(lines)
        let line = lines[index]
        
        //再進行切割
        array = line.components(separatedBy: "\t")
        vocabularyLabel.text = array[0]
        sentenceLabel.text =  array[2]
        //contains檢查是否含有指定值
        saveOutlet.isSelected = favArray.contains(array)
        
    }
    

    
    
    @IBAction func btSave(_ sender: UIButton) {
        sender.isSelected.toggle()
        //用 if else寫加或刪
        if sender.isSelected{
            favArray.append(array)
        }else{
            favArray.removeAll { (favVocabulary) -> Bool in
                if favVocabulary == array{
                    return true
                }else{
                return false
                }
            }
        }
        save(favVocabulary: favArray)
        
    }

    
    func save(favVocabulary:[[String]]){
        if let data = try?JSONEncoder().encode(favVocabulary) {
            UserDefaults.standard.setValue(data, forKey: "favVocabulary")
        }
    }
    
  static  func getFavVocabularys() -> [[String]]{
        if let data = UserDefaults.standard.data(forKey: "favVocabulary"){
            if let favVocabularys = try? JSONDecoder().decode([[String]].self, from: data){
                return favVocabularys
                
            }
        }
        return [[String]]()
    }
    
    
    
    @IBAction func btNext(_ sender: UIButton) {
        
        index = index + 1
        if index > lines.count - 1{
            //如果已經到最後一個單字就回到第一個單字
            index = 0
        }
        show()

        
        
    }
    
    @IBAction func btPrev(_ sender: UIButton) {
        index = index - 1
        if index < 0{
            //如果已經到第一個單字了，就回到最後一個單字
            index = lines.count - 1
        }
            show()
            
        
        
    }
    
    
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    //拿到中文翻譯的畫面
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
      let navController = segue.destination as! UINavigationController
        //navigationController因為會接好幾頁，屬性屬於array，所以可以用viewControllers[0]或topViewController代表第一頁
        let chineseController = navController.topViewController as! ChineseViewController
        chineseController.vocabulary = array[1]
        chineseController.sentence = array[3]
        chineseController.alphabet = alphabet
        
        
     }
    
    
    
    @IBAction func speak(_ sender: UIButton) {
        let wordAudio = AVSpeechUtterance(string: array[0])
        let audio = AVSpeechSynthesizer()
        audio.speak(wordAudio)
    }
    
     
    
}
