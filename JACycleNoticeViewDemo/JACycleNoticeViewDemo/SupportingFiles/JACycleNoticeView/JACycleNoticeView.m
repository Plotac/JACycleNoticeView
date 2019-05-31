//
//  JACycleNoticeView.m
//  IPhone2018
//
//  Created by Ja on 2019/5/20.
//  Copyright © 2019 gw. All rights reserved.
//
//  高度35
#import "JACycleNoticeView.h"
#import "JAUtilities.h"

@interface JACycleNoticeView ()

@property (nonatomic,retain) UILabel *firstLab;
@property (nonatomic,retain) UILabel *secondLab;

@property (nonatomic,retain) NSTimer *timer;

@end

@implementation JACycleNoticeView

- (instancetype)initWithFrame:(CGRect)frame noticeItems:(NSArray<NSString*> *)items delegate:(id<JACycleNoticeViewDelegete>)delegate {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColorFromHexStr(@"#f3f5f7");
        
        if (items) {
           self.noticeItems = [NSMutableArray arrayWithArray:items];
        }
        self.delegate = delegate;
        
        [self initViews];
        
        self.cycleScrollEnabled = NO;
    }
    return self;
}

- (void)initViews {

    UIImageView *headerImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"notice"]];
    headerImg.frame = CGRectMake(15, 0, 55, 35);
    [self addSubview:headerImg];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headerImg.frame) + 10, 5, 1, 25)];
    line.backgroundColor = UIColorFromHexStr(@"#999999");
    [self addSubview:line];
    
    UIButton *detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    detailBtn.frame = CGRectMake(self.bounds.size.width - 15 - 45, 2.5, 45, 30);
    [detailBtn setTitle:@"详情" forState:UIControlStateNormal];
    [detailBtn setTitleColor:UIColorFromHexStr(@"#3682ff") forState:UIControlStateNormal];
    detailBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [detailBtn addTarget:self action:@selector(detailAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:detailBtn];

    self.firstLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(line.frame) + 10, 2.5, self.bounds.size.width - CGRectGetMaxX(line.frame) - 10 - 45 - 15, 30)];
    self.firstLab.textColor = UIColorFromHexStr(@"#666666");
    self.firstLab.font = [UIFont systemFontOfSize:15];
    self.firstLab.userInteractionEnabled = YES;
    [self addSubview:self.firstLab];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.firstLab addGestureRecognizer:tap1];
    
    self.secondLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(line.frame) + 10, 45, self.bounds.size.width - CGRectGetMaxX(line.frame) - 10 - 45 - 15, 30)];
    self.secondLab.textColor = self.firstLab.textColor;
    self.secondLab.font = self.firstLab.font;
    self.secondLab.userInteractionEnabled = YES;
    self.secondLab.hidden = YES;
    [self addSubview:self.secondLab];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.secondLab addGestureRecognizer:tap2];
}

#pragma mark - Setter
- (void)setNoticeItems:(NSMutableArray *)noticeItems {
    _noticeItems = noticeItems;
    if (_cycleScrollEnabled) {
        self.secondLab.hidden = NO;
        [self performSelector:@selector(setupTimer) withObject:nil afterDelay:1];
    }else {
        self.firstLab.text = [[self.noticeItems firstObject] title];
    }
}

- (void)setCycleScrollEnabled:(BOOL)cycleScrollEnabled {
    _cycleScrollEnabled = cycleScrollEnabled;
    if (_cycleScrollEnabled) {
        self.secondLab.hidden = NO;
        [self performSelector:@selector(setupTimer) withObject:nil afterDelay:1];
    }else {
        self.firstLab.text = [[self.noticeItems firstObject] title];
    }
}

#pragma mark - Actions
static int count = 0;
- (void)timerEvent:(NSTimer*)timer {
    
    JACycleNoticeItem *item = [self.noticeItems objectAtIndex:count%self.noticeItems.count];
    NSString *title = item.title;
    if (count % 2 == 0) {
        self.secondLab.text = title;
    }else {
        self.firstLab.text = title;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        if (count % 2 == 0) {
            self.firstLab.originY = -45;
            self.secondLab.originY = 2.5;
            self.secondLab.hidden = NO;
        }else {
            self.firstLab.originY = 2.5;
            self.secondLab.originY = -45;
            self.firstLab.hidden = NO;
        }

    } completion:^(BOOL finished) {
        if (count % 2 == 0) {
            self.firstLab.originY = 45;
            self.firstLab.hidden = YES;
        }else {
            self.secondLab.originY = 45;
            self.secondLab.hidden = YES;
        }
        
        count ++;
    }];
}

- (void)tapAction:(UITapGestureRecognizer*)tap {
    UIView *tapView = tap.view;
    if ([tapView isKindOfClass:[UILabel class]]) {
        UILabel *clickLab = (UILabel*)tapView;
        NSString *title = clickLab.text;
        for (NSInteger i=0; i<self.noticeItems.count; i++) {
            JACycleNoticeItem *item = [self.noticeItems objectAtIndex:i];
            if ([title isEqualToString:item.title]) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(ja_noticeView:didSelectedItemAtIndex:)]) {
                    [self.delegate ja_noticeView:self didSelectedItemAtIndex:i];
                }
                return;
            }
        }
    }
}

- (void)detailAction:(UIButton*)sender {
    count = 0;
    if (self.delegate && [self.delegate respondsToSelector:@selector(detailAction)]) {
        [self.delegate detailAction];
    }
}

#pragma mark - Timer
- (void)setupTimer {
    if (!self.timer && self.noticeItems.count > 1) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerEvent:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        [self.timer fire];
    }
}

- (void)destroyTimer {
    if (self.timer && [self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end


@implementation JACycleNoticeItem

- (instancetype)init {
    self = [super init];
    if (self) {

        self.title = @"";
        self.urlString = @"";

    }
    return self;
}
@end
