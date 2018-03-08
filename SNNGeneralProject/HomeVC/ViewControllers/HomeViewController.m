//
//  HomeViewController.m
//  SNNGeneralProject
//
//  Created by nana on 2018/3/5.
//  Copyright © 2018年 dzcx-shinana. All rights reserved.
//

#import "HomeViewController.h"
#import "UserInfoViewModel.h"
#import "StatuesViewModel.h"
#import "HomeTableViewCell.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *statuesTimelineArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self weiboSendRequest];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(weiboDidLoginNotification:) name:@"weiboDidLoginNotification" object:nil];
}
- (void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"weiboDidLoginNotification" object:nil];
}

- (void)weiboDidLoginNotification:(NSNotification*)notification{

    [self p_getWeiboUserInfo];
    [self p_getWeiboStatuseTimeline];
}

/**
 * 在ViewModel中处理请求
 */
- (void)p_getWeiboUserInfo{
    kWeakSelf(weakSelf);
    UserInfoViewModel *userInfoViewModel = [[UserInfoViewModel alloc]initWithUIViewConroller:self];
    [userInfoViewModel p_getWeiboUserInfo:^(UserInfoModel *returnValue) {
        kStrongSelf(strongSelf);
        UserInfoModel *userInfoModel = (UserInfoModel *)returnValue;
        strongSelf.username.text = userInfoModel.name;
        [strongSelf.headerImage sd_setImageWithURL:[NSURL URLWithString:userInfoModel.profile_image_url] placeholderImage:[UIImage imageNamed:@""]];
    }];
}
- (void)p_getWeiboStatuseTimeline{
    kWeakSelf(weakSelf);
    StatuesViewModel *statuesViewModel = [[StatuesViewModel alloc]initWithUIViewConroller:self];
    [statuesViewModel p_getWeiboStatuseTimeline:^(NSMutableArray *returnValue) {
        kStrongSelf(strongSelf);
        strongSelf.statuesTimelineArray = (NSMutableArray *)returnValue;
        [strongSelf.tabelView reloadData];
    }];
}

#pragma mark UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.statuesTimelineArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[HomeTableViewCell creatCellWithItemsContent:self.statuesTimelineArray inTableView:tableView forIndexPath:indexPath] getCellHeight];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [HomeTableViewCell creatCellWithItemsContent:self.statuesTimelineArray inTableView:tableView forIndexPath:indexPath];
}

- (NSMutableArray *)statuesTimelineArray{
    if (!_statuesTimelineArray) {
        _statuesTimelineArray = [NSMutableArray array];
    }
    return _statuesTimelineArray;
}

- (void)weiboSendRequest{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURL;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
