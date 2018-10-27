//
//  ThreadViewController.swift
//  ThreadDemo
//
//  Created by zhiyuan wang on 2018/8/30.
//  Copyright © 2018年 zhuyuan. All rights reserved.
//

import Foundation
import UIKit
class ThreadViewController: UIViewController {
        override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        initViews()
    }
    
    private func initViews(){
        addThread1Bt()
        addThread2Bt()
        addThread3Bt()
        addGetThreadBt()
    }
    private func addThread1Bt(){
        let thread1Bt = UIButton(frame: CGRect.init(x: 50, y: 100, width: 150, height: 50))
        thread1Bt.backgroundColor = UIColor.blue
        thread1Bt.setTitle("开启线程方法1", for: .normal)
        self.view.addSubview(thread1Bt)
        thread1Bt.addTarget(self, action: #selector(thread1Action), for: UIControlEvents.touchUpInside)
    }
    
    
    private func addThread2Bt(){
        let thread2Bt = UIButton(frame: CGRect.init(x: 50, y: 200, width: 150, height: 50))
        thread2Bt.backgroundColor = UIColor.blue
        thread2Bt.setTitle("开启线程方法2", for: .normal)
        self.view.addSubview(thread2Bt)
        thread2Bt.addTarget(self, action: #selector(thread2Action), for: UIControlEvents.touchUpInside)
    }
    
    
    private func addThread3Bt(){
        let thread3Bt = UIButton(frame: CGRect.init(x: 50, y: 300, width: 150, height: 50))
        thread3Bt.backgroundColor = UIColor.blue
        thread3Bt.setTitle("开启线程方法3", for: .normal)
        self.view.addSubview(thread3Bt)
        thread3Bt.addTarget(self, action: #selector(thread3Action), for: UIControlEvents.touchUpInside)
        
    }
    
    private func addGetThreadBt(){
        let getThreadBt = UIButton(frame: CGRect.init(x: 50, y: 300, width: 150, height: 50))
        getThreadBt.backgroundColor = UIColor.blue
        getThreadBt.setTitle("获取线程", for: .normal)
        self.view.addSubview(getThreadBt)
        getThreadBt.addTarget(self, action: #selector(getThreadAction), for: UIControlEvents.touchUpInside)
    }
    
    @objc func thread1Action(){
        print("** 方法一，需要start *")
       let thread = Thread.init(target: self, selector: #selector(doSomething1), object: nil)
        thread.start()
    }
    
    @objc func doSomething1(){
        print("当前线程名---\(Thread.current)")
    }
   
    @objc func thread2Action(){
        print("** 方法二，创建好之后自动启动--过期 *")
        let _ = Thread.detachNewThreadSelector(#selector(doSomething2), toTarget: self, with: nil)
    }
    
    @objc func doSomething2(){
        print("当前线程名---\(Thread.current)")
    }
    
  
    
    @objc func thread3Action(){
        print("** 方法三，隐式创建，直接启动  *")
        self.performSelector(inBackground: #selector(doSomething3), with: "Thread3")
    }
    
    @objc func doSomething3(){
        print("当前线程名---\(Thread.current)")
    }
    
    @objc func getThreadAction(){
        print("主线程\(Thread.main)")
        print("当前线程\(Thread.current)")
        print("线程睡眠3.0s---开始")
        Thread.sleep(forTimeInterval: 3.0)
        print("线程睡眠3.0s---完成")
        
        print("线程睡眠5.0s---开始")
        Thread.sleep(until: Date.init(timeIntervalSinceNow: 5.0))
        print("线程睡眠5.0s---完成")
        
    }
}
