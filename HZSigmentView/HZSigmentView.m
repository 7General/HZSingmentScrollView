//
//  HZSigmentView.m
//  HZSigmentView
//
//  Created by 王会洲 on 16/5/26.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "HZSigmentView.h"

@interface HZSigmentView()
// 高度
@property (nonatomic, assign) CGFloat  menuHeight;


@property (nonatomic,strong) NSMutableArray * btnArrys;

@property (nonatomic,strong) UIButton * titleBtn;
@property (nonatomic,strong) UIScrollView * BackScrollView;
@property (nonatomic,strong) UIView * bottomLine;
@property (nonatomic,assign) CGFloat btnWidth;

@end

@implementation HZSigmentView


-(instancetype)initWithOrgin:(CGPoint)origin andHeight:(CGFloat)height {
    self = [super initWithFrame:CGRectMake(origin.x, origin.y, DDMWIDTH, height)];
    if (self) {
        self.menuHeight = height;
        self.defaultIndex = 1;
        self.translatesAutoresizingMaskIntoConstraints = YES;
        self.titleFont = [UIFont systemFontOfSize:15];
        self.btnArrys = [[NSMutableArray alloc] initWithCapacity:0];
        self.titleColorNormal = DDMColor(80, 80, 80);
        self.titleColorSelect = DDMColor(30, 137, 255);
        self.bottomLineColor = DDMColor(214, 214, 214);
        self.titleLineColor = DDMColor(0, 96, 255);
        
        self.BackScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DDMWIDTH, self.menuHeight)];
        self.BackScrollView.backgroundColor = DDMColor(255, 0, 0);
        self.BackScrollView.showsHorizontalScrollIndicator = NO;
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
    return [NSArray arrayWithObjects: @"titleColorNormal", @"titleColorSelect", @"titleFont", @"defaultIndex",@"bottomLineColor",@"titleLineColor", nil];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    [self updateUIForKeypath:keyPath];
}
/**观察改变属性*/
- (void)updateUIForKeypath:(NSString *)keyPath {
    if([keyPath isEqualToString:@"titleColorNormal"])
    {
        [self updaeViewUI:^(UIButton *btn) {
            [btn setTitleColor:self.titleColorNormal forState:UIControlStateNormal];
        }];
    }else if([keyPath isEqualToString:@"titleColorSelect"])
    {
        [self updaeViewUI:^(UIButton *btn) {
            [btn setTitleColor:self.titleColorSelect forState:UIControlStateSelected];
        }];
    }else if([keyPath isEqualToString:@"titleFont"])
    {
        [self updaeViewUI:^(UIButton *btn) {
            [btn.titleLabel setFont:self.titleFont];
        }];
        
    }else if([keyPath isEqualToString:@"defaultIndex"])
    {
        [self updaeViewUI:^(UIButton *btn) {
            if (btn.tag-1 == self.defaultIndex-1) {
                self.titleBtn=btn;
                btn.selected=YES;
            }else{
                btn.selected=NO;
            }
        }];
    }else if([keyPath isEqualToString:@"bottomLineColor"]){
        UIView * line = [self viewWithTag:1100];
        line.backgroundColor = self.bottomLineColor;
    } else if([keyPath isEqualToString:@"titleLineColor"]) {
       self.bottomLine.backgroundColor = self.titleLineColor;
    }
    [self setNeedsLayout];
    [self setNeedsDisplay];
}


-(void)updaeViewUI:(void(^)(UIButton * btn))complated {
    for (UIButton *btn in self.btnArrys) {
        [btn setTitleColor:self.titleColorNormal forState:UIControlStateNormal];
        [btn setTitleColor:self.titleColorSelect forState:UIControlStateSelected];
        btn.titleLabel.font=self.titleFont;
        if (complated) {
           complated(btn);
        }
    }
}

-(void)dealloc {
    [self unregisterFromKVO];
}
- (void)unregisterFromKVO {
    for (NSString *keyPath in [self observableKeypaths]) {
        [self removeObserver:self forKeyPath:keyPath];
    }
}

/**懒加载底部横线*/
-(UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.menuHeight - BottomLineHeight, self.btnWidth, BottomLineHeight)];
        _bottomLine.backgroundColor = self.titleLineColor;
        [_BackScrollView addSubview:_bottomLine];
    }
    return _bottomLine;
}


/**画标题*/
-(void)setTitleArry:(NSArray *)titleArry {
    if (!titleArry) return;
    
    _titleArry = titleArry;
    if (_titleArry.count < 6) {
        self.btnWidth = DDMWIDTH / _titleArry.count;
    }else{
        self.btnWidth = DDMWIDTH / 5;
    }
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.menuHeight - BottomLineHeight, self.btnWidth * _titleArry.count, BottomLineHeight)];
    line.backgroundColor = self.bottomLineColor;
    line.tag = 1100;
    [self.BackScrollView addSubview:line];
    

    // 重置横线位置
    [UIView animateWithDuration:0.15 animations:^{
        self.bottomLine.frame = CGRectMake(0, self.menuHeight - BottomLineHeight, self.btnWidth, BottomLineHeight);
    }];
    
    self.BackScrollView.contentSize = CGSizeMake(self.btnWidth * _titleArry.count, self.menuHeight);
    
    for (int i=0; i<_titleArry.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(self.btnWidth * i, 0, self.btnWidth, self.menuHeight - BottomLineHeight);
        btn.tag = i + 1;
        [btn setTitle:_titleArry[i] forState:UIControlStateNormal];
        [btn setTitleColor:self.titleColorNormal forState:UIControlStateNormal];
        [btn setTitleColor:self.titleColorSelect forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnTitleClick:) forControlEvents:UIControlEventTouchDown];
        // 这里设置修改标题栏的背景颜色
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.titleLabel.font = _titleFont;
        [self.BackScrollView addSubview:btn];
        
        [self.btnArrys addObject:btn];
        if (i == 0) {
            _titleBtn = btn;
            btn.selected = YES;
        }
    }
}
#pragma mark - title点击事件
-(void)btnTitleClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(segment:didSelectColumnIndex:)]) {
        [self.delegate segment:self didSelectColumnIndex:sender.tag];
    }
    
    if (sender.tag == self.defaultIndex) {
        return;
    }else{
        self.titleBtn.selected = NO;
        sender.selected = YES;
        self.titleBtn = sender;
        self.defaultIndex = sender.tag;
    }
    //计算偏移量
    CGFloat offsetX = sender.frame.origin.x - 2 * self.btnWidth;
    if (offsetX<0) {
        offsetX=0;
    }
    CGFloat maxOffsetX= self.BackScrollView.contentSize.width - DDMWIDTH;
    if (offsetX>maxOffsetX) {
        offsetX=maxOffsetX;
    }
    [UIView animateWithDuration:0.15 animations:^{
        [self.BackScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        self.bottomLine.frame=CGRectMake(sender.frame.origin.x, self.frame.size.height - BottomLineHeight, sender.frame.size.width, BottomLineHeight);
    }];

}

-(void)selectDefaultBottomAndVC:(NSInteger)DefaultIndex {
    UIButton * sender = [self.btnArrys objectAtIndex:DefaultIndex - 1];
    //计算偏移量
    CGFloat offsetX = sender.frame.origin.x - 2 * self.btnWidth;
    if (offsetX<0) {
        offsetX=0;
    }
    CGFloat maxOffsetX= self.BackScrollView.contentSize.width - DDMWIDTH;
    if (offsetX>maxOffsetX) {
        offsetX=maxOffsetX;
    }
    [UIView animateWithDuration:0.15 animations:^{
        [self.BackScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        self.bottomLine.frame=CGRectMake(sender.frame.origin.x, self.frame.size.height - BottomLineHeight, sender.frame.size.width, BottomLineHeight);
    }];
}




- (void)scrollMenuViewSelectedoffsetX:(NSInteger)selectIndex withOffsetType:(BOOL)types {
    // 默认选中
    self.defaultIndex = selectIndex + 1;
    //计算偏移量
    CGFloat offsetX = (selectIndex - 2) * self.btnWidth;
    if (offsetX<0) {
        offsetX=0;
    }
    CGFloat maxOffsetX= self.BackScrollView.contentSize.width - DDMWIDTH;
    if (offsetX>maxOffsetX) {
        offsetX=maxOffsetX;
    }
    [UIView animateWithDuration:0.25 animations:^{
        [self.BackScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        if (types) {
            self.bottomLine.frame=CGRectMake(selectIndex * self.btnWidth , self.menuHeight - BottomLineHeight, self.btnWidth, BottomLineHeight);
        }
    }];

}

@end
