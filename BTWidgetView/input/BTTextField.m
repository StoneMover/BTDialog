//
//  BTTextField.m
//  live
//
//  Created by stonemover on 2019/5/7.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import "BTTextField.h"
#import <BTHelp/BTUtils.h>

@implementation BTTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    [self initSelf];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    [self initSelf];
    return self;
}


- (void)initSelf{
    [self addTarget:self action:@selector(bt_beginEdit) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(bt_endEdit) forControlEvents:UIControlEventEditingDidEnd];
}

- (void)setMaxContent:(NSInteger)maxContent{
    if (_maxContent==0&&maxContent>0) {
        [self addTarget:self action:@selector(textContentChange) forControlEvents:UIControlEventEditingChanged];
    }
    _maxContent=maxContent;
}


- (void)setKern:(NSInteger)kern{
    _kern=kern;
    self.defaultTextAttributes=@{NSFontAttributeName: self.font,
                                 NSForegroundColorAttributeName:self.textColor,
                                 NSKernAttributeName:[NSNumber numberWithFloat:kern]//这里修改字符间距
                                 };
}

- (void)setPlaceHolderFontSize:(NSInteger)placeHolderFontSize{
    _placeHolderFontSize=placeHolderFontSize;
    [self setAttributedPlaceholderWithFont:[UIFont systemFontOfSize:self.placeHolderFontSize] color:self.placeHolderColor];
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor{
    _placeHolderColor = placeHolderColor;
    [self setAttributedPlaceholderWithFont:[UIFont systemFontOfSize:self.placeHolderFontSize] color:self.placeHolderColor];
}

- (CGRect)caretRectForPosition:(UITextPosition *)position
{
    CGRect originalRect = [super caretRectForPosition:position];
    
    if (originalRect.size.height>self.maxCursorH&&self.maxCursorH!=0) {
        originalRect.origin.y+=(originalRect.size.height-self.maxCursorH)/2;
        originalRect.size.height=self.maxCursorH;
    }
    
    return originalRect;
}


- (void)textContentChange{
    NSString * toBeString = self.text;
    //获取高亮部分
    UITextRange * selectedRange = [self markedTextRange];
    UITextPosition * position = [self positionFromPosition:selectedRange.start offset:0];
    if(!position || !selectedRange)
    {
        if(toBeString.length > self.maxContent)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.maxContent];
            if(rangeIndex.length ==1){
                self.text = [toBeString substringToIndex:self.maxContent];
            }else{
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, rangeIndex.location)];
                self.text = [toBeString substringWithRange:rangeRange];
            }
            if (self.maxContentBlock) {
                self.maxContentBlock();
            }
        }
        
    }
    
    if (self.changeBlock) {
        self.changeBlock();
    }
}

- (void)setText:(NSString *)text{
    [super setText:text];
    if (self.changeBlock) {
        self.changeBlock();
    }
}

- (void)addDoneView{
    [self addDoneView:@"完成"];
}


- (void)addDoneView:(NSString*)str{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, BTUtils.UI_IS_IPHONEX?45:35)];
    toolbar.tintColor = [UIColor systemBlueColor];
    toolbar.backgroundColor = [UIColor systemGrayColor];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:str style:UIBarButtonItemStylePlain target:self action:@selector(doneClick)];
    toolbar.items = @[space, bar];
    self.inputAccessoryView = toolbar;
}

- (void)doneClick{
    [self endEditing:YES];
}

- (void)bt_beginEdit{
    if (self.beginEditBlock) {
        self.beginEditBlock();
    }
}

- (void)bt_endEdit{
    if (self.endEditBlock) {
        self.endEditBlock();
    }
}

- (void)setAttributedPlaceholderWithFont:(UIFont*)font color:(UIColor*)color{
    
    if (!font) {
        font = self.font;
    }
    
    if (!color) {
        color = self.textColor;
    }
    self.attributedPlaceholder=[[NSAttributedString  alloc]initWithString:self.placeholder attributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color}];
}

@end
