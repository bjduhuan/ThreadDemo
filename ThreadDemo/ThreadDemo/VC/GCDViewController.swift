//
//  GCDViewController.swift
//  ThreadDemo
//
//  Created by zhiyuan wang on 2018/8/29.
//  Copyright © 2018年 zhuyuan. All rights reserved.
//

import Foundation
import UIKit
class GCDViewController: UIViewController {
    ///集合先存储1000条数据
    var imageMutableArray:Array<Any> = Array.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        initViews()
        initData()
    }
    
    private func initData(){
        for  i in 0...1000 {
            imageMutableArray.append("imageArray==="+String(i))
        }
        print("你初始化的数组个数是",imageMutableArray.count )
    }
    /*同步:多个任务情况下，一个任务A执行结束，才可以执行另一个任务B。只存在一个线程。
     异步:多个任务情况下，一个任务A正在执行，同时可以执行另一个任务B。任务B不用等待任务A结束才执行。存在多条线程。
     
     串行队列：串行队列的特点是队列内的线程是一个一个执行，直到结束。
     并行队列：并行队列的特点是队列中所有线程的执行结束时必须是一块的，队列中其他线程执行完毕后，会阻塞当前线程等待队列中其他线程执行，然后一块执行完毕。
     */
    private func initViews(){
        addSyncSerialBt()
        addAsyncSerialBt()
        addSyncConcurrentBt()
        addAsyncConcurrentBt()
        addSyncMainBt()
        addAsyncMainBt()
        addSyncGlobalBt()
        addAsyncGlobalBt()
        addThreadComunicationBt()
        addGCDQueueGroupBt()
        addBarrierGCDBt()
        addSemaphoreBt()
    }
    //串行同步按钮
    private func addSyncSerialBt(){
        let syncSerialBt = UIButton(frame: CGRect.init(x: 50, y: 100, width: 100, height: 50))
        syncSerialBt.backgroundColor = UIColor.blue
        syncSerialBt.setTitle("串行同步", for: .normal)
        self.view.addSubview(syncSerialBt)
        syncSerialBt.addTarget(self, action: #selector(syncSerialAction), for: UIControlEvents.touchUpInside)
    }
    ///串行异步按钮
    private func addAsyncSerialBt(){
        let asyncSerialBt = UIButton(frame: CGRect.init(x: 200, y: 100, width: 100, height: 50))
        asyncSerialBt.backgroundColor = UIColor.blue
        asyncSerialBt.setTitle("串行异步", for: .normal)
        self.view.addSubview(asyncSerialBt)
        asyncSerialBt.addTarget(self, action: #selector(asyncSerialAction), for: UIControlEvents.touchUpInside)
    }
    ///并行同步
    private func addSyncConcurrentBt(){
        let syncConcurrentBt = UIButton(frame: CGRect.init(x: 50, y: 200, width: 100, height: 50))
        syncConcurrentBt.backgroundColor = UIColor.blue
        syncConcurrentBt.setTitle("并行同步", for: .normal)
        self.view.addSubview(syncConcurrentBt)
        syncConcurrentBt.addTarget(self, action: #selector(syncConcurrentAction), for: UIControlEvents.touchUpInside)
    }
    ///并行异步
    private func addAsyncConcurrentBt(){
        let asyncConcurrentBt = UIButton(frame: CGRect.init(x: 200, y: 200, width: 100, height: 50))
        asyncConcurrentBt.backgroundColor = UIColor.blue
        asyncConcurrentBt.setTitle("并行异步", for: .normal)
        self.view.addSubview(asyncConcurrentBt)
        asyncConcurrentBt.addTarget(self, action: #selector(asyncConcurrentAction), for: UIControlEvents.touchUpInside)
    }
    ///主队列同步，死锁崩溃
    private func addSyncMainBt(){
        let syncMainBt = UIButton(frame: CGRect.init(x: 50, y: 300, width: 100, height: 50))
        syncMainBt.backgroundColor = UIColor.blue
        syncMainBt.setTitle("主队列同步", for: .normal)
        self.view.addSubview(syncMainBt)
        syncMainBt.addTarget(self, action: #selector(syncMainAction), for: UIControlEvents.touchUpInside)
    }
    
    private func addAsyncMainBt(){
        let asyncMainBt = UIButton(frame: CGRect.init(x: 200, y: 300, width: 100, height: 50))
        asyncMainBt.backgroundColor = UIColor.blue
        asyncMainBt.setTitle("主队列异步", for: .normal)
        self.view.addSubview(asyncMainBt)
        asyncMainBt.addTarget(self, action: #selector(asyncMainAction), for: UIControlEvents.touchUpInside)

    }
    
    private func addSyncGlobalBt(){
        let syncGlobalBt = UIButton(frame: CGRect.init(x: 50, y: 400, width: 100, height: 50))
        syncGlobalBt.backgroundColor = UIColor.blue
        syncGlobalBt.setTitle("全局队列同步", for: .normal)
        self.view.addSubview(syncGlobalBt)
        syncGlobalBt.addTarget(self, action: #selector(syncGlobalAction), for: UIControlEvents.touchUpInside)

    }
    
    private func addAsyncGlobalBt(){
        let asyncGlobalBt = UIButton(frame: CGRect.init(x: 200, y: 400, width: 100, height: 50))
        asyncGlobalBt.backgroundColor = UIColor.blue
        asyncGlobalBt.setTitle("全局队列同步", for: .normal)
        self.view.addSubview(asyncGlobalBt)
        asyncGlobalBt.addTarget(self, action: #selector(asyncGlobalAction), for: UIControlEvents.touchUpInside)
    }
    
    private func addThreadComunicationBt(){
        let threadComunicationBt = UIButton(frame: CGRect.init(x: 50, y: 500, width: 100, height: 50))
        threadComunicationBt.backgroundColor = UIColor.blue
        threadComunicationBt.setTitle("线程间通信", for: .normal)
        self.view.addSubview(threadComunicationBt)
        threadComunicationBt.addTarget(self, action: #selector(threadComunicationAction), for: UIControlEvents.touchUpInside)
    }
    
    private func addGCDQueueGroupBt(){
        let mGCDQueueGroupBt = UIButton(frame: CGRect.init(x: 200, y: 500, width: 100, height: 50))
        mGCDQueueGroupBt.backgroundColor = UIColor.blue
        mGCDQueueGroupBt.setTitle("队列组", for: .normal)
        self.view.addSubview(mGCDQueueGroupBt)
        mGCDQueueGroupBt.addTarget(self, action: #selector(mGCDQueueGroupAction), for: UIControlEvents.touchUpInside)

    }
    
    
    private func addBarrierGCDBt(){
        let barrierGCDBt = UIButton(frame: CGRect.init(x: 50, y: 600, width: 100, height: 50))
        barrierGCDBt.backgroundColor = UIColor.blue
        barrierGCDBt.setTitle("GCD栅栏", for: .normal)
        self.view.addSubview(barrierGCDBt)
        barrierGCDBt.addTarget(self, action: #selector(barrierGCDAction), for: UIControlEvents.touchUpInside)
    }
    
    private func addSemaphoreBt(){
        let semaphoreBt = UIButton(frame: CGRect.init(x: 200, y: 600, width: 100, height: 50))
        semaphoreBt.backgroundColor = UIColor.blue
        semaphoreBt.setTitle("信号量", for: .normal)
        self.view.addSubview(semaphoreBt)
        semaphoreBt.addTarget(self, action: #selector(semaphoreAction), for: UIControlEvents.touchUpInside)
    }
    
    @objc private func syncSerialAction(){
        print("串行同步-----队列中的线程依次执行，并且主线程阻塞，等待任务的完成\n")
        
        // 属性解释：
        // label:队列标签
        // qos:设置队列的优先级
        // attributes:队列形式：默认串行，设置为.concurrent代表是并行队列
        ///串行队列
        let queue = DispatchQueue.init(label: "串行队列")
        //同步任务1
        queue.sync {
            for i in 0..<3{
                print("串行同步-1----\(i)-----\(Thread.current)---\(queue.label)")
            }
        }
        //同步任务2
        queue.sync {
            for i in 0..<3{
                print("串行同步-2----\(i)-----\(Thread.current)---\(queue.label)")
            }
        }
        //同步任务3
        queue.sync {
            for i in 0..<3{
                print("串行同步-3----\(i)-----\(Thread.current)---\(queue.label)")
            }
        }
        print("主线程--执行-------\(Thread.current)---\(queue.label)")
    }
    
    @objc func asyncSerialAction(){
        print("串行异步----队列中的线程依次执行，同时主线程还在继续执行\n")
        
        ///串行队列
        let queue = DispatchQueue.init(label: "串行队列")
        //异步任务1
        queue.async {
            for i in 0..<3{
                print("串行异步-1----\(i)-----\(Thread.current)---\(queue.label)")
            }
        }
        //异步任务2
        queue.async {
            for i in 0..<3{
                print("串行异步-2----\(i)-----\(Thread.current)---\(queue.label)")
            }
        }
        //异步任务3
        queue.async {
            for i in 0..<3{
                print("串行异步-3----\(i)-----\(Thread.current)---\(queue.label)")
            }
        }
        print("主线程--执行-------\(Thread.current)---\(queue.label)")

    }

    @objc func syncConcurrentAction(){
        print("并行同步---队列中的线程，会一起执行，但是同一时段只能有一个线程执行其他线程等待，等所有任务执行完，主线程继续执行\n")
        
        ///并行队列
        let queue = DispatchQueue(label: "并行队列", attributes: .concurrent)
        
        //同步任务1
        queue.sync {
            for i in 0..<3{
                print("并行同步-1----\(i)-----\(Thread.current)---\(queue.label)")
            }
        }
        //同步任务2
        queue.sync {
            for i in 0..<3{
                print("并行同步-2----\(i)-----\(Thread.current)---\(queue.label)")
            }
        }
        //同步任务3
        queue.sync {
            for i in 0..<3{
                print("并行同步-3----\(i)-----\(Thread.current)---\(queue.label)")
            }
        }
        print("主线程--执行-------\(Thread.current)---\(queue.label)")
    }
    
    
    
    @objc func asyncConcurrentAction(){
        
        print("并行异步---队列中的线程，一起执行，主线程也会继续执行\n")

        ///并行队列
        let queue = DispatchQueue(label: "并行队列", attributes: .concurrent)
        
        //异步任务1
        queue.async {
            for i in 0..<3{
                print("并行异步-1----\(i)-----\(Thread.current)---\(queue.label)")
            }
        }
        //异步任务2
        queue.async {
            for i in 0..<3{
                print("并行异步-2----\(i)-----\(Thread.current)---\(queue.label)")
            }
        }
        //异步任务3
        queue.async {
            for i in 0..<3{
                print("并行异步-3----\(i)-----\(Thread.current)---\(queue.label)")
            }
        }
        print("主线程--执行--\(Thread.current)----\(queue.label)")
        
    }
    
    /*如果在主线程中运用主队列同步，也就是把任务放到了主线程的队列中。
     而同步对于任务是立刻执行的，那么当把第一个任务放进主队列时，它就会立马执行。
     可是主线程现在正在处理 syncMain 方法，任务需要等 syncMain 执行完才能执行。
     syncMain 执行到第一个任务的时候，又要等第一个任务执行完才能往下执行第二个和第三个任务。
     这样 syncMain 方法和第一个任务就开始了互相等待，形成了死锁。*/
    @objc private func syncMainAction(){
        ///全局队列
        let global = DispatchQueue.global()
        global.async {
            print("主队列同步---放到主线程会死锁")
            ///主队列（主队列是GCD自带的一种特殊的串行队列，放在主队列中得任务，都会放到主线程中执行。）
            let main = DispatchQueue.main
            ///同步任务1
            main.sync {
                for i in 0..<3{
                    print("主队列同步-1----\(i)-----\(Thread.current)---\(main.label)")
                }
            }
            print("主线程--执行-------\(Thread.current)---\(global.label)")
        }
    
    }
    
    
    @objc private func asyncMainAction(){
        print("主队列异步---异步执行虽然有开启新线程的能力, 但是异步执行 + 主队列并不会开启新的线程, 任务都是在主线程中执行的")
        ///主队列
        let main = DispatchQueue.main
        ///异步任务1
        main.async {
            for i in 0..<3{
                print("主队列异步-1----\(i)-----\(Thread.current)---\(main.label)")
            }
        }
        ///异步任务2
        main.async {
            for i in 0..<3{
                print("主队列异步-2----\(i)-----\(Thread.current)---\(main.label)")
            }
        }
        ///异步任务3
        main.async {
            for i in 0..<3{
                print("主队列异步-3----\(i)-----\(Thread.current)---\(main.label)")
            }
        }
        print("主线程--执行-------\(Thread.current)---\(main.label)")
    }
    
     @objc func syncGlobalAction(){
        ///全局队列
        let global = DispatchQueue.global()
        ///同步任务1
        global.sync {
            for i in 0..<3{
                print("全局队列同步-1----\(i)-----\(Thread.current)---\(global.label)")
            }
        }
        global.sync {
            for i in 0..<3{
                print("全局队列同步-2----\(i)-----\(Thread.current)---\(global.label)")
            }
        }
        global.sync {
            for i in 0..<3{
                print("全局队列同步-3----\(i)-----\(Thread.current)---\(global.label)")
            }
        }
        print("主线程--执行-------\(Thread.current)---\(global.label)")
    }
    
    
    @objc func asyncGlobalAction(){
        ///全局队列
        let global = DispatchQueue.global()
        ///异步任务1
        global.async {
            for i in 0..<3{
                print("全局队列异步-1----\(i)-----\(Thread.current)---\(global.label)")
            }
        }
        global.async {
            for i in 0..<3{
                print("全局队列异步-2----\(i)-----\(Thread.current)---\(global.label)")
            }
        }
        global.async {
            for i in 0..<3{
                print("全局队列异步-3----\(i)-----\(Thread.current)---\(global.label)")
            }
        }
        print("主线程--执行-------\(Thread.current)---\(global.label)")
    }
    
    @objc func threadComunicationAction(){
        //全局队列异步开启子线程，做耗时操作，
        DispatchQueue.global().async {
            print("(模拟，sleep3秒)---\(Thread.current)")
            //耗时操作
            Thread.sleep(forTimeInterval: 3.0)
            ///回到主线程主线程异步，
            DispatchQueue.main.async {
                print("---\(Thread.current)")
            }
        }
    }
    
    @objc func mGCDQueueGroupAction(){
        let group = DispatchGroup()
        let global = DispatchQueue.global()
        global.async(group: group, qos:.default, flags: []) {
            Thread.sleep(forTimeInterval: 3.0)
            for _ in 0...3 {
                print("耗时任务一\(Thread.current)")
            }
        }
        
        global.async(group: group, qos:.default, flags: []) {
            Thread.sleep(forTimeInterval: 1.0)
            for _ in 0...3 {
                print("耗时任务二\(Thread.current)")
            }
        }
        group.notify(queue: DispatchQueue.main) {
            print("两个任务都执行完成\(Thread.current)")
        }
    }
    
    
   
    @objc func barrierGCDAction(){
        let queue = DispatchQueue(label: "并行队列", attributes: .concurrent)
        queue.async {
            for _ in 0...3 {
                print("并发异步--1--\(Thread.current)")
            }
        }
        queue.async {
            for _ in 0...3 {
                print("并发异步--2--\(Thread.current)")
            }
        }
        queue.async(group: nil, qos: .default, flags: .barrier) {
            print("栅栏")
            print("******* 并发异步执行，34一定在12后面 *********--\(Thread.current)")
        }
        
        queue.async {
            for _ in 0...3 {
                print("并发异步--3--\(Thread.current)")
            }
        }
        queue.async {
            for _ in 0...3 {
                print("并发异步--4--\(Thread.current)")
            }
        }
        print("主线程执行----\(Thread.current)")

    }
    
    @objc func semaphoreAction(){
        /*信号量其实就是用来保证访问资源的线程数，当信号量大于等于1时，资源可以访问，否则无法访问资源，直到其它线程释放资源。*/
        let semaphore = DispatchSemaphore(value: 2)//创建信号量value为初始信号量；剩余车位
        
        /*返回值为long类型，当返回值为0时，表示当前并没有线程等待其处理的信号量，其处理的信号总量增加1。
         当返回值不为0时，表示其当前有一个或者多个线程等待其处理的信号量，并且该函数唤醒了一个等待的线程（当线程有优先级的时候，唤醒优先级最高的线程，否则随机唤醒）。相当于走了一辆车*/
        
        /*等待信号，具体操作是首先判断信号量desema是否大于0，如果大于0就减掉1个信号，往下执行；
         如果等于0函数就阻塞该线程等待timeout（注意timeout类型为dispatch_time_t）时，其所处线程自动执行其后的语句。就相当于来了一辆车*/
        
        ///保证同一时间执行的线程数不超过2
        let global = DispatchQueue.global()
        global.async {
            semaphore.wait()
            Thread.sleep(forTimeInterval: 2.0)
            print("waiting2s后...")
            semaphore.signal()
            print("任务1执行完毕")///信号量
        }
        
        global.async {
            semaphore.wait()
            Thread.sleep(forTimeInterval: 2.0)
            print("waiting2s后...")
            semaphore.signal()
            print("任务2执行完毕")///信号量
        }
        
        global.async {
            semaphore.wait()
            Thread.sleep(forTimeInterval: 2.0)
            print("waiting2s后...")
            semaphore.signal()
            print("任务3执行完毕")///信号量
        }
        
    }
    
    
    
}


















