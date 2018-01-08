//
//  BaseViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/12.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "BaseViewController.h"
#import "WorkStoreModel.h"
#import "KKNetworkReachabilityManager.h"

@interface BaseViewController ()

@property(nonatomic,strong)UIView *underLineView;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.leftButtonImage = @"backBtn";
    if (self.leftButtonTitle==nil) {
        self.leftButtonTitle = @"返回";
    }
    self.view.backgroundColor = ColorWithRGB(246, 246, 246, 1);
    if ([self.parentViewController isKindOfClass:[UINavigationController class]])
    {
        [self initNar];
        [self.view addSubview:self.navView];
    }
    self.automaticallyAdjustsScrollViewInsets = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setScrollViewInsets:(NSArray<UIScrollView*>*)scrollViewList
{
//    if (@available(iOS 11.0, *))
//    {
//        for (UIScrollView *scrollView in scrollViewList)
//        {
//            [scrollView setContentInsetAdjustmentBehaviorNever];
//        }
//
//    } else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    if ([self.parentViewController isKindOfClass:[UINavigationController class]]) {
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
        [self.view bringSubviewToFront:self.navView];
    }
    
}

- (void)setBackBtnTitle:(NSString*)title
{
    [self.backBtn setTitle:title forState:UIControlStateNormal];
}

- (void)statusBarStyleDefault
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
}

- (void)statusBarStyleLightContent
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

- (void)onBackBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initNar
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 80, 44);
    //    backBtn.hitTestEdgeInsets = UIEdgeInsetsMake(-5, -5, -5, -5);
    if (self.present) {
        [backBtn setTitle:@"取消" forState:UIControlStateNormal];
    }else
    {
        [backBtn setImage:[UIImage imageNamed:self.leftButtonImage] forState:UIControlStateNormal];

        [backBtn setTitle:self.leftButtonTitle forState:UIControlStateNormal];
    }
    [backBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [backBtn setTitleColor:ColorWithRGB(242, 151, 0, 1) forState:UIControlStateNormal];
    backBtn.titleLabel.font = APPFONT(17);
    [backBtn addTarget:self action:@selector(onBackBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIView *backBtnView = [[UIView alloc] initWithFrame:backBtn.bounds];
    backBtnView.bounds = CGRectOffset(backBtnView.bounds, 20, 0);
    [backBtnView addSubview:backBtn];
    self.backBtn = backBtn;
    UIBarButtonItem* backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtnView];

    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:backButtonItem, nil] animated:NO];
    if (self.navigationController.viewControllers.count == 1) {
        
        [self.navigationItem setLeftBarButtonItems:nil animated:NO];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (UIView *)navView
{
    if (_navView) {
        
        return _navView;
    }
    
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetMaxY(self.navigationController.navigationBar.frame))];
    _navView.backgroundColor = ColorWithRGB(255, 255, 255, 1);
    return _navView;
}

- (CGFloat)navBarHeight
{
    return CGRectGetMaxY(self.navigationController.navigationBar.frame);
}

- (NSString*)pathAppendBaseURL:(NSString*)path;
{
    if ([path hasPrefix:@"http:"]||[path hasPrefix:@"https:"])
    {
        return path;
    }
    return [NSString stringWithFormat:@"%@%@",BASE_WEB_URL,path];
}

- (NSString*)urlAppendBaseParam:(NSString*)url
{
    NSString *token = [KeyChain getToken];
    NSString *storeId = (NSString*)[WorkStoreModel lastChooseStore].storeId;
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
    
    NSMutableString *str = @"".mutableCopy;
    NSString *six = @"?";
    if ([url containsString:six]) {
        six = @"&";
    }
    [str appendString:url];
    [str appendString:six];
    [str appendString:[self getSchema:md]];
    NSLog(@"%@",str);
    return str.copy;
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

@end
