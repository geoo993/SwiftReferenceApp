//
//  ReadViewController.swift
//  SwiftReferenceApp
//
//  Created by GEORGE QUENTIN on 27/10/2016.
//  Copyright © 2016 StoryShare. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ReadViewController: UIViewController 
{
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.redColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}