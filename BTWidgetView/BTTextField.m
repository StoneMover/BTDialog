//
//  BTTextField.m
//  live
//
//  Created by stonemover on 2019/5/7.
//  Copyright © 2019 stonemover. All rights reserved.
//

#import "BTTextField.h"

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
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    return self;
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
    self.attributedPlaceholder=[[NSAttributedString  alloc]initWithString:self.placeholder attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:placeHolderFontSize weight:UIFontWeightMedium]}];
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

@end
