//
//  HomeViewController.m
//  SNNGeneralProject
//
//  Created by nana on 2018/3/5.
//  Copyright © 2018年 dzcx-shinana. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (nonatomic, strong) UserInfoModel *userInfoModel;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURL;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}
- (void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(weiboDidLoginNotification:) name:@"weiboDidLoginNotification" object:nil];
}
- (void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"weiboDidLoginNotification" object:nil];
}
- (void)weiboDidLoginNotification:(NSNotification*)notification{
    NSDictionary *result=[notification userInfo];
    NSString *accessToken = [result objectForKey:@"accessToken"];
    NSString *uid = [result objectForKey:@"userId"];
    [self p_getWeiboUserInfoWithAccessToken:accessToken uid:uid];
}
- (void)p_getWeiboUserInfoWithAccessToken:(NSString *)accessToken uid:(NSString *)uid {

    NSString *url =[NSString stringWithFormat:
                    @"https://api.weibo.com/2/users/show.json?access_token=%@&uid=%@",accessToken,uid];
    
    [[SNNHTTPManager shareManger]GETrequestWithUrlString:url showIndicatorInView:nil andCompletionHandler:^(NSDictionary *resBodyDic, NSError *error) {
        if(resBodyDic){
            self.userInfoModel = [[UserInfoModel alloc]initWithDic:resBodyDic];
            [self refreshUI];
        }
    }];
    
}
- (void)refreshUI{
    self.username.text = self.userInfoModel.name;
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:self.userInfoModel.profile_image_url] placeholderImage:[UIImage imageNamed:@""]];
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
