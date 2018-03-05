//
//  TsMessageView.h
//  TsMessageView

//

#import <UIKit/UIKit.h>

@class Toast;
@interface ToastMessageView : NSObject
/**
 *  设置全局的提示框背景色（仅需设置一次）
 *  该控件在使用时，应根据项目的整体配色设置背景色
 *  如不设置，则默认的颜色为：[UIColor colorWithRed:22/255.0 green:179/255.0 blue:172/255.0 alpha:1]
 *  如设置后想恢复为默认色，可传入nil值
 *  @param backgroundColor 传入需要设置的颜色值
 */
+(void)setTsMessageViewBackgroundColor:(UIColor *)backgroundColor;

/**
 *  设置全局的提示文本的文字颜色（仅需设置一次）
 *  该控件在使用时，应根据项目的整体配色设置背景色
 *  如不设置，则默认的颜色为：[UIColor whiteColor]
 *  如设置后想恢复为默认色，可传入nil值
 *  @param textColor 传入需要设置的颜色值
 */
+(void)setTsMessageViewTextColor:(UIColor *)textColor;

/**
 *  显示提示信息，并自动于2秒的消失
 *
 *  @param msg    显示文本内容
 *  @param inView 显示该提示信息的视图
 */
+(void)showTsMessage:(NSString *)msg InView:(UIView *)inView;

/**
 *  显示提示信息，并在指定的时间后消失
 *
 *  @param msg    显示文本内容
 *  @param inView 显示该提示信息的视图
 *  @param delay  提示信息持续的时间 0<delay<60s
 */
+(void)showTsMessage:(NSString *)msg InView:(UIView *)inView DismissAfterDelay:(NSTimeInterval)delay;

/**
 *  按自定义样式显示弹出框消息
 *
 *  @param msg       消息文本
 *  @param msgconfig 文本属性设置：暂时开放的属性及key为：字体（"MsgFont"）,颜色（"MsgColor"）
 *  @param bgconfig  背景属性设置：暂时开放的属性及key为：自定义背景视图（"BgView"）,透明度（"BgAlpha"），颜色（"BgColor"）
 *  关于以上属性，不必每一项都设置
 *  @param inView    显示该提示信息的视图
 *  @param delay     提示信息持续的时间 0<delay<60s
 */
+(void)showTsMessage:(NSString *)msg
   WithMessageConfig:(NSDictionary *)msgconfig
         AndBgConfig:(NSDictionary *)bgconfig
              InView:(UIView *)inView
   DismissAfterDelay:(NSTimeInterval)delay;

/** 非外部调用方法
 *  显示队列中下一个可用的土司视图
 *
 *  @param toast 当前已显示的土司视图
 */
-(void)showNext:(Toast *)toast;

/** 20150202＋
 *  在指定视图中显示提示语，可指定是否替换当前正在显示的提示语
 *
 *  @param msg           提示语
 *  @param inView        显示所在视图
 *  @param shouldReplace 是否替换当前正在显示的提示语
 */
+(void)showTsMessage:(NSString *)msg inView:(UIView *)inView replaceCurrentIfExists:(BOOL)shouldReplace;

@end
