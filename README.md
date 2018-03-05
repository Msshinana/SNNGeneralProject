# SNNGeneralProject
这是一个基于MVVM的项目架构，此工程对常用的第三方SDK如AFNetworking、MBProgressHUD、FMDB进行了封装；对常用的控件封装；添加了一些常用类的扩展；集成了常用的第三方服务如腾讯Bugly、QQ分享、微信分享。
# 搭建项目框架步骤：
1、创建新工程；<br>
2、配置项目；<br>
3、cocoapods导入常用的第三方SDK：AFNetworking/SDWebimage/MJRefresh/MBProgressHUD/Masonory；<br>
4、创建pch文件以及Config.h用于编写某些全局配置参数；<br>
5、搭建基础项目目录；<br>
6、添加常用工具类；<br>
## 一、项目目录结构说明
<img src="https://github.com/Msshinana/imagesource/blob/master/SNNGeneralProject一级目录结构.png" width="30%" height="30%"><br>
      1、Models:数据模型<br>
      2、ViewControllers:视图层<br>
      3、ViewModels:业务逻辑和网络请求<br>
      4、CommonFiles:工具类及类扩展<br>
      5、HTTPRequest:网络请求的类<br>
      6、SupportingFiles:pch文件以及Config等全局配置参数<br>
      7、ImageSource:资源文件<br>

## 二、关于网络请求框架
<img src="https://github.com/Msshinana/imagesource/blob/master/HTTPRequest目录结构.png" width="30%" height="30%"><br>
HTTPRequest是对AF做的一层封装，支持GET请求及POST请求，支持图片上传及下载；封装内容包括：监测网络状态、防止重复请求或可重复请求、请求异常处理等。
#### 代码预览
<img src="https://github.com/Msshinana/imagesource/blob/master/HTTPManager预览.png" width="100%" height="30%"><br>


## 三、封装常用控件
+ (UIButton *)getImageButtonWithFrame:(CGRect )frame
                       withNorImgFile:(UIImage *)normalImage
                       withSelImgFile:(UIImage *)selectImage
                           withTarget:(id)customTarget
                              withSel:(SEL)customSel;<br>
+ (UITableView *)getTableViewWithFrame:(CGRect)frame
                          withDelegate:(id)delegate
                        withDateSource:(id)datesource
                           withBGColor:(UIColor *)bgcolor;
                           
