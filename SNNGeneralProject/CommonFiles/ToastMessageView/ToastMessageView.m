//
//  TsMessageView.m
//  TsMessageView
//

//

#import "ToastMessageView.h"
#define CGRECT_TOASTMESSAGEVIEW_FRAME CGRectMake(0, 640, 100, 30)   //提示视图的frame
#define ALPHA_TOASTMESSAGEVIEW 0.8   //提示视图的透明度
#define DEFAULT_BACKGROUND_COLOR [UIColor colorWithRed:((99) / 255.0) green:((99) / 255.0) blue:((99) / 255.0) alpha:(1)]//默认背景色
#define DEFAULT_TEXT_COLOR [UIColor whiteColor]//默认的文本色
#define BACKGROUNDCOLOR @"backGroundColor_TsMessageView"
#define TEXTCOLOR @"textColor_TsMessageView"
#define FONT_SIZE 16
#define BORDER_MARGIN 50
#define CORNER_RADIUS 10
#define MAX_WIDTH ([UIScreen mainScreen].bounds.size.width-BORDER_MARGIN*2)
#ifndef iOS7
#define iOS7 [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0
#endif
//*  @param msgconfig 文本属性设置：暂时开放的属性及key为：字体（"MsgFont"）,颜色（"MsgColor"）
//*  @param bgconfig  背景属性设置：暂时开放的属性及key为：自定义背景视图（"BgView"）,透明度（"BgAlpha"），颜色（"BgColor"）
@interface Toast : UIView

@property(strong,nonatomic)NSString *msg;
@property(strong,nonatomic)UIView *inView;
@property(strong,nonatomic)UIFont *mFont;
@property(strong,nonatomic)UIColor *mColor;
@property(strong,nonatomic)UIView *bgView;
@property(strong,nonatomic)UIColor *bgColor;
@property(assign,nonatomic)float bgAlpha;
@property(assign,nonatomic)NSInteger delay;
@property(weak,nonatomic)ToastMessageView *delegate;

-(id)initWithMsg:(NSString *)msg andShowInView:(UIView *)inView andMsgFont:(UIFont *)msgFont andMsgColor:(UIColor *)msgColor andBgView:(UIView *)bgview andBgColor:(UIColor *)bgColor andBgAlpha:(float)bgAlpha andDelay:(NSInteger)delay;

-(void)show;

@end

@implementation Toast

#pragma mark 初始化一个toast
-(id)initWithMsg:(NSString *)msg andShowInView:(UIView *)inView andMsgFont:(UIFont *)msgFont andMsgColor:(UIColor *)msgColor andBgView:(UIView *)bgview andBgColor:(UIColor *)bgColor andBgAlpha:(float)bgAlpha andDelay:(NSInteger)delay
{
    self=[super initWithFrame:CGRECT_TOASTMESSAGEVIEW_FRAME];
    if (self) {
        self.msg=msg;
        self.inView=inView;
        self.mFont=msgFont;
        self.mColor=msgColor;
        self.bgView=bgview;
        self.bgColor=bgColor;
        self.bgAlpha=bgAlpha;
        self.delay=delay;
        [self UIconfig];
    }
    return self;
}

#pragma mark 根据传入的参数，进行界面配置
-(void)UIconfig
{
    self.layer.cornerRadius=CORNER_RADIUS;
    self.layer.masksToBounds=YES;
    
    CGSize tmsize;
//    if (iOS7) {
    CGRect rect=[self.msg boundingRectWithSize:CGSizeMake(MAX_WIDTH, 300) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.mFont} context:nil];
    tmsize=CGSizeMake(rect.size.width,rect.size.height);
//    }
//    else tmsize=[self.msg sizeWithFont:self.mFont constrainedToSize:CGSizeMake(MAX_WIDTH, 300) lineBreakMode:NSLineBreakByWordWrapping];
    
    tmsize=CGSizeMake(tmsize.width+20, tmsize.height+10);
    self.bounds=CGRectMake(0, 0, tmsize.width, tmsize.height);
    
    if (self.bgView!=nil) {
        [self addSubview:self.bgView];
        self.clipsToBounds=YES;
    }
    
        self.backgroundColor=self.bgColor;
    
    self.alpha=0;
    self.center=CGPointMake(self.inView.center.x, self.inView.bounds.size.height*0.9);
    
    UILabel *messageLabel=[[UILabel alloc]initWithFrame:self.bounds];
    messageLabel.backgroundColor=[UIColor clearColor];
    messageLabel.text=self.msg;
    messageLabel.font=self.mFont;
    messageLabel.textAlignment=NSTextAlignmentCenter;
    messageLabel.numberOfLines=0;
    messageLabel.lineBreakMode=NSLineBreakByWordWrapping;
    messageLabel.textColor=self.mColor;
    [self addSubview:messageLabel];
}

#pragma mark 显示toast
-(void)show
{
    [self.inView addSubview:self];
    [UIView animateWithDuration:0.5f animations:^{
        self.alpha=self.bgAlpha;
    } completion:^(BOOL finished) {
        [self performSelector:@selector(dismissAfterDelay) withObject:self afterDelay:self.delay];
    }];
}

#pragma mark 将当前正在显示的toast移除
-(void)dismissAfterDelay
{
    [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.alpha=0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.delegate showNext:self];
    }];
}

-(void)dismiss
{
    [self removeFromSuperview];
}

@end


@interface ToastMessageView()

@property(strong,atomic)NSMutableArray *toastArray;
@property(strong,atomic)Toast *currentToast;

@end
static ToastMessageView *g_ToastManager=nil;
@implementation ToastMessageView

#pragma mark 以单例的方式，提供一个土司视图管理实例
+(ToastMessageView *)shareToastManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (g_ToastManager==nil) {
            g_ToastManager=[[ToastMessageView alloc]init];
        }
    });
    return  g_ToastManager;
}

#pragma mark 初始化土司视图管理实例
-(id)init
{
    @synchronized(self){
        self=[super init];
        if (self) {
            _toastArray=[NSMutableArray array];
        }
    }
    return self;
}


#pragma mark 将颜色值解析为字符数组
+(NSArray *)parseColor:(UIColor *)color
{
    NSString *colorString=[NSString stringWithFormat:@"%@",color.description];
    NSArray *colorComponents=[colorString componentsSeparatedByString:@" "];
    return colorComponents;
}


#pragma mark 设定全局背景色
+(void)setTsMessageViewBackgroundColor:(UIColor *)backgroundColor
{
    NSArray *colorComponents=[self parseColor:backgroundColor];
    [[NSUserDefaults standardUserDefaults]setObject:colorComponents forKey:BACKGROUNDCOLOR];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


#pragma mark 设置全局文本色
+(void)setTsMessageViewTextColor:(UIColor *)textColor
{
    NSArray *colorComponents=[self parseColor:textColor];
    [[NSUserDefaults standardUserDefaults]setObject:colorComponents forKey:TEXTCOLOR];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


#pragma mark 从沙盒中，取出代表颜色的字符数组，并生成颜色值
+(UIColor *)getColorWithKey:(NSString *)colorKey
{
    NSArray *colorComponents=[[NSUserDefaults standardUserDefaults]objectForKey:colorKey];
    if (colorComponents.count==0 || colorComponents==nil || colorComponents.count==1) {
        return nil;
    }
    UIColor *color=nil;
    if (colorComponents.count<5) {//白色系，仅灰度和透明度
        CGFloat white=[[colorComponents objectAtIndex:1]floatValue];
        CGFloat alpha=[[colorComponents objectAtIndex:2]floatValue];
        color=[UIColor colorWithWhite:white alpha:alpha];
    }
    else//彩色系，红，绿，兰，透明度
    {
        CGFloat red=[[colorComponents objectAtIndex:1] floatValue];
        CGFloat green=[[colorComponents objectAtIndex:2] floatValue];
        CGFloat blue=[[colorComponents objectAtIndex:3]floatValue];
        CGFloat alpha=[[colorComponents objectAtIndex:4]floatValue];
        color=[UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    }
    return  color;
}


#pragma mark 显示提示信息，并自动于2秒的消失
+(void)showTsMessage:(NSString *)msg InView:(UIView *)inView
{
    [self showTsMessage:msg InView:inView DismissAfterDelay:2];
}

#pragma mark 显示提示信息，并在指定的时间后消失
+(void)showTsMessage:(NSString *)msg InView:(UIView *)inView DismissAfterDelay:(NSTimeInterval)delay
{
    if (msg==nil ||inView==nil) {
        return;
    }
    
    //取出用户指定的新配色，若无，则使用默认色
    UIColor *bgcolor= [self getColorWithKey:BACKGROUNDCOLOR];
    if (bgcolor==nil) {
        bgcolor=DEFAULT_BACKGROUND_COLOR;
    }
    
    //取出用户指定的新配色，若无，则使用默认色
    UIColor *fontColor=[self getColorWithKey:TEXTCOLOR];
    if (fontColor==nil) {
        fontColor=DEFAULT_TEXT_COLOR;
    }
    
    NSTimeInterval dismissIn=delay;
    if (delay<=0 || delay>=60) {
        dismissIn=2;
    }
    
    Toast *toast=[[Toast alloc]initWithMsg:msg andShowInView:inView andMsgFont:[UIFont systemFontOfSize:FONT_SIZE] andMsgColor:fontColor andBgView:nil andBgColor:bgcolor andBgAlpha:ALPHA_TOASTMESSAGEVIEW andDelay:dismissIn];
    toast.delegate=[ToastMessageView shareToastManager];
    [[ToastMessageView shareToastManager].toastArray addObject:toast];
    
    if ([ToastMessageView shareToastManager].toastArray.count==1) {
        [ToastMessageView shareToastManager].currentToast=toast;
        [toast show];
    }

}

/*
 *  @param msgconfig 文本属性设置：暂时开放的属性及key为：(UIFont)字体（"MsgFont"）,(UIColor)颜色（"MsgColor"）
 *  @param bgconfig  背景属性设置：暂时开放的属性及key为：自定义背景视图（"BgView"）,透明度（"BgAlpha"），颜色（"BgColor"）
 */
#pragma mark 以完全自定义的方式显示一个土司视图
+(void)showTsMessage:(NSString *)msg
   WithMessageConfig:(NSDictionary *)msgconfig
         AndBgConfig:(NSDictionary *)bgconfig
              InView:(UIView *)inView
   DismissAfterDelay:(NSTimeInterval)delay
{
    if (msg==nil ||inView==nil) {
        return;
    }

    UIFont *msgFont=nil;
    if (msgconfig!=nil && [msgconfig valueForKey:@"MsgFont"]!=nil) {
        msgFont=[msgconfig valueForKey:@"MsgFont"];
        if (msgFont.pointSize>=14 && msgFont.pointSize<=28) {
            
        }
        else msgFont=[UIFont fontWithName:msgFont.familyName size:FONT_SIZE];
    }else   msgFont=[UIFont systemFontOfSize:FONT_SIZE];
    
    UIView *bg=nil;
    if (bgconfig!=nil && [bgconfig valueForKey:@"BgView"]!=nil) {
        bg=[bgconfig valueForKey:@"BgView"];
    }
    
    //取出用户指定的新配色，若无，则使用默认色
    UIColor *bgcolor=nil;
    if (bgconfig!=nil && [bgconfig valueForKey:@"BgColor"]!=nil) {
        bgcolor=[bgconfig valueForKey:@"BgColor"];
    }
    if (bgcolor==nil) {
        bgcolor=[self getColorWithKey:BACKGROUNDCOLOR];
    }
    if (bgcolor==nil) {
        bgcolor=DEFAULT_BACKGROUND_COLOR;
    }
    
    CGFloat tsAlpha=ALPHA_TOASTMESSAGEVIEW;
    if (bgconfig!=nil && [bgconfig valueForKey:@"BgAlpha"]!=nil && [[bgconfig valueForKey:@"BgAlpha"] floatValue]>0 && [[bgconfig valueForKey:@"BgAlpha"] floatValue]<=1) {
        tsAlpha=[[bgconfig valueForKey:@"BgAlpha"] floatValue];
    }

    //取出用户指定的新配色，若无，则使用默认色
    UIColor *fontColor=nil;
    if (msgconfig!=nil && [msgconfig valueForKey:@"MsgColor"]!=nil) {
        fontColor=[msgconfig valueForKey:@"MsgColor"];
    }
    //[self getColorWithKey:TEXTCOLOR];
    if (fontColor==nil) {
        fontColor=[self getColorWithKey:TEXTCOLOR];
    }
    if (fontColor==nil) {
        fontColor=DEFAULT_TEXT_COLOR;
    }
    
    NSTimeInterval dismissIn=delay;
    if (delay<=0 || delay>=60) {
        dismissIn=2;
    }
    Toast *toast=[[Toast alloc]initWithMsg:msg andShowInView:inView andMsgFont:msgFont andMsgColor:fontColor andBgView:bg andBgColor:bgcolor andBgAlpha:tsAlpha andDelay:dismissIn];
    toast.delegate=[ToastMessageView shareToastManager];
    
    [[ToastMessageView shareToastManager].toastArray addObject:toast];
    
    if ([ToastMessageView shareToastManager].toastArray.count==1) {
        [ToastMessageView shareToastManager].currentToast=toast;
        [toast show];
    }
}

#pragma mark 显示队列中的下一项可用的土司视图
-(void)showNext:(Toast *)toast
{
    [_toastArray removeObject:toast];
    Toast *t=[_toastArray firstObject];
    self.currentToast=t;
    [t show];
}

+(void)showTsMessage:(NSString *)msg inView:(UIView *)inView replaceCurrentIfExists:(BOOL)shouldReplace
{
    if (msg==nil ||inView==nil) {
        return;
    }
    if (shouldReplace==NO) {
        [self showTsMessage:msg InView:inView DismissAfterDelay:2];
    }
    else
    {
        [[ToastMessageView shareToastManager].currentToast dismiss];
        //取出用户指定的新配色，若无，则使用默认色
        UIColor *bgcolor= [self getColorWithKey:BACKGROUNDCOLOR];
        if (bgcolor==nil) {
            bgcolor=DEFAULT_BACKGROUND_COLOR;
        }
        
        //取出用户指定的新配色，若无，则使用默认色
        UIColor *fontColor=[self getColorWithKey:TEXTCOLOR];
        if (fontColor==nil) {
            fontColor=DEFAULT_TEXT_COLOR;
        }
        
        NSTimeInterval dismissIn=2;
        
        Toast *toast=[[Toast alloc]initWithMsg:msg andShowInView:inView andMsgFont:[UIFont systemFontOfSize:FONT_SIZE] andMsgColor:fontColor andBgView:nil andBgColor:bgcolor andBgAlpha:ALPHA_TOASTMESSAGEVIEW andDelay:dismissIn];
        toast.delegate=[ToastMessageView shareToastManager];
        
        [ToastMessageView shareToastManager].currentToast=toast;
        
        [toast show];
    }
}

@end
