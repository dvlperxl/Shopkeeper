//
//  ShopkeeperBorrowViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/30.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "ShopkeeperBorrowViewController.h"

@interface ShopkeeperBorrowViewController ()

@end

@implementation ShopkeeperBorrowViewController

- (void)viewDidLoad {
    
    NSString *url = [self pathAppendBaseURL:@"/api/pages/posLoan/posLoan.html"];
    self.url = [self urlAppendBaseParam:url];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"贷款记录" style:UIBarButtonItemStylePlain target:self action:@selector(onRightButtonAction)];
}

- (void)onRightButtonAction
{
    NSString *url = [self pathAppendBaseURL:@"/api/pages/posLoan/loanRecord.html"];// /api/pages/expertAppointment/index.html
    url = [self urlAppendBaseParam:url];
    [[CMRouter sharedInstance]showViewController:@"WebViewController" param:@{@"url":url}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
