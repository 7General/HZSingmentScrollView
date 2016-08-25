//
//  HZSigmentScrollView.h
//  HZSigmentView
//
//  Created by 王会洲 on 16/6/3.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZSigmentView.h"



@interface HZSigmentScrollView : UIView<UIScrollViewDelegate>

/**控制器Arry*/
@property (nonatomic, strong) NSMutableArray * titleControllerArrys;

/**标题Arry*/
@property (nonatomic, strong) NSMutableArray * titleScrollArrys;

/**设置选中的item，用于其他页面跳转至改页面是，item、下划线、vc保持一致*/
@property (nonatomic, assign) NSInteger  SelectDefaultIndex;

@end
