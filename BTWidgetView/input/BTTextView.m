//
//  BTTextView.m
//  word
//
//  Created by stonemover on 2019/3/13.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import "BTTextView.h"
#import "UIView+BTViewTool.h"
#import <BTHelp/BTUtils.h>
#import <BTHelp/NSString+BTString.h>

@interface BTTextView()

@property (nonatomic, assign) CGFloat lastHeight;

@property (nonatomic, strong) UIView * contentView;

@property (nonatomic, strong) UILabel * labelPlaceHolder;

@end


@implementation BTTextView

- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    [self initSelf];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    [self initSelf];
    return self;
}



- (void)initSelf{
    [self addObserver];
    if (!self.isSelfSetEdgeInsets) {
        self.textContainerInset=UIEdgeInsetsMake(0, -1.5, 0, 0);
    }
    self.labelPlaceHolder=[[UILabel alloc] init];
    self.labelPlaceHolder.font=self.font;
    self.labelPlaceHolder.numberOfLines = 0;
    if (self.placeHolderColor) {
        self.labelPlaceHolder.textColor=self.placeHolderColor;
    }else{
        self.labelPlaceHolder.textColor = [UIColor colorWithRed:0.24 green:0.24 blue:0.26 alpha:.3];
    }
    if (self.placeHolder) {
        self.labelPlaceHolder.text=self.placeHolder;
        [self.labelPlaceHolder sizeToFit];
    }
    [self insertSubview:self.labelPlaceHolder atIndex:0];
    if (self.text&&self.text.length!=0) {
        self.labelPlaceHolder.hidden=YES;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textViewContentChange)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self];
}

- (void)addObserver{
    UIView * view =nil;
    for (UIView * v in self.subviews) {
        if ([v isKindOfClass:NSClassFromString(@"_UITextContainerView")]) {
            view=v;
            break;
        }
    }
    
    if (view) {
        [view addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
        self.contentView=view;
    }
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"frame"]&&[object isKindOfClass:[UIView class]]) {
        UIView * view =(UIView*)object;
        if (view.frame.size.height!=self.lastHeight&&self.blockHeightChange) {
            self.blockHeightChange(view.frame.size.height);
            self.lastHeight=view.frame.size.height;
        }
    }
    
}

- (void)setText:(NSString *)text{
    [super setText:text];
    [self textViewContentChange];
}

- (void)setPlaceHolder:(NSString *)placeHolder{
    _placeHolder=placeHolder;
    self.labelPlaceHolder.text=placeHolder;
    [self.labelPlaceHolder sizeToFit];
    [self layoutSubviews];
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor{
    self.labelPlaceHolder.textColor=placeHolderColor;
    _placeHolderColor=placeHolderColor;
}

- (void)layoutSubviews{
    self.labelPlaceHolder.BTLeft=self.textContainerInset.left+3;
    self.labelPlaceHolder.BTTop=self.textContainerInset.top;
    self.labelPlaceHolder.BTWidth = self.BTWidth;
    self.labelPlaceHolder.BTHeight = [self.labelPlaceHolder.text bt_calculateStrHeight:self.BTWidth font:self.labelPlaceHolder.font];
//    [self.labelPlaceHolder sizeToFit];
}

- (void)textViewContentChange{
    if (self.text&&self.text.length!=0) {
        self.labelPlaceHolder.hidden=YES;
    }else{
        self.labelPlaceHolder.hidden=NO;
    }
    
    
    if (self.text&&self.maxStrNum!=0&&self.text.length>self.maxStrNum) {
        NSString * toBeString = self.text;
        NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.maxStrNum];
        if(rangeIndex.length ==1){
            self.text = [toBeString substringToIndex:self.maxStrNum];
        }else{
            NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, rangeIndex.location)];
            self.text = [toBeString substringWithRange:rangeRange];
        }
        if (self.blockMax) {
            self.blockMax();
        }
    }
    
    if (self.blockContentChange) {
        self.blockContentChange();
    }
    
}


- (void)setLineSpeac:(NSInteger)lineSpeac{
    _lineSpeac=lineSpeac;
    if (self.font&&self.textColor) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = self.lineSpeac;// 字体的行间距
        NSDictionary *attributes = @{NSFontAttributeName:self.font,NSParagraphStyleAttributeName:paragraphStyle,NSForegroundColorAttributeName:self.textColor};
        self.typingAttributes = attributes;
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

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    if (self.contentView) {
        [self.contentView removeObserver:self forKeyPath:@"frame"];
    }
}



@end
