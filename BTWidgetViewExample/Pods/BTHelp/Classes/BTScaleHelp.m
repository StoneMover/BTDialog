//
//  BTScaleHelp.m
//  BTHelpExample
//
//  Created by apple on 2021/1/15.
//  Copyright © 2021 stonemover. All rights reserved.
//

#import "BTScaleHelp.h"
#import "BTUtils.h"

static BTScaleHelp * help = nil;

@implementation BTScaleHelp

+ (instancetype)share{
    if (help == nil) {
        help = [BTScaleHelp new];
    }
    return help;
}


+ (CGFloat)scaleViewSize:(CGFloat)value{
    return BTScaleHelp.share.scaleViewBlock(value);
}
+ (CGFloat)scaleViewSize:(CGFloat)value uiDesignWidth:(CGFloat)uiDesignWidth{
    return BTScaleHelp.share.scaleViewFullBlock(value,uiDesignWidth);
}

+ (CGFloat)scaleFontSize:(CGFloat)fontSize{
    return BTScaleHelp.share.scaleFontSizeBlock(fontSize);
}
+ (CGFloat)scaleFontSize:(CGFloat)fontSize uiDesignWidth:(CGFloat)uiDesignWidth{
    return BTScaleHelp.share.scaleFontSizeFullBlock(fontSize,uiDesignWidth);
}

- (instancetype)init{
    self = [super init];
    [self iniSelf];
    return self;
}

- (void)iniSelf{
    self.uiDesignWidth = 375;
    self.scaleViewBlock = ^CGFloat(CGFloat value) {
        return BTUtils.SCREEN_W / self.uiDesignWidth * value;
    };
    
    self.scaleViewFullBlock = ^CGFloat(CGFloat value, CGFloat uiDesignWidth) {
        return BTUtils.SCREEN_W / uiDesignWidth * value;
    };
    
    self.scaleFontSizeBlock = ^CGFloat(CGFloat fontSize) {
        return BTUtils.SCREEN_W / self.uiDesignWidth  * fontSize;
    };
    
    self.scaleFontSizeFullBlock = ^CGFloat(CGFloat fontSize, CGFloat uiDesignWidth) {
        return BTUtils.SCREEN_W / uiDesignWidth  * fontSize;
    };
    
}

@end
