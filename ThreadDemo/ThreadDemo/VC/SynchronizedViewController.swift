//
//  SynchronizedViewController.swift
//  ThreadDemo
//
//  Created by zhiyuan wang on 2018/9/3.
//  Copyright © 2018年 zhuyuan. All rights reserved.
//

import Foundation
import UIKit
class SynchronizedViewController: UIViewController {
    
    var imageMutableArray:Array<Any> = Array.init()
    let lock = NSLock.init()
    let conditionLock = NSConditionLock.init()
    let recursiveLock = NSRecursiveLock.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        addNSLockBt()
        addNSConditionBt()
        addNSConditionLockBt()
        addRecursiveLockBt()
        addSynchronizedBt()
        initData()
    }
    func initData(){
        for  i in 0..<1000 {
            imageMutableArray.append("imageArray==="+String(i))
        }
        print("你初始化的数组个数是",imageMutableArray.count)
    }
    private func addNSLockBt(){
        let nsLockBt = UIButton(frame: CGRect.init(x: 50, y: 100, width: 100, height: 50))
        nsLockBt.backgroundColor = UIColor.blue
        nsLockBt.setTitle("NSLock", for: .normal)
        self.view.addSubview(nsLockBt)
        nsLockBt.addTarget(self, action: #selector(nsLockAction), for: UIControlEvents.touchUpInside)
        
    }
    
    private func addNSConditionBt(){
        let nsConditionBt = UIButton(frame: CGRect.init(x: 50, y: 200, width: 100, height: 50))
        nsConditionBt.backgroundColor = UIColor.blue
        nsConditionBt.setTitle("NSCondition", for: .normal)
        self.view.addSubview(nsConditionBt)
        nsConditionBt.addTarget(self, action: #selector(nsConditionAction), for: UIControlEvents.touchUpInside)
    }
    
    private func addNSConditionLockBt(){
        let nsConditionLockBt = UIButton(frame: CGRect.init(x: 50, y: 300, width: 100, height: 50))
        nsConditionLockBt.backgroundColor = UIColor.blue
        nsConditionLockBt.setTitle("NSConditionLock", for: .normal)
        self.view.addSubview(nsConditionLockBt)
        nsConditionLockBt.addTarget(self, action: #selector(nsConditionLockAction), for: UIControlEvents.touchUpInside)
    }
    
    private func addRecursiveLockBt(){
        let recursiveLockBt = UIButton(frame: CGRect.init(x: 50, y: 400, width: 100, height: 50))
        recursiveLockBt.backgroundColor = UIColor.blue
        recursiveLockBt.setTitle("递归锁", for: .normal)
        self.view.addSubview(recursiveLockBt)
        recursiveLockBt.addTarget(self, action: #selector(recursiveLockAction), for: UIControlEvents.touchUpInside)
    }
    
    private func addSynchronizedBt(){
        let synchronizedBt = UIButton(frame: CGRect.init(x: 50, y: 400, width: 100, height: 50))
        synchronizedBt.backgroundColor = UIColor.blue
        synchronizedBt.setTitle("互斥锁", for: .normal)
        self.view.addSubview(synchronizedBt)
        synchronizedBt.addTarget(self, action: #selector(synchronizedAction), for: UIControlEvents.touchUpInside)
    }
    
    @objc func nsLockAction(){
        // 我们使用多个线程去删除一个数组里面的东西，这样就有一个资源竞争的问题，我们看看
        // 你可以先把这里的lock加锁个解锁的方法注释掉，代码会崩溃在imageMutableArray.removeFirst()
        let global = DispatchQueue.global()
        global.async {
            while true {
                self.lock.lock()
                if self.imageMutableArray.count > 0{
                    self.imageMutableArray.removeFirst()
                }else{
                    print("已经移除完毕,\(self.imageMutableArray.count)")
                    break
                }
                self.lock.unlock()
            }
        }
        
        global.async {
            while true {
                self.lock.lock()
                if self.imageMutableArray.count > 0{
                    self.imageMutableArray.removeFirst()
                }else{
                    print("已经移除完毕,\(self.imageMutableArray.count)")
                    break
                }
                self.lock.unlock()
            }
        }
    }
    
    
    
    @objc func nsConditionAction(){
        // 但我们要是把NSCondition当NSLock用那就真的是浪费了！NSCondition还有自己的wait和signal用法，这个和后面信号量有点点类似，信号量的我们下面再说，看看NSCondition部分的代码
        let global = DispatchQueue.global()
        global.async {
            while true {
                self.lock.lock()
                if self.imageMutableArray.count > 0{
                    self.imageMutableArray.removeFirst()
                }else{
                    print("已经移除完毕,\(self.imageMutableArray.count)")
                    break
                }
                self.lock.unlock()
            }
        }
        
        global.async {
            while true {
                self.lock.lock()
                if self.imageMutableArray.count > 0{
                    self.imageMutableArray.removeFirst()
                }else{
                    print("已经移除完毕,\(self.imageMutableArray.count)")
                    break
                }
                self.lock.unlock()
            }
        }
    }
    
    @objc private func nsConditionLockAction(){
        
        let global = DispatchQueue.global()
        global.async {
            while true {
                self.conditionLock.lock()
                if self.imageMutableArray.count > 0{
                    self.imageMutableArray.removeFirst()
                }else{
                    print("已经移除完毕,\(self.imageMutableArray.count)")
                    break
                }
                self.conditionLock.unlock()
            }
        }
        
        global.async {
            while true {
                self.conditionLock.lock()
                if self.imageMutableArray.count > 0{
                    self.imageMutableArray.removeFirst()
                }else{
                    print("已经移除完毕,\(self.imageMutableArray.count)")
                    break
                }
                self.conditionLock.unlock()
            }
        }
    }
    
    
    @objc func recursiveLockAction(){
        /*有时候“加锁代码”中存在递归调用，递归开始前加锁，递归调用开始后会重复执行此方法以至于反复执行加锁代码最终造成死锁，这个时候可以使用递归锁来解决，也就是我们的NSRecursiveLock，它就是递归锁！使用递归锁可以在一个线程中反复获取锁而不造成死锁，在这个过程中也会记录获取锁和释放锁的次数，只有等两者平衡的时候才会释放
         */
        let dispatchGroup  = DispatchGroup.init()
        ///并行队列
        let dispatchQueue  = DispatchQueue.init(label:"test", qos: .default, attributes: .concurrent)
        dispatchQueue.async(group: dispatchGroup, qos: .default, flags: DispatchWorkItemFlags.noQoS) {
            self.removeFromImageArray()
        }
    }
    
    
    private func removeFromImageArray() -> Void {
//        lock.lock()
        recursiveLock.lock()
        if imageMutableArray.count > 0 {
            imageMutableArray.removeFirst()
            self.removeFromImageArray()
        }else{
            print("已经移除完毕,\(self.imageMutableArray.count)")
        }
//        lock.unlock()
        recursiveLock.unlock()
    }
    
    @objc func synchronizedAction(){
        let global = DispatchQueue.global()
        global.async {
            while true {
                objc_sync_enter(self)
                if self.imageMutableArray.count > 0{
                    self.imageMutableArray.removeFirst()
                }else{
                    print("已经移除完毕,\(self.imageMutableArray.count)")
                    break
                }
                objc_sync_exit(self)
            }
        }
        
        global.async {
            while true {
                objc_sync_enter(self)
                if self.imageMutableArray.count > 0{
                    self.imageMutableArray.removeFirst()
                }else{
                    print("已经移除完毕,\(self.imageMutableArray.count)")
                    break
                }
                objc_sync_exit(self)
            }
        }
    }
    
}













