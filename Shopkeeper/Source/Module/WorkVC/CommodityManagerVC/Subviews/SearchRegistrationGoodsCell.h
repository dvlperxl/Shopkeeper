//
//  SearchRegistrationGoodsCell.h
//  Shopkeeper
//
//  Created by xl on 2017/11/23.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchRegistrationGoodsCell : UITableViewCell

@end

@interface SearchRegistrationGoodsCellModel : NSObject

@property (nonatomic,copy) NSString *sn;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *category;
@property (nonatomic,copy) NSString *toxicity;
@property (nonatomic,copy) NSString *company;
@property (nonatomic,copy) NSString *categoryname;
@property (nonatomic,copy) NSString *formulation;
@property (nonatomic,copy) NSString *subsn;

@property (nonatomic,strong) NSAttributedString *attributedSn;
@property (nonatomic,strong) NSAttributedString *attributedName;
@property (nonatomic,strong) NSAttributedString *attributedCompany;

@end
