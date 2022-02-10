//
//  SecondViewController.swift
//  PostApp
//
//  Created by Consultant on 2/9/22.
//

import Foundation
import UIKit


class SecondeViewController: UIViewController {
    
    @IBOutlet private weak var titleLabel2: UILabel!
    
    @IBAction func changeButton(_ sender: Any) {
        row! += 1
        if posts.count > row! {
            titleLabel2.text = posts[row!].title }
    }
    var posts = [Post]()
    var row: Int?
    var header = ""
  //  var over = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        titleLabel2.text = post?.title
//        overview.text = post?.overview
        titleLabel2.text = posts[row!].title
    //    overview.text = over
    }
    
    
    
    
}
