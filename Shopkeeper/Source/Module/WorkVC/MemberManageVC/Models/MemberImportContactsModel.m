//
//  MemberImportContactsModel.m
//  Dev
//
//  Created by xl on 2017/11/9.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "MemberImportContactsModel.h"
#import <AddressBook/AddressBook.h>
#import "MemberImportContactsCell.h"
#import "NSString+hn_extension.h"

NSString *const MemberContactsSectionTitlesArray = @"MemberContactsSectionTitlesArray";
NSString *const MemberContactsSectionArray = @"MemberContactsSectionArray";
@interface MemberImportContactsModel ()<MemberImportContactsCellModelManager>
{
    NSMutableArray *_selectedItems;
}
//@property (nonatomic,strong) NSArray *sectionTitles;
@property (nonatomic,strong) NSMutableArray *farmerlist;
@property (nonatomic,strong) KKTableViewModel *tableViewModel;
@end

@implementation MemberImportContactsModel

#pragma mark - 读取系统通讯录相关
+ (ContactAuthorizationStatus)authorizationStatus {
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    switch (status) {
        case kABAuthorizationStatusNotDetermined: return ContactAuthorizationStatusNotDetermined;
        case kABAuthorizationStatusRestricted: return ContactAuthorizationStatusRestricted;
        case kABAuthorizationStatusDenied: return ContactAuthorizationStatusDenied;
        case kABAuthorizationStatusAuthorized: return ContactAuthorizationStatusAuthorized;
    }
}

- (void)requestAccessWithCompletionHandler:(void (^)(BOOL granted, NSError *error))completionHandler {
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
        NSError *ocError = (__bridge NSError *)(error);
        completionHandler(granted, ocError);
        if (error) CFRelease(error);
    });
    CFRelease(addressBook);
}
- (NSArray *)addressBookAllInfo {
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, nil);
    
    NSArray *array = (__bridge_transfer NSArray *)(ABAddressBookCopyArrayOfAllPeople(addressBook));
    NSMutableArray *peoples = @[].mutableCopy;
    for (NSInteger i = 0; i < array.count; i++) {
        
        ABRecordRef person = (__bridge ABRecordRef)(array[i]);
        
        NSString *compositeName = (__bridge_transfer NSString *)(ABRecordCopyCompositeName(person));
        NSString *name = [compositeName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString *firstLetter = [name hn_firstLetter];
        
        NSString *firstName = (__bridge_transfer NSString *)(ABRecordCopyValue(person, kABPersonFirstNameProperty));
        NSString *lastName =(__bridge_transfer NSString *)(ABRecordCopyValue(person, kABPersonLastNameProperty));
        
        ABMutableMultiValueRef phoneMulti = ABRecordCopyValue(person, kABPersonPhoneProperty);
        NSMutableArray *phones = @[].mutableCopy;
        for (CFIndex i = 0; i < ABMultiValueGetCount(phoneMulti); i++) {
            NSString *phone = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(phoneMulti,i);
            NSString *label = (__bridge_transfer NSString *)ABMultiValueCopyLabelAtIndex(phoneMulti,i);
            if (phone && phone.length > 1) {
                phone = [self phoneWithSysAddressBookPhone:phone];
                NSMutableDictionary *phoneDic = @{}.mutableCopy;
                [phoneDic setObject:label forKey:@"name"];
                [phoneDic setObject:phone forKey:@"phone"];
                [phones addObject:phoneDic];
            }
        }
        if (phones.count > 0) {
            NSMutableDictionary *person = @{}.mutableCopy;
            [person setObject:name forKey:@"name"];
            [person setObject:firstLetter forKey:@"firstLetter"];
            [person setObject:firstName forKey:@"firstName"];
            [person setObject:lastName forKey:@"lastName"];
            [person setObject:phones forKey:@"phones"];
            [peoples addObject:person];
        }
    }
    CFRelease(addressBook);
    return peoples.copy;
}
- (NSString *)phoneWithSysAddressBookPhone:(NSString *)bookPhone {
    NSString *phone = @"";
    if (bookPhone) {
        bookPhone = [bookPhone stringByReplacingOccurrencesOfString:@" " withString:@""];
        bookPhone = [bookPhone stringByReplacingOccurrencesOfString:@"-" withString:@""];
        bookPhone = [bookPhone stringByReplacingOccurrencesOfString:@"+86" withString:@""];
        bookPhone = [bookPhone stringByReplacingOccurrencesOfString:@"+086" withString:@""];
        bookPhone = [bookPhone stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        bookPhone = [bookPhone stringByReplacingOccurrencesOfString:@"+" withString:@""];
        bookPhone = [bookPhone stringByReplacingOccurrencesOfString:@"=" withString:@""];
        bookPhone = [bookPhone stringByReplacingOccurrencesOfString:@"*" withString:@""];
        bookPhone = [bookPhone stringByReplacingOccurrencesOfString:@"," withString:@""];
        bookPhone = [bookPhone stringByReplacingOccurrencesOfString:@";" withString:@""];
        bookPhone = [bookPhone stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@",;[]{}（%-*+=_）\\|~(＜＞$%^&*)_+ "];
        phone = [[bookPhone componentsSeparatedByCharactersInSet: doNotWant]componentsJoinedByString: @""];
    }
    return phone;
}
#pragma mark - viewModelData
- (void)getAddressBookDataSuccess:(void (^)(void))success failure:(void (^)(NSError *))failure {
    if ([MemberImportContactsModel authorizationStatus] == ContactAuthorizationStatusAuthorized) {   // 用户允许获取 通讯录的权限
        if (success) {
            success();
        }
    } else if ([MemberImportContactsModel authorizationStatus] == ContactAuthorizationStatusNotDetermined) {  //  让用户选择 通讯录权限
        [self requestAccessWithCompletionHandler:^(BOOL granted, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    if (success) {
                        success();
                    }
                } else {
                    if (failure) {
                        failure(error);
                    }
                }
            });
        }];
    } else {   // 用户未允许获取 通讯录的权限
        if (failure) {
            NSError *error = [NSError errorWithDomain:@"AuthorizationError" code:401 userInfo:@{NSLocalizedDescriptionKey:@"无权限访问通讯录"}];
            failure(error);
        }
    }
}
//- (NSArray *)sectionIndexTitles {
//    return self.sectionTitles ? self.sectionTitles : @[];
//}
- (void)existFarmerlist:(NSArray *)farmerList {
    if (farmerList) {
        self.farmerlist = farmerList.mutableCopy;
    } else {
        self.farmerlist = [NSMutableArray array];
    }
}
- (void)updateFarmerList {
    [self.selctedItems enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(MemberImportContactsCellModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *dic = @{}.mutableCopy;
        [dic setObject:obj.contactPhone forKey:@"customerPhone"];
        [dic setObject:obj.contactName forKey:@"customerNme"];
        [self.farmerlist addObject:dic];
        obj.selected = NO;
    }];
}
- (KKTableViewModel *)tableViewModel {
    NSDictionary *peoples = [self groupingWithArray:[self addressBookAllInfo] sortTitleMethodName:@"firstLetter" sortMethodName:@"name"];
    NSArray *sections = peoples[MemberContactsSectionArray];
    NSArray *sectionTitles = peoples[MemberContactsSectionTitlesArray];
    _tableViewModel = [[KKTableViewModel alloc]init];
    [self.selctedItems removeAllObjects];
    if (sections.count > 0) {
        _tableViewModel.sectionTitleList = sectionTitles.mutableCopy;
        [sections enumerateObjectsUsingBlock:^(NSArray *sectionPersons, NSUInteger idx, BOOL * _Nonnull stop) {
            KKSectionModel *sectionModel = [[KKSectionModel alloc]init];
            [sectionModel addCellModelList:[self cellModelWithSectionPersons:sectionPersons]];
            sectionModel.headerData = [self sectionHeaderModelWithSectionTitle:sectionTitles[idx]];
            [_tableViewModel addSetionModel:sectionModel];
        }];
    }
    return _tableViewModel;
}
- (NSInteger)totalAvailableCount {
    __block NSInteger count = 0;
    [_tableViewModel.sectionDataList enumerateObjectsUsingBlock:^(KKSectionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.cellDataList enumerateObjectsUsingBlock:^(KKCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MemberImportContactsCellModel *cellData = obj.data;
            if (cellData.enabled) {
                count ++ ;
            }
        }];
    }];
    return count;
}

- (NSArray *)selecteds {
    return self.selctedItems.copy;
}

- (BOOL)isSelectedAllStatus {
    return self.totalAvailableCount == self.selecteds.count;
}
- (void)selectedCellDataModel:(MemberImportContactsCellModel *)cellData {
    if (cellData) {
        cellData.selected = !cellData.selected;
    }
}
- (void)selectedAllStatus:(BOOL)selected {
    [_tableViewModel.sectionDataList enumerateObjectsUsingBlock:^(KKSectionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.cellDataList enumerateObjectsUsingBlock:^(KKCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MemberImportContactsCellModel *cellData = obj.data;
            if (cellData.enabled) {
                cellData.selected = selected;
            }
        }];
    }];
}
- (NSString*)getInputList
{
    NSMutableString *input = @"".mutableCopy;
    [self.selecteds enumerateObjectsUsingBlock:^(MemberImportContactsCellModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [input appendString:obj.contactPhone];
        [input appendString:@"_"];
        [input appendString:obj.contactName];
        [input appendString:@";"];
    }];
    return input.copy;
}
#pragma mark - MemberImportContactsCellModelManager
- (NSMutableArray *)selctedItems {
    if (!_selectedItems) {
        _selectedItems = [NSMutableArray array];
    }
    return _selectedItems;
}
#pragma mark - private
/** 处理系统通讯录数据，排序*/
- (NSDictionary *)groupingWithArray:(NSArray *)array sortTitleMethodName:(NSString *)titleMethodName sortMethodName:(NSString *)sortMethodName {
    NSMutableArray *sectionTitlesArray = [NSMutableArray new];
    
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    NSUInteger numberOfSections = [[collation sectionTitles] count];
    
    NSMutableArray *newSectionArray = [[NSMutableArray alloc] init];
    for (NSUInteger index = 0; index<numberOfSections; index++) {
        [newSectionArray addObject:[[NSMutableArray alloc] init]];
    }
    
    for (id model in array) {
        NSUInteger sectionIndex = collation.sectionTitles.count - 1;
        if ([collation.sectionTitles containsObject:model[titleMethodName]]) {
            sectionIndex = [collation.sectionTitles indexOfObject:model[titleMethodName]];
        }
        [newSectionArray[sectionIndex] addObject:model];
    }
    
    for (NSUInteger index = 0;index<numberOfSections;index++) {
        NSMutableArray *personsForSection = newSectionArray[index];
        NSArray *sortedPersonForSection = [personsForSection sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
            return [obj1[sortMethodName] compare:obj2[sortMethodName]];
        }];
        newSectionArray[index] = sortedPersonForSection;
    }
    
    NSMutableArray *temp = [NSMutableArray new];
    [newSectionArray enumerateObjectsUsingBlock:^(NSArray *arr, NSUInteger idx, BOOL * _Nonnull stop) {
        if (arr.count == 0) {
            [temp addObject:arr];
        }else{
            [sectionTitlesArray addObject:[collation sectionTitles][idx]];
        }
    }];
    
    [newSectionArray removeObjectsInArray:temp];
    
    return @{MemberContactsSectionArray:newSectionArray.copy,MemberContactsSectionTitlesArray:sectionTitlesArray.copy};
}
- (NSArray <KKCellModel *> *)cellModelWithSectionPersons:(NSArray *)persons {
    NSMutableArray *cellModels = [NSMutableArray array];
    if (persons.count > 0) {
        [persons enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            KKCellModel *cellModel = [[KKCellModel alloc]init];
            MemberImportContactsCellModel *dataModel = [[MemberImportContactsCellModel alloc]init];
            dataModel.contactName = obj[@"name"];
            dataModel.contactPhone = ((NSArray *)obj[@"phones"]).firstObject[@"phone"];
            dataModel.manager = self;
            dataModel.enabled = ![self framerListContainsPhone:dataModel.contactPhone];
            
            cellModel.data = dataModel;
            cellModel.cellClass = NSClassFromString(@"MemberImportContactsCell");
            cellModel.height = 60.0f;
            [cellModels addObject:cellModel];
        }];
    }
    return cellModels.copy;
}
- (KKCellModel *)sectionHeaderModelWithSectionTitle:(NSString *)sectionTitle {
    KKCellModel *header = [[KKCellModel alloc]init];
    header.data = sectionTitle;
    header.cellClass = NSClassFromString(@"MemberImportContactsHeaderView");
    header.height = 28.0f;
    return header;
}
- (BOOL)framerListContainsPhone:(NSString *)phone {
    BOOL flag = NO;
    for (NSDictionary *farmer in self.farmerlist) {
        NSString *customerPhone = farmer[@"customerPhone"];
        if ([customerPhone isEqualToString:phone]) {
            flag = YES;
            break;
        }
    }
    return flag;
}
@end
