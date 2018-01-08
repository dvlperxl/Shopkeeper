//
//  RootTBC.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/12.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "RootTBC.h"
#import "BaseNavigationController.h"
#import "APIService.h"
#import "UserBaseInfo.h"
#import "AppDelegate.h"
#import "WorkStoreModel.h"
#import "KKNetworkReachabilityManager.h"
#import "JPush.h"

@interface RootTBC ()<UITabBarControllerDelegate>

@end

@implementation RootTBC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.backgroundColor = [UIColor clearColor];
    UIImage *image = [UIImage createImageWithColor:ColorWithRGB(253, 253, 253, 1)];
    self.tabBar.backgroundImage = image;
    self.delegate = self;
    [self initSubviews];
    [self httpRequestQueryUserInfo];
    [self httpRequestServerCustomProperty];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (appDelegate.model) {
        
        [self showNativePage:appDelegate.model];
        appDelegate.model = nil;
    }
}
- (void)showNativePage:(RouterModel *)routerModel
{
    if ([routerModel.className isEqualToString:@"WebViewController"])
    {
        NSString *url = routerModel.param[@"url"];
        url = [self pathAppendBaseURL:url];
        url = [self urlAppendBaseParam:url];
        NSMutableDictionary *param = @{}.mutableCopy;
        [param setObject:url forKey:@"url"];
        routerModel.param = param.copy;
    }
    [[CMRouter sharedInstance]showViewControllerWithRouterModel:routerModel];
}

- (void)httpRequestQueryUserInfo
{
    NSString *mobile = [KeyChain getMobileNo];
    [[APIService share]httpRequestQueryUserWithMobile:mobile
                                              success:^(NSDictionary *responseObject) {
                                                  
                                                  NSString *userId = responseObject[@"id"];
                                                  [KeyChain setUserId:userId];
                                                  UserBaseInfo *info = [UserBaseInfo share];
                                                  [info modelObjectWithDictionary:responseObject];
                                                  
                                              } failure:^(NSNumber *errorCode,
                                                          NSString *errorMsg,
                                                          NSDictionary *responseObject) {
                                                  
                                              }];
}

- (void)httpRequestServerCustomProperty {
    [[APIService share]httpRequestServerCustomPropertySuccess:^(NSDictionary *responseObject) {
        NSString *registerAlias = responseObject[@"registerAlias"];
        [JPush setAlias:registerAlias];
    } failure:nil];
}
- (void)initSubviews
{
    NSArray *viewControllerNames = @[@"WorkHomeViewController",
                                     @"InformationViewController",
                                     @"HomeViewController",
                                     @"MyViewController"];
    NSArray *tabBarImages = @[@"tab_3",@"tab_2",@"tab_1",@"tab_4"];
    NSArray *tabBarTitles = @[@"工作",@"资讯",@"消息",@"我的"];
    
    NSMutableArray *controllers = [NSMutableArray array];
    
    NSInteger i = 0;
    for (NSString *controllerName in viewControllerNames) {
        UIViewController *vc = [[CMRouter sharedInstance]getObjectWithClassName:controllerName];
        
        if (vc) {
            
            BaseNavigationController *nvc = [[BaseNavigationController alloc]initWithRootViewController:vc];
            [controllers addObject:nvc];
            
            NSString *imageName = [tabBarImages objectAtIndex:i];
            NSString *selectImageName = [NSString stringWithFormat:@"%@_hl",imageName];
            NSString *title = [tabBarTitles objectAtIndex:i];
            [self setViewController:nvc
            tabBarItemImageWithName:imageName
         tabBarItemSelImageWithName:selectImageName
                    tabBarItemTitle:title];
        }
        i++;
        
    }
    
    self.viewControllers = controllers.copy;
}


-  (void)setViewController:(UIViewController *)vc
   tabBarItemImageWithName:(NSString *)imageName
tabBarItemSelImageWithName:(NSString *)imageNameSel
           tabBarItemTitle:(NSString *)title;

{
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:imageNameSel]
                                   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.image = [[UIImage imageNamed:imageName]
                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NSDictionary *normal = [NSDictionary  dictionaryWithObjectsAndKeys:ColorWithRGB(122, 122, 122, 1),NSForegroundColorAttributeName,APPFONT(10),NSFontAttributeName, nil];
    [vc.tabBarItem setTitleTextAttributes:normal forState:UIControlStateNormal];
    NSDictionary *select = [NSDictionary  dictionaryWithObjectsAndKeys:ColorWithRGB(242, 151, 0, 1),NSForegroundColorAttributeName,APPFONT(10),NSFontAttributeName, nil];
    [vc.tabBarItem setTitleTextAttributes:select forState:UIControlStateSelected];
    [vc.tabBarItem setTitle:title];
    
}

- (NSString*)urlAppendBaseParam:(NSString*)url
{
    NSString *token = [KeyChain getToken];
    NSString *storeId = (NSString*) [WorkStoreModel lastChooseStore].storeId;
    if (storeId == nil) {
        storeId = @"";
    }
    NSTimeInterval  timer = [[NSDate date]timeIntervalSince1970];
    NSNumber *time = [NSNumber numberWithLongLong:timer*1000];
    NSMutableDictionary *md = @{}.mutableCopy;
    NSString *wifi = [KKNetworkReachabilityManager share].networkReachabilityStatus == KKNetworkReachabilityStatusReachableViaWiFi?@"true":@"false";
    [md setObject:token forKey:@"token"];
    [md setObject:storeId forKey:@"storeId"];
    [md setObject:@"ios" forKey:@"os"];
    [md setObject:@"B" forKey:@"platForm"];
    [md setObject:@"APP" forKey:@"deviceType"];
    [md setObject:time forKey:@"time"];
    [md setObject:wifi forKey:@"wifi"];
    NSString *str = [NSString stringWithFormat:@"%@&%@",url,[self getSchema:md]];
    NSLog(@"%@",str);
    return str;
}


- (NSString *)getSchema:(NSDictionary*)param
{
    NSMutableString *aStr = [NSMutableString string];
    [param enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        [aStr appendString:key];
        [aStr appendString:@"="];
        [aStr appendFormat:@"%@",obj];
        [aStr appendString:@"&"];
    }];
    
    if ([aStr hasSuffix:@"&"])
    {
        [aStr deleteCharactersInRange:NSMakeRange(aStr.length-1, 1)];
    }
    
    return aStr.copy;
}

- (NSString*)pathAppendBaseURL:(NSString*)path;
{
    if ([path hasPrefix:@"http:"]||[path hasPrefix:@"https:"])
    {
        return path;
    }
    return [NSString stringWithFormat:@"%@%@",BASE_WEB_URL,path];
}

@end
