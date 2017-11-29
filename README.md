# SNNGeneralProject
这是一个完整的项目架构，此工程对常用的第三方SDK如AFNetworking、MBProgressHUD、MJRefresh进行了封装；对常用的控件封装；添加了一些常用类的扩展；集成了常用的第三方服务如腾讯Bugly、QQ分享、微信分享。
# 搭建项目框架步骤：
1、创新工程；<br>
2、修改最低部署系统的Target版本；<br>
3、cocoapods导入常用的第三方SDK：AFNetworking/SDWebimage/MJRefresh/MBProgressHUD/Masonory；<br>
4、创建pch文件；<br>
5、创建API.h文件用于查询接口等；<br>
6、创建Config.h文件用于编写某些全局配置参数；<br>
# 封装常用的第三方SDK
## AFNetworking
