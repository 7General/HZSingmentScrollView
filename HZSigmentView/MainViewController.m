//
//  MainViewController.m
//  HZSigmentView
//
//  Created by 王会洲 on 16/5/26.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#define SCRWIDTH [UIScreen mainScreen].bounds.size.width
#define SCRHEIGHT [UIScreen mainScreen].bounds.size.height

#import "MainViewController.h"
#import "HZSigmentScrollView.h"
#import "secViewController.h"
#import "firstViewController.h"
#import "ThirdViewController.h"
#import "FourViewController.h"
#import "TestViewController.h"



@interface MainViewController ()<secViewControllerDelegate>
@property (nonatomic, strong) HZSigmentScrollView * SingmentScrollView;
@property (nonatomic, strong) firstViewController * fisrstVC;
@property (nonatomic, strong) secViewController * secVC;
@property (nonatomic, strong) ThirdViewController * thirdVC;
@property (nonatomic, strong) FourViewController * fourVC;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"HZSigmentView";
    
////    NSLog(@"------%ld",self.navigationController.navigationBar.translucent);
//    // 原点从（0，64）开始
////    self.navigationController.navigationBar.translucent = NO;
//    // 原点从（0，0）开始
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    
//    // ###########################################
//    // 原点从（0，64）开始
    self.automaticallyAdjustsScrollViewInsets = NO;
//    //self.edgesForExtendedLayout = UIRectEdgeNone;
//
//    
//    self.sigment = [[HZSigmentView alloc] initWithOrgin:CGPointMake(0, 64) andHeight:44];
//    self.sigment.delegate = self;
//    self.sigment.titleArry = @[@"核桃",@"苹果"];
    
    // 设置标题选中时的颜色
//    self.sigment.titleColorSelect = DDMColor(155, 0, 10);
    // 设置标题未选中的颜色
//    self.sigment.titleColorNormal = [UIColor redColor];
    // 默认选中第几项
    //self.sigment.defaultIndex = 2;
    // 设置标题字体大小
//    self.sigment.titleFont = [UIFont systemFontOfSize:9];
    
//    self.sigment.bottomLineColor = [UIColor yellowColor];
//    self.sigment.titleLineColor = [UIColor grayColor];
//    [self.view addSubview:self.sigment];

    self.fisrstVC = [[firstViewController alloc] init];
    self.secVC = [[secViewController alloc] init];
    self.secVC.delegae = self;
    self.thirdVC = [[ThirdViewController alloc] init];
    self.fourVC = [[FourViewController alloc] init];
    
    self.SingmentScrollView = [[HZSigmentScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height)];
    // 设置标题
    self.SingmentScrollView.titleScrollArrys = @[@"核桃",@"苹果",@"香蕉",@"荔枝"].mutableCopy;
    // 设置控制器
    self.SingmentScrollView.titleControllerArrys = @[self.fisrstVC,self.secVC,self.thirdVC,self.fourVC].mutableCopy;
    [self.view addSubview:self.SingmentScrollView];
    
}

-(void)didselectIndex:(NSInteger)indexRow {
    NSLog(@"----%ld",indexRow);
    TestViewController * test = [[TestViewController alloc] init];
    [self.navigationController pushViewController:test animated:YES];
}

//-(void)segment:(HZSigmentView *)sengment didSelectColumnIndex:(NSInteger)index {
//    NSLog(@"-----%ld",index);
//}



@end
