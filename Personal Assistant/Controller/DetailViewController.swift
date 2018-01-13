//
//  DetailViewController.swift
//  Personal Assistant
//
//  Created by Nisha Raghu on 27/11/17.
//  Copyright © 2017 TheUltimates.com. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

   // @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textView: UITextView!
    var text: String = ""
    var masterView:PersonalDiaryVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textView.text = text
   //     textView.isUserInteractionEnabled = true
   //     textView.isEditable = true
     //   textView!.delegate = self as? UITextViewDelegate
    }
    
    func setText(t:String){
        text = t
        if isViewLoaded{
            textView.text = t
        }
     
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        masterView.newRowText = textView.text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
