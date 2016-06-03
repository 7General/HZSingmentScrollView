//
//  HZSigmentScrollView.m
//  HZSigmentView
//
//  Created by 王会洲 on 16/6/3.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "HZSigmentScrollView.h"
#import "HZSigmentView.h"

@interface HZSigmentScrollView()<HZSigmentViewDelegate>
/**操作console*/
@property (nonatomic, strong) UIScrollView * BackScrollView;

@property (nonatomic, strong) HZSigmentView * sigmentView;
@end

@implementation HZSigmentScrollView
-(HZSigmentView *)sigmentView {
    if (!_sigmentView) {
        _sigmentView = [[HZSigmentView alloc] initWithOrgin:CGPointMake(0, 0) andHeight:44];
    }
    return _sigmentView;
}

-(UIScrollView *)BackScrollView {
    if (!_BackScrollView) {
        _BackScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_sigmentView.frame), DDMWIDTH, DDMHEIGHT - CGRectGetMaxY(_sigmentView.frame))];
        _BackScrollView.backgroundColor = [UIColor brownColor];
        _BackScrollView.showsVerticalScrollIndicator = NO;
        _BackScrollView.showsHorizontalScrollIndicator = NO;
        _BackScrollView.delegate = self;
        _BackScrollView.bounces = NO;
        _BackScrollView.pagingEnabled = YES;
    }
    return _BackScrollView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.sigmentView];
        self.sigmentView.delegate = self;
        [self addSubview:self.BackScrollView];
    }
    return self;
}
-(void)setTitleScrollArrys:(NSMutableArray *)titleScrollArrys {
    if (_titleControllerArrys == titleScrollArrys) {
        return;
    }
    _sigmentView.titleArry = titleScrollArrys;
}


-(void)setTitleControllerArrys:(NSMutableArray *)titleControllerArrys {
    if (_titleControllerArrys == titleControllerArrys) {
        return;
    }
    NSInteger scrollCount = titleControllerArrys.count;
     _BackScrollView.contentSize=CGSizeMake(DDMWIDTH * scrollCount, self.bounds.size.height-_sigmentView.bounds.size.height);
    for (NSInteger index = 0; index < scrollCount; index++) {
        
        NSString *className = titleControllerArrys[index];
        Class class = NSClassFromString(className);
        if (class) {
            UIViewController *ctrl = class.new;
            ctrl.view.frame = CGRectMake(index * DDMWIDTH, 1, DDMWIDTH, DDMHEIGHT - CGRectGetMaxY(self.sigmentView.frame));
            [self.BackScrollView addSubview:ctrl.view];
        }
    }
}

-(void)segment:(HZSigmentView *)sengment didSelectColumnIndex:(NSInteger)index {
    [self.BackScrollView setContentOffset:CGPointMake(DDMWIDTH* (index-1), 0) animated:YES];
}

@end
