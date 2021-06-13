
#import "QTalkTextView.h"
#import "QIMChatKeyBoardMacroDefine.h"
#import "QIMATGroupMemberTextAttachment.h"
#import "QIMEmojiTextAttachment.h"

@implementation QTalkTextView

@dynamic delegate;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.font = [UIFont systemFontOfSize:16.f];
        self.textColor = [UIColor blackColor];
        self.layer.borderColor = [UIColor qim_colorWithHex:0xE4E4E4].CGColor;
        self.layer.cornerRadius = 5.0f;
        self.layer.borderWidth = 0.5;
        self.contentMode = UIViewContentModeRedraw;
        self.dataDetectorTypes = UIDataDetectorTypeNone;
        self.returnKeyType = UIReturnKeySend;
        self.enablesReturnKeyAutomatically = YES;
        
        _placeHolder = nil;
        _placeHolderTextColor = [UIColor lightGrayColor];
                
        [self addTextViewNotificationObservers];
    }
    return self;
}

- (BOOL)hasATGroupMemberTextAttachment {
    //最终纯文本
    __block BOOL flag = NO;
    NSMutableString *plainString = [NSMutableString stringWithString:self.text];
    
    //替换下标的偏移量
    __block NSUInteger base = 0;
    
    //遍历
    [self.attributedText enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.text.length)
                     options:0
                  usingBlock:^(id value, NSRange range, BOOL *stop) {
                      
                      //检查类型是否是自定义NSTextAttachment类
                      if (value && [value isKindOfClass:[QIMEmojiTextAttachment class]]) {
                          //替换
                          [plainString replaceCharactersInRange:NSMakeRange(range.location + base, range.length)
                                                     withString:[((QIMEmojiTextAttachment *) value) getSendText]];
                          
                          //增加偏移量
                          base += [((QIMEmojiTextAttachment *) value) getSendText].length - 1;
                      } else if (value && [value isKindOfClass:[QIMATGroupMemberTextAttachment class]]) {
                          flag = YES;
                      }
                  }];
    
    return flag;
}

- (void)dealloc
{
    [self removeTextViewNotificationObservers];
}

- (void)deleteBackward
{
    if (IsTextContainFace(self.text)) { // 如果text中有表情
        if ([self.delegate respondsToSelector:@selector(textViewDeleteBackward:)]) {
            [self.delegate textViewDeleteBackward:self];
        }
    }else {
        
        [super deleteBackward];
    }
}

#pragma mark -QTalkTextView 方法
- (NSUInteger)numberOfLinesOfText{
    return [QTalkTextView numberOfLinesForMessage:self.text];
}

+ (NSUInteger)maxCharactersPerLine{
    return ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)? 33:109;
}

+ (NSUInteger)numberOfLinesForMessage:(NSString *)text{
    return (text.length / [QTalkTextView maxCharactersPerLine]) + 1;
}

#pragma mark -- Setters
- (void)setPlaceHolder:(NSString *)placeHolder
{
    if ([placeHolder isEqualToString:_placeHolder]) {
        return;
    }
    
    _placeHolder = [placeHolder copy];
    [self setNeedsDisplay];
}

- (void)setPlaceHolderTextColor:(UIColor *)placeHolderTextColor
{
    if ([placeHolderTextColor isEqual:_placeHolderTextColor]) {
        return;
    }
    
    _placeHolderTextColor = placeHolderTextColor;
    [self setNeedsDisplay];
}

#pragma mark -- UITextView overrides
- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    [super setTextAlignment:textAlignment];
    [self setNeedsDisplay];
}

#pragma mark -- Drawing
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (([self.text length] == 0 || [self.attributedText length] == 0) && self.placeHolder && [self.subviews count] <= 3) {
        [self.placeHolderTextColor set];
        [self.placeHolder drawInRect:CGRectInset(rect, 7.0f, 7.5f) withAttributes:[self placeholderTextAttributes]];
    }
}

#pragma mark -- Notifications
- (void)addTextViewNotificationObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveTextViewNotification:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveTextViewNotification:)
                                                 name:UITextViewTextDidBeginEditingNotification
                                               object:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveTextViewNotification:)
                                                 name:UITextViewTextDidEndEditingNotification
                                               object:self];
}

- (void)didReceiveTextViewNotification:(NSNotification *)notification
{
    [self setNeedsDisplay];
}

- (void)removeTextViewNotificationObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidChangeNotification
                                                  object:self];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidBeginEditingNotification
                                                  object:self];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidEndEditingNotification
                                                  object:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSDictionary *)placeholderTextAttributes
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.alignment = self.textAlignment;
    
    return @{ NSFontAttributeName : self.font,
              NSForegroundColorAttributeName : self.placeHolderTextColor,
              NSParagraphStyleAttributeName : paragraphStyle };
}

@end
