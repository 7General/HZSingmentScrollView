//
//  HZSigmentScrollView.m
//  HZSigmentView
//
//  Created by 王会洲 on 16/6/3.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "HZSigmentScrollView.h"




@interface HZSigmentScrollView()<HZSigmentViewDelegate>
/**操作console*/
@property (nonatomic, strong) UIScrollView * BackScrollView;
@property (nonatomic, strong) HZSigmentView * sigmentView;
@property (nonatomic, assign) NSInteger  selectIndex;


/**监听滑动类型*/
@property (nonatomic, assign) BOOL  ScrollViewOffsetType;


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
        _BackScrollView.showsVerticalScrollIndicator = NO;
        _BackScrollView.showsHorizontalScrollIndicator = NO;
        
//        _BackScrollView.backgroundColor = [UIColor lightGrayColor];
        
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
        self.selectIndex = 0;
        [self addSubview:self.sigmentView];
        self.sigmentView.delegate = self;
        [self addSubview:self.BackScrollView];
        [self registerForKVO];
    }
    return self;
}

-(void)registerForKVO {
    for (NSString *keyPath in [self observableKeypaths]) {
        [self addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:NULL];
    }
}
- (NSArray *)observableKeypaths {
    return [NSArray arrayWithObjects: @"SelectDefaultIndex", nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    [self updateUIForKeypath:keyPath];
}
/**观察改变属性*/
- (void)updateUIForKeypath:(NSString *)keyPath {
    if([keyPath isEqualToString:@"SelectDefaultIndex"]) {
        /**1：改变item默认选项*/
//        self.sigmentView.defaultIndex = self.SelectDefaultIndex;
//        self.ScrollViewOffsetType = YES;
//        /**2：改变下划线位置默认选项*/
//        [self.sigmentView selectDefaultBottomAndVC:self.SelectDefaultIndex];
        /**3：改变内容*/
//        [self.BackScrollView setContentOffset:CGPointMake(DDMWIDTH * (self.SelectDefaultIndex-1), 0) animated:YES];
    }
}

- (void)dealloc {
    [self unregisterFromKVO];
}
- (void)unregisterFromKVO {
    for (NSString *keyPath in [self observableKeypaths]) {
        [self removeObserver:self forKeyPath:keyPath];
    }
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
        id  ctrol = titleControllerArrys[index];
        UIViewController * vcCtrol = (UIViewController *)ctrol;
        vcCtrol.view.frame = CGRectMake(index * DDMWIDTH, 0, DDMWIDTH, DDMHEIGHT - CGRectGetMaxY(self.sigmentView.frame));
        [self.BackScrollView addSubview:vcCtrol.view];
    }
}

-(void)segment:(HZSigmentView *)sengment didSelectColumnIndex:(NSInteger)index {
    [self.BackScrollView setContentOffset:CGPointMake(DDMWIDTH * (index-1), 0) animated:YES];
    self.ScrollViewOffsetType = NO;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger scrollIndex =  (scrollView.contentOffset.x + DDMWIDTH * 0.5) / DDMWIDTH;
    if (self.selectIndex != scrollIndex && self.ScrollViewOffsetType) {
        [self.sigmentView scrollMenuViewSelectedoffsetX:scrollIndex withOffsetType:self.ScrollViewOffsetType];
        self.selectIndex = scrollIndex;
    }
}


//开始拖拽视图
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.ScrollViewOffsetType = YES;
}

@end
