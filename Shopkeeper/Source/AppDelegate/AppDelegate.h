//
//  AppDelegate.h
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/12.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) RouterModel *model;
@property (strong, nonatomic) UIWindow *window;
- (void)showLogin;
- (void)showTBC;

@end

