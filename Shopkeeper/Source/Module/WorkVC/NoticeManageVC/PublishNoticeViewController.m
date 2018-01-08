//
//  PublishNoticeViewController.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/10/26.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "PublishNoticeViewController.h"
#import "JKMessageTextView.h"
#import "NSString+StringTransform.h"

@interface PublishNoticeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet CMTextField *titleTextField;

@property (weak, nonatomic) IBOutlet JKMessageTextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIButton *publishButton;
@property(nonatomic,strong)CMInputAccessoryView *accessoryView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollerview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewContraints;

@end

@implementation PublishNoticeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initSubviews];
    self.titleTextField.text = self.titleStr;
    self.contentTextView.text = self.mainBody;
    self.countLab.text = @"选择";
    self.countLab.textColor = ColorWithHex(@"#8f8e94");
    
    if (![self.contacts isEqualToString:@"all"]) {
        
        if (self.contacts&&self.contacts.length>0)
        {
            NSInteger count = [[self.contacts componentsSeparatedByString:@";"] count];
            self.countLab.text = [NSString stringWithFormat:@"已选择%@人",@(count)];
            self.countLab.textColor = ColorWithHex(@"#f29700");
        }
    }
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewTextDidChangeNotification:) name:UITextViewTextDidChangeNotification object:nil];
    
        if (@available(iOS 11.0, *))
        {
            self.scrollerview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
    
        } else {
            self.automaticallyAdjustsScrollViewInsets = YES;
        }
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

//    [self.scrollerview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.offset(0);
//        make.top.equalTo(self.mas_topLayoutGuide);
//        make.bottom.equalTo(self.mas_bottomLayoutGuide);
//    }];
    
//    self.scrollViewContraints 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewTextDidChangeNotification:(NSNotification*)notif
{
    if (self.contentTextView.isFirstResponder)
    {
        NSString *text = self.contentTextView.text;
        NSLog(@"%@",@(text.length));
        NSLog(@"%@",text);
        
        if (text.length>200){
           
            NSLog(@"%@",@(text.length));
            NSLog(@"%@",text);
            [[KKToast makeToast:@"公告正文最多输入200个字"] show];
            self.contentTextView.text =  [text substringToIndex:200];
        
        }
    }
}

- (IBAction)onPublishButtonAction:(id)sender
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    if (self.contacts == nil) {

        [[KKToast makeToast:@"请先添加会员"] show];
        return;
    }
    
    if (self.titleTextField.text.length<1) {
        
        [[KKToast makeToast:@"公告标题不能为空"] show];
        
        return;
    }
    
    if ([self.titleTextField.text firstLetterLegal]) {
        
        [[KKToast makeToast:@"首字不能为特殊符号"] show];
        
        return;
    }
    
    if (self.titleTextField.text.length>20) {
        
        [[KKToast makeToast:@"公告标题最多输入20个字"] show];
        
        return;
    }
    
    if (self.contentTextView.text.length<1) {
        
        [[KKToast makeToast:@"公告正文不能为空"] show];
        
        return;
    }
    
    if ([self.contentTextView.text firstLetterLegal]) {
        
        [[KKToast makeToast:@"首字不能为特殊符号"] show];
        
        return;
    }
    
    if (self.contentTextView.text.length>200) {
        
        [[KKToast makeToast:@"公告正文最多输入200个字"] show];
        
        return;
    }
    
    [self httpRequestRelease];

    
}

- (void)onChooseMemberButtonAction
{
    NSMutableDictionary *param = @{}.mutableCopy;
    [param setObject:self.storeId forKey:@"storeId"];
    [param setObject:self.contacts forKey:@"contacts"];
    [[CMRouter sharedInstance]showViewController:@"ChooseMemberViewController" param:param];
}

#pragma mark - reuquest

- (void)httpRequestRelease
{
    [KKProgressHUD showMBProgressAddTo:self.view];
    [[APIService share]httpRequestReleaseNotice:self.titleTextField.text
                                       contacts:self.contacts
                                         userid:[KeyChain getUserId]
                                         imgUrl:@""
                                       mainbody:self.contentTextView.text
                                        storeId:self.storeId
                                        success:^(NSDictionary *responseObject) {
                                            
                                            NSString *success = responseObject[@"success"];
                                            if ([success isEqualToString:@"fail"])
                                            {
                                                
                                                [KKProgressHUD showErrorAddTo:self.view message:responseObject[@"msg"]];
                                                [self httpRequestCreateRelease];
                                                
                                            }else
                                            {
                                                [KKProgressHUD hideMBProgressForView:self.view];
                                                [[CMRouter sharedInstance]popViewController];
                                            }
                                            
                                            
        
    } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
        
        [KKProgressHUD showErrorAddTo:self.view message:errorMsg];
        
    }];
}

- (void)httpRequestCreateRelease
{
    [[APIService share]httpRequestCreateReleaseNotice:self.titleTextField.text
                                             contacts:self.contacts
                                               userid:[KeyChain getUserId]
                                               imgUrl:@""
                                             mainbody:self.contentTextView.text
                                              storeId:self.storeId
                                              success:^(NSDictionary *responseObject) {
                                                  
                                                  [[CMRouter sharedInstance]popViewController];
                                                  
                                              } failure:^(NSNumber *errorCode, NSString *errorMsg, NSDictionary *responseObject) {
                                                  if ([responseObject[@"status"] integerValue]==1)
                                                  {
                                                      [[CMRouter sharedInstance]popViewController];

                                                  }else
                                                  {
                                                      [KKProgressHUD showErrorAddTo:self.view message:errorMsg];

                                                  }

                                              }];
}

- (void)initSubviews
{
    self.navigationItem.title = @"公告编辑";
    self.contentTextView.placeHolder = @"请输入正文（200字以内）";
    self.contentTextView.placeHolderTextColor = ColorWithHex(@"a7a7a7");
    self.contentTextView.backgroundColor = [UIColor whiteColor];
    self.contentTextView.textColor = ColorWithRGB(54, 54, 54, 1);
    self.contentTextView.inputAccessoryView = self.accessoryView;
    self.titleTextField.placeholderColor = ColorWithHex(@"a7a7a7");
    self.contentTextView.keyboardAppearance = UIKeyboardAppearanceDefault;
    self.contentTextView.returnKeyType = UIReturnKeyDefault;
    self.publishButton.layer.masksToBounds = YES;
    self.publishButton.layer.cornerRadius = 22;
    self.countLab.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onChooseMemberButtonAction)];
    [self.countLab addGestureRecognizer:tap];
}

- (CMInputAccessoryView *)accessoryView
{
    if (!_accessoryView) {
        _accessoryView = [[CMInputAccessoryView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    }
    return _accessoryView;
}

- (void)setCallBack:(NSDictionary *)callBack
{
    if ([callBack[@"action"]isEqualToString:@"chooseMember"])
    {
        self.contacts = callBack[@"contacts"];
        NSString *count = callBack[@"count"];
        self.countLab.text = [NSString stringWithFormat:@"已选择%@人",count];
        self.countLab.textColor = ColorWithHex(@"#f29700");
    }
}

@end
