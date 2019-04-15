#ifndef define_h
#define define_h


#define BT_NAV_HEIGHT (NAVCONTENT_HEIGHT + STATUSBAR_HEIGHT)

#define BT_NAVCONTENT_HEIGHT 44

#define BT_STATUS_BAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height

#define BT_HOME_INDICATOR_HEIGHT (BT_UI_IS_IPHONEX ? 34.f : 0.f)

#define BT_HOME_INDICATOR_HEIGHT_SMALL (BT_UI_IS_IPHONEX ? 14.f : 0.f)

#define BT_TAB_HEIGHT (BT_UI_IS_IPHONEX ? (49.f+34.f) : 49.f)

#define BT_UI_IS_IPHONEX ((BT_SCREEN_W == 375.f && BT_SCREEN_H == 812.f ? YES : NO) || (BT_SCREEN_W == 414.f && BT_SCREEN_H == 896.f ? YES : NO))

#define BT_APP        [UIApplication sharedApplication]

#define BT_APP_WINDOW          [UIApplication sharedApplication].delegate.window

#define BT_APP_DELEGATE       ((AppDelegate*)([UIApplication sharedApplication].delegate))

#define BT_ROOT_VC [UIApplication sharedApplication].delegate.window.rootViewController

#define BT_NOTIFI_CENTER [NSNotificationCenter defaultCenter]

#define BT_SYS_VER [[UIDevice currentDevice].systemVersion doubleValue]

#define BT_SCREEN_W ([[UIScreen mainScreen] bounds].size.width)

#define BT_SCREEN_H [[UIScreen mainScreen] bounds].size.height

#define BT_SCREEN_BOUNDS [UIScreen mainScreen].bounds

#define BT_SCALE_6_W(with) ((with)*(BT_SCREEN_W/375.0f))

#define BT_SCALE_6_H(height) ((with)*(BT_SCREEN_H/667.0f))

#define BT_SYS_FONT(size,weight) [UIFont systemFontOfSize:Size weight:Weight]

#define BT_STR_FORMAT(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

#define BT_CLEAR_COLOR [UIColor clearColor]

#define BT_WHITE_COLOR [UIColor whiteColor]

#define BT_BLACK_COLOR [UIColor blackColor]

#define BT_GRAY_COLOR [UIColor grayColor]

#define BT_LIGHT_COLOR [UIColor lightGrayColor]

#define BT_BLUE_COLOR [UIColor blueColor]

#define BT_RED_COLOR [UIColor redColor]

#define BT_GROUP_TABLE_BG_COLOR [UIColor groupTableViewBackgroundColor]

#define BT_RGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

#define BT_RGBA(r, g, b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#define BT_RANDOM_COLOR    BT_RGB(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))

#define BT_MAIN_COLOR [UIColor redColor]

#define BT_IMAGE(name) [UIImage imageNamed:name]

#define BT_SAFE_STR(str) (str!=nil ? str:@"")

#define BT_PLACE_HOLDER IMAGE(@"default_bg")

#define BT_URL(url) (url!=nil ? [NSURL URLWithString:url]:[NSURL URLWithString:@"http://www.baidu.com/default.png"])

#define BT_IS_EMPTY_STR(str) [BTUtils isEmpty:str]


#ifdef DEBUG
#define BTLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define BTLog(...)
#endif

#endif /* define_h */
