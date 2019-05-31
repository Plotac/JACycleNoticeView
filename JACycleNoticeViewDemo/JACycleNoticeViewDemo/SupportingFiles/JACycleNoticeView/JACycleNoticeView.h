//
//  JACycleNoticeView.h
//  IPhone2018
//
//  Created by Ja on 2019/5/20.
//  Copyright © 2019 gw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JACycleNoticeView;

@protocol JACycleNoticeViewDelegete <NSObject>

@optional

- (void)ja_noticeView:(JACycleNoticeView*)noticeView didSelectedItemAtIndex:(NSInteger)index;
- (void)detailAction;

@end

@interface JACycleNoticeView : UIView

- (instancetype)initWithFrame:(CGRect)frame noticeItems:(NSArray<NSString*>*)items delegate:(id<JACycleNoticeViewDelegete>)delegate;

@property (nonatomic,strong) NSMutableArray *noticeItems;

@property (nonatomic,weak) id<JACycleNoticeViewDelegete> delegate;

//是否开启轮播 默认NO 不开启
@property (nonatomic,assign) BOOL cycleScrollEnabled;

@end


@interface JACycleNoticeItem : NSObject

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *urlString;

@end
