//
//  secViewController.h
//  HZSigmentView
//
//  Created by 王会洲 on 16/6/3.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol secViewControllerDelegate <NSObject>

-(void)didselectIndex:(NSInteger )indexRow;

@end


@interface secViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) id<secViewControllerDelegate>  delegae;

@end
