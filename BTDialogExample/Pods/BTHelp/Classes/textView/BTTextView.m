//
//  BTTextView.m
//  word
//
//  Created by stonemover on 2019/3/13.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import "BTTextView.h"
#import "UIView+BTViewTool.h"

@interface BTTextView()

@property (nonatomic, assign) CGFloat lastHeight;

@property (nonatomic, strong) UIView * contentView;

@end


@implementation BTTextView

- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    [self initSelf];
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self initSelf];
}

- (void)initSelf{
    [self addObserver];
    self.textContainerInset=UIEdgeInsetsMake(0, 0, 0, 0);
    self.labelPlaceHolder=[[UILabel alloc] init];
    self.labelPlaceHolder.font=self.font;
    if (self.placeHolderColor) {
        self.labelPlaceHolder.textColor=self.placeHolderColor;
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
        if ([v isKindOfClass:[UIView class]]) {
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
    self.labelPlaceHolder.left=self.textContainerInset.left+3;
    self.labelPlaceHolder.top=self.textContainerInset.top;
}

- (void)textViewContentChange{
    if (self.text&&self.text.length!=0) {
        self.labelPlaceHolder.hidden=YES;
    }else{
        self.labelPlaceHolder.hidden=NO;
    }
    
    
    if (self.text&&self.maxStrNum!=0&&self.text.length>self.maxStrNum) {
        self.text=[self.text substringToIndex:self.maxStrNum];
        if (self.blockMax) {
            self.blockMax();
        }
    }
    
    if (self.blockContentChange) {
        self.blockContentChange();
    }
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    if (self.contentView) {
        [self.contentView removeObserver:self forKeyPath:@"frame"];
    }
}

@end
