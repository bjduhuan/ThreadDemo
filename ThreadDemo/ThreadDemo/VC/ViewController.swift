//
//  ViewController.swift
//  ThreadDemo
//
//  Created by zhiyuan wang on 2018/8/29.
//  Copyright © 2018年 zhuyuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addThreadBt()
        addGCDBt()
        addSynchronizedBt()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func addThreadBt(){
        let threadBt = UIButton(frame: CGRect.init(x: 100, y: 100, width: 100, height: 50))
        threadBt.setTitle("Thread", for: .normal)
        threadBt.backgroundColor = UIColor.blue
        self.view.addSubview(threadBt)
        threadBt.addTarget(self, action: #selector(threadAction), for: UIControlEvents.touchUpInside)

    }

    private func addGCDBt(){
        let gcdBt = UIButton(frame: CGRect.init(x: 100, y: 200, width: 100, height: 50))
        gcdBt.setTitle("GCD", for: .normal)
        gcdBt.backgroundColor = UIColor.blue
        self.view.addSubview(gcdBt)
        gcdBt.addTarget(self, action: #selector(gcdAction), for: UIControlEvents.touchUpInside)
    }
    
    private func addSynchronizedBt(){
        let synchronizedBt = UIButton(frame: CGRect.init(x: 100, y: 300, width: 100, height: 50))
        synchronizedBt.setTitle("锁操作", for: .normal)
        synchronizedBt.backgroundColor = UIColor.blue
        self.view.addSubview(synchronizedBt)
        synchronizedBt.addTarget(self, action: #selector(synchronizedAction), for: UIControlEvents.touchUpInside)

    }
    
    @objc func gcdAction(){
        self.show(GCDViewController(), sender: nil)
    }
    
    @objc func threadAction(){
        self.show(ThreadViewController(), sender: nil)

    }

    @objc func synchronizedAction(){
        self.show(SynchronizedViewController(), sender: nil)
    }
}



















