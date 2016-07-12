//
//  secViewController.m
//  HZSigmentView
//
//  Created by 王会洲 on 16/6/3.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "secViewController.h"
#import "TestViewController.h"


@interface secViewController ()

@property (nonatomic, strong) UITableView * myTableView;



@end

@implementation secViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"1555");
    self.view.backgroundColor = [UIColor yellowColor];
    self.title = @"4444444";
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    [self.view addSubview:self.myTableView];
    
}


//-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat tableOffectY = self.myTableView.contentOffset.y;
//    NSLog(@"=========%f",tableOffectY);
//}

#pragma mark -TABLEVIEW DELEGATE
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = @"AAAAAAAAAAAAAA";
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,");
    
    if (self.delegae && [self.delegae respondsToSelector:@selector(didselectIndex:)]) {
        [self.delegae didselectIndex:indexPath.row];
    }
}

@end
