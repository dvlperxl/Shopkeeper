//
//  BaseNavigationController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/12.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "BaseNavigationController.h"
#import "PopTransitionManager.h"
#import "PresentTransitionManager.h"


@interface BaseNavigationController ()<UINavigationControllerDelegate>

@property(nonatomic,strong)PopTransitionManager *popTransitionManager;
@property(nonatomic,strong)PresentTransitionManager *presentTransitionManager;

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate = nil;
    }
    
    if ([self.navigationBar respondsToSelector:@selector(shadowImage)]) {
        self.navigationBar.shadowImage = [UIImage createImageWithColor:[UIColor clearColor]];
    }
    
    self.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName: ColorWithRGB(3, 3, 3, 1),
                                                                  NSFontAttributeName : [UIFont systemFontOfSize:17.0]};
    
    //    UINavigationBar *naviBar = self.navigationController.navigationBar;
    //    naviBar.tintColor=ColorWithRGB(3, 3, 3, 1);
    
    UIImage *clearImage = [UIImage createImageWithColor:[UIColor clearColor]];
    
    [self.navigationBar setBackgroundImage:clearImage
                                                  forBarMetrics:UIBarMetricsDefault];
    
    self.navigationBar.backgroundColor = [UIColor clearColor];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        if (viewController == navigationController.viewControllers[0])
        {
            navigationController.interactivePopGestureRecognizer.enabled = NO;
            
        }else {
            
            if ([[viewController valueForKey:@"present"] boolValue])
            {
                navigationController.interactivePopGestureRecognizer.enabled = NO;
                
            }else
            {
                navigationController.interactivePopGestureRecognizer.enabled = YES;
            }
        }
    }
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{


    if (operation == UINavigationControllerOperationPush)
    {
        if ([[toVC valueForKey:@"present"] boolValue])
        {
            self.presentTransitionManager.operation = operation;
            return self.presentTransitionManager;
        }
        
    }else if (operation == UINavigationControllerOperationPop)
    {
        if ([[fromVC valueForKey:@"present"] boolValue])
        {
            self.presentTransitionManager.operation = operation;
            return self.presentTransitionManager;
        }
    }

    return nil;

}


- (PopTransitionManager *)popTransitionManager
{
    if (!_popTransitionManager) {

        _popTransitionManager = [PopTransitionManager new];
    }
    return _popTransitionManager;
}

- (PresentTransitionManager *)presentTransitionManager
{
    if (!_presentTransitionManager) {
        
        _presentTransitionManager = [PresentTransitionManager new];
    }
    return _presentTransitionManager;
}



@end
