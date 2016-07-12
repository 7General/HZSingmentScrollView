//
//  HZSigmentScrollView.h
//  HZSigmentView
//
//  Created by 王会洲 on 16/6/3.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface HZSigmentScrollView : UIView<UIScrollViewDelegate>

/**控制器Arry*/
@property (nonatomic, strong) NSMutableArray * titleControllerArrys;

/**标题Arry*/
@property (nonatomic, strong) NSMutableArray * titleScrollArrys;

@end
