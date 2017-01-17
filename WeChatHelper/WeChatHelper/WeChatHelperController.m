//
//  WeChatHelperController.m
//  WeChatHelper
//
//  Created by duzexu on 16/11/11.
//
//

#import "WeChatHelperController.h"
#import "WeChatHelperSetting.h"
#import "WeChatMapController.h"

@interface WeChatHelperController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *delayTimes;
@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation WeChatHelperController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"助手设置";
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    self.delayTimes = WeChatHelperDelayTimes;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    _selectIndex = [_delayTimes indexOfObject:@(HELPER_SETTING.redEnvPluginDelay)];
}

- (void)viewDidLayoutSubviews {
    _tableView.frame = self.view.bounds;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_tableView reloadData];
}

- (BOOL)shouldAutorotate {
    return NO;
}

#pragma mark - Action
- (void)switchAction:(UISwitch *)sender {
    if (sender.tag == 0) {
        HELPER_SETTING.redEnvPluginIsOn = !HELPER_SETTING.redEnvPluginIsOn;
    }
    if (sender.tag == 1) {
        HELPER_SETTING.redEnvPluginForMyself = !HELPER_SETTING.redEnvPluginForMyself;
    }
    if (sender.tag == 2) {
        HELPER_SETTING.runInBackGround = !HELPER_SETTING.runInBackGround;
    }
}

- (void)locationAction:(UISwitch *)sender {
    HELPER_SETTING.fakeLocPluginIsOn = !HELPER_SETTING.fakeLocPluginIsOn;
}

- (void)revokeAction:(UISwitch *)sender {
    HELPER_SETTING.forbidRevokeIsOn = !HELPER_SETTING.forbidRevokeIsOn;
}

- (void)stepAction:(UISwitch *)sender {
    HELPER_SETTING.fakeStepPluginIsOn = !HELPER_SETTING.fakeStepPluginIsOn;
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView; {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return _delayTimes.count;
            break;
        case 2:
            return 2;
            break;
        case 3:
            return 1;
            break;
        case 4:
            return 2;
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        Class class = NSClassFromString(@"MMTableViewCell");
        cell = [[class alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    switch (indexPath.section) {
        case 0: {
            UISwitch *switchButton = [UISwitch new];
            [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
            switchButton.tag = indexPath.row;
            cell.accessoryView = switchButton;
            
            if (indexPath.row == 0) {
                cell.textLabel.text = @"自动抢红包";
                switchButton.on = HELPER_SETTING.redEnvPluginIsOn;
            }else if (indexPath.row == 1) {
                cell.textLabel.text = @"抢自己的红包";
                switchButton.on = HELPER_SETTING.redEnvPluginForMyself;
            }else{
                cell.textLabel.text = @"后台运行";
                switchButton.on = HELPER_SETTING.runInBackGround;
            }
        }
            break;
        case 1: {
            NSNumber *time = _delayTimes[indexPath.row];
            if (time.doubleValue > 0) {
                cell.textLabel.text = [NSString stringWithFormat:@"延时 %@ s",time];
            }else if (time.doubleValue < 0) {
                cell.textLabel.text = @"随机";
            }else{
                cell.textLabel.text = @"秒抢";
            }
            cell.accessoryView = nil;
            if (indexPath.row == _selectIndex) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
            break;
        case 2: {
            if (indexPath.row == 0) {
                UISwitch *switchButton = [UISwitch new];
                [switchButton addTarget:self action:@selector(locationAction:) forControlEvents:UIControlEventValueChanged];
                cell.accessoryView = switchButton;
                cell.textLabel.text = @"地理位置伪装";
                switchButton.on = HELPER_SETTING.fakeLocPluginIsOn;
            }else{
                cell.textLabel.text = [NSString stringWithFormat:@"当前经纬度 %@",HELPER_SETTING.fakeLocation.description];
                cell.accessoryView = nil;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        }
            break;
        case 3: {
            UISwitch *switchButton = [UISwitch new];
            [switchButton addTarget:self action:@selector(revokeAction:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = switchButton;
            cell.textLabel.text = @"消息防撤回";
            switchButton.on = HELPER_SETTING.forbidRevokeIsOn;
        }
            break;
        case 4:{
            if (indexPath.row == 0) {
                UISwitch *switchButton = [UISwitch new];
                [switchButton addTarget:self action:@selector(stepAction:) forControlEvents:UIControlEventValueChanged];
                cell.accessoryView = switchButton;
                cell.textLabel.text = @"朋友圈步数";
                switchButton.on = HELPER_SETTING.fakeStepPluginIsOn;
            }else{
                cell.textLabel.text = [NSString stringWithFormat:@"当前步数 %d",(int)HELPER_SETTING.fakeStepCount];
                cell.accessoryView = nil;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        }
            break;
        default:
            break;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 18;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        NSNumber *time = _delayTimes[indexPath.row];
        HELPER_SETTING.redEnvPluginDelay = time.doubleValue;
        _selectIndex = indexPath.row;
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    }
    if (indexPath.section == 2 && indexPath.row == 1) {
        WeChatMapController *vc = [[WeChatMapController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 4 && indexPath.row == 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"设置步数"
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        alert.delegate = self;
        [alert show];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)willPresentAlertView:(UIAlertView *)alertView {
    UITextField *textField = [alertView textFieldAtIndex:0];
    textField.text = @(HELPER_SETTING.fakeStepCount).stringValue;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    UITextField *textField = [alertView textFieldAtIndex:0];
    HELPER_SETTING.fakeStepCount = textField.text.integerValue;
    [_tableView reloadData];
}

@end
