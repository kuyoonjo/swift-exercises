//
//  ViewController.swift
//  Say
//
//  Created by Yu Chen on 2/28/15.
//  Copyright (c) 2015 Yu Chen. All rights reserved.
//

import Cocoa


class ViewController: NSViewController {

    @IBOutlet weak var Sentence: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    @IBAction func Say(sender: AnyObject) {
        let task: NSTask = NSTask()
        task.launchPath = "/usr/bin/say"
        task.arguments = [Sentence.stringValue]
        task.launch()
        task.waitUntilExit()
    }

}

