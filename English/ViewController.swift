//
//  ViewController.swift
//  English
//
//  Created by SHIH-YING PAN on 2019/11/19.
//  Copyright © 2019 SHIH-YING PAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       
    }

    @IBAction func alphabetTap(_ sender: UIButton) {
        //獲取按鈕標題
//        sender.currentTitle
        
        //切換指定頁面，sender也可以拿來傳資料，這邊拿來傳按鈕標題
        performSegue(withIdentifier: "showDetail", sender: sender.currentTitle)
        
        
    }
    
    //performSegue跑完會跑prepare。prepare的參數也有sender，意味著prepare可以收到performSegue的sender傳到下一頁
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //把資料帶到下一頁並轉成EnglishViewController的類別
       let controller = segue.destination as! EnglishViewController
        //轉型完成後即可取得EnglishViewController中的值，sender是按鈕上的字母，sender預設型別是Any要轉成alphabet相同型別，再把對應的字母傳到下一頁
        controller.alphabet = (sender as! String)
        
    }
    
    
}

