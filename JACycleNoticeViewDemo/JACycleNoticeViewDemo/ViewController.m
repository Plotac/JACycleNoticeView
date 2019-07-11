//
//  ViewController.m
//  JACycleNoticeViewDemo
//
//  Created by Ja on 2019/5/31.
//  Copyright © 2019 Ja. All rights reserved.
//

#import "ViewController.h"
#import "JACycleNoticeView.h"

@interface ViewController ()<JACycleNoticeViewDelegete>

@property (nonatomic,strong) JACycleNoticeView *noticeView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"JACycleNoticeViewDemo";
    
    NSArray *titles = @[
                        @"1.苹果削减老款iPhone产量 新款iPhone按计划生产",
                        @"2.如果你的iPhone丢了 马上做这3件事保证不后悔",
                        @"3.为什么中国换新 iPhone 的用户越来越少了?",
                        @"4.花5000买iPhoneXR?还是花同样钱买一台国产旗舰?",
                        @"5.iPhone8Plus评测 依然是史上最好用的iPhone"
                        ];
    
    NSArray *urls = @[
                      @"https://baijiahao.baidu.com/s?id=1634913731033612993&wfr=spider&for=pc",
                      @"https://baijiahao.baidu.com/s?id=1634866318995813977&wfr=spider&for=pc",
                      @"https://baijiahao.baidu.com/s?id=1622087414108388073&wfr=spider&for=pc",
                      @"https://baijiahao.baidu.com/s?id=1634800605918987230&wfr=spider&for=pc",
                      @"http://www.elecfans.com/d/834088.html"
                      ];
    NSMutableArray *noticeItems = @[].mutableCopy;
    for (NSInteger i=0; i<titles.count; i++) {
        JACycleNoticeItem *item = [JACycleNoticeItem new];
        item.title = titles[i];
        item.urlString = urls[i];
        [noticeItems addObject:item];
    }
    
    self.noticeView = [[JACycleNoticeView alloc]initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 35) noticeItems:noticeItems delegate:self];
//    self.noticeView.noticeItems = noticeItems;
    self.noticeView.cycleScrollEnabled = YES;
    [self.view addSubview:self.noticeView];
    
}

#pragma mark - JACycleNoticeViewDelegete
- (void)ja_noticeView:(JACycleNoticeView *)noticeView didSelectedItemAtIndex:(NSInteger)index {
    JACycleNoticeItem *item = [noticeView.noticeItems objectAtIndex:index];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:item.urlString] options:@{} completionHandler:nil];
}

- (void)detailAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"Detail Action" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
