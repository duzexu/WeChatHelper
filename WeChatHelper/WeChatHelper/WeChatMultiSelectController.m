//
//  WeChatMultiSelectController.m
//  IPAPatchFramework
//
//  Created by duzexu on 2018/2/28.
//  Copyright © 2018年 Weibo. All rights reserved.
//

#import "WeChatMultiSelectController.h"
#import "WeChatHeader.h"
#import <objc/runtime.h>

@interface WeChatMultiSelectController ()<ContactSelectViewDelegate>

@property (strong, nonatomic) ContactSelectView *selectView;
@property (strong, nonatomic) NSArray *blackList;

@end

@implementation WeChatMultiSelectController

- (instancetype)initWithBlackList:(NSArray *)blackList {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _blackList = blackList;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTitleArea];
    [self initSelectView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    MMServiceCenter *serviceCenter = [objc_getClass("MMServiceCenter") defaultCenter];
    CContactMgr *contactMgr = [serviceCenter getService:objc_getClass("CContactMgr")];
    
    for (NSString *contactName in self.blackList) {
        CContact *contact = [contactMgr getContactByName:contactName];
        [self.selectView addSelect:contact];
    }
}

- (void)initTitleArea {
    self.navigationItem.leftBarButtonItem = [objc_getClass("MMUICommonUtil") getBarButtonWithTitle:@"取消" target:self action:@selector(onCancel:) style:0];
    
    self.navigationItem.rightBarButtonItem = [self rightBarButtonWithSelectCount:self.blackList.count];
    
    self.title = @"黑名单";
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0]}];
}

- (UIBarButtonItem *)rightBarButtonWithSelectCount:(unsigned long)selectCount {
    
    UIBarButtonItem *barButtonItem;
    if (selectCount == 0) {
        barButtonItem = [objc_getClass("MMUICommonUtil") getBarButtonWithTitle:@"确定" target:self action:@selector(onDone:) style:2];
    } else {
        NSString *title = [NSString stringWithFormat:@"确定(%lu)", selectCount];
        barButtonItem = [objc_getClass("MMUICommonUtil") getBarButtonWithTitle:title target:self action:@selector(onDone:) style:4];
    }
    return barButtonItem;
}

- (void)onCancel:(UIBarButtonItem *)item {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onDone:(UIBarButtonItem *)item {
    if ([self.delegate respondsToSelector:@selector(onMultiSelectGroupReturn:)]) {
        NSArray *blacklist = [[self.selectView.m_dicMultiSelect allKeys] copy];
        [self.delegate onMultiSelectGroupReturn:blacklist];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initSelectView {
    CGRect rect = CGRectMake(0, 44+[UIApplication sharedApplication].statusBarFrame.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.selectView = [[objc_getClass("ContactSelectView") alloc] initWithFrame:rect delegate:self];
    
    self.selectView.m_uiGroupScene = 5;
    self.selectView.m_bMultiSelect = YES;
    [self.selectView initData:5];
    [self.selectView initView];
    
    [self.view addSubview:self.selectView];
}

#pragma mark - ContactSelectViewDelegate
- (void)onSelectContact:(CContact *)arg1 {
    self.navigationItem.rightBarButtonItem = [self rightBarButtonWithSelectCount:[self.selectView.m_dicMultiSelect count]];
}

@end
