//
//  JACycleNoticeView.h
//  IPhone2018
//
//  Created by Ja on 2019/5/20.
//  Copyright © 2019 gw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JACycleNoticeView,JACycleNoticeItem;

@protocol JACycleNoticeViewDelegete <NSObject>

@optional

- (void)ja_noticeView:(JACycleNoticeView*)noticeView didSelectedItemAtIndex:(NSInteger)index;
- (void)detailAction;

@end

@interface JACycleNoticeView : UIView

- (instancetype)initWithFrame:(CGRect)frame noticeItems:(NSArray<JACycleNoticeItem*>*)items delegate:(id<JACycleNoticeViewDelegete>)delegate;

/*
 * 数据源数组
 */
@property (nonatomic,strong) NSMutableArray *noticeItems;

/*
 * 代理
 */
@property (nonatomic,weak) id<JACycleNoticeViewDelegete> delegate;

//是否开启轮播 默认NO 不开启
@property (nonatomic,assign) BOOL cycleScrollEnabled;

@end


/* 数据modl */
@interface JACycleNoticeItem : NSObject

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *urlString;

@end
