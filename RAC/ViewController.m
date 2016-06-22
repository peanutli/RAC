//
//  ViewController.m
//  RAC
//
//  Created by 花生 on 16/6/20.
//  Copyright © 2016年 花生. All rights reserved.
//

#import "ViewController.h"
#import "ReactiveCocoa.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RACSignal * signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"调用了RACSignal");
        [subscriber sendNext:@"hello world"];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"取消订阅");
        }];
    }];
    
    RACDisposable * disposable = [signal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    [disposable dispose];
 
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
