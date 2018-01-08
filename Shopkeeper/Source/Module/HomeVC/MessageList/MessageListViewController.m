//
//  MessageListViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/2.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MessageListViewController.h"

@interface MessageListViewController ()

@end

@implementation MessageListViewController

- (void)viewDidLoad
{
    self.customBackTitle = @"聊聊";
    self.leftButtonTitle = @"返回";
    self.url = [self pathAppendBaseURL:@"/api/app/message/myMessage/0"];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
