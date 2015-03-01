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
    @IBOutlet weak var Voices: NSComboBox!
    var task: NSTask!
    var voices = [Voice]()
    var voice: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        loadVoices()
        for voice in voices {
            let item = voice.name! + " - " + voice.lang!
            Voices.addItemWithObjectValue(item)
        }
        Voices.selectItemAtIndex(0)
        voice = voices[Voices.indexOfSelectedItem].name
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    @IBAction func Say(sender: AnyObject) {
        task = NSTask()
        task.launchPath = "/usr/bin/say"
        task.arguments = ["-v", voice, Sentence.stringValue]
        task.launch()
        task.waitUntilExit()
    }
    
    func loadVoices() {
        let task = NSTask()
        let pipe = NSPipe()
        var fileHandler: NSFileHandle!
        var data: NSData!
        var output: NSString!
        task.launchPath = "/usr/bin/say"
        task.arguments = ["-v", "?"]
        task.standardOutput = pipe
        task.launch()
        task.waitUntilExit()
        fileHandler = pipe.fileHandleForReading
        data = fileHandler.readDataToEndOfFile()
        output = NSString(data: data, encoding: NSUTF8StringEncoding)
        let lines = output.componentsSeparatedByString("\n") as Array<String>
        for line in lines {
            var pattens = line.split("\\s+")
            if pattens.count > 1 {
                voices.append(Voice(name: pattens[0], lang: pattens[1]))
            }
        }
    }

    @IBAction func ChangeVoice(sender: AnyObject) {
        voice = voices[Voices.indexOfSelectedItem].name
    }
}

