//
//  ViewController.m
//  RAC
//
//  Created by 花生 on 16/6/20.
//  Copyright © 2016年 花生. All rights reserved.
//

#import "ViewController.h"
#import "ReactiveCocoa.h"
#import "MessageViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)goVC{
    MessageViewController * VC = [[MessageViewController alloc]init];
    RACSubject * subject = [RACSubject subject];
    [subject subscribeNext:^(id x) {
        NSLog(@"MessageViewController发过来的消息%@",x);
        self.view.backgroundColor = [UIColor greenColor];
    }];
    VC.subject = subject;
    [self presentViewController:VC animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton * button = [[UIButton alloc]initWithFrame:self.view.bounds];
    [button addTarget:self action:@selector(goVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    RACCommand * command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"%@",input);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@1];
            return nil;
        }];
    }];
    
    [command.executionSignals subscribeNext:^(id x) {
        [x subscribeNext:^(id x) {
            NSLog(@"%@",x);
        }];
    }];
    
    [command execute:@1];
    
//    RACReplaySubject * subject = [RACReplaySubject subject];
//    [subject subscribeNext:^(id x) {
//        NSLog(@"====:%@",x);
//    }];
//    
////    [subject subscribeNext:^(id x) {
////        NSLog(@"+++++:%@",x);
////    }];
//    [subject sendNext:@10];
//    [subject sendNext:@20];
    
    
//    RACSignal * signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        NSLog(@"调用了RACSignal");
//        [subscriber sendNext:@"hello world"];
//        return [RACDisposable disposableWithBlock:^{
//            NSLog(@"取消订阅");
//        }];
//    }];
//    
//    RACDisposable * disposable = [signal subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];
//    
//    [disposable dispose];
    
    //RACSubject 信号提供者
//    RACSubject * subject = [RACSubject subject];
//    
//    [subject subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];
//    
//    [subject sendNext:@"1"];
 
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
