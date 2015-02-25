#import "SBLTodoEditableTableViewCell.h"
#import "SBLTodoConstants.h"

@interface SBLTodoEditableTableViewCell()<ESCObservableInternal, UITextFieldDelegate>

@property (nonatomic, readonly) UITextField *textField;
@property (nonatomic, readonly) UIView *cellDivider;

@end

@implementation SBLTodoEditableTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self escRegisterObserverProtocol:@protocol(SBLTodoEditableTableViewCellObserver)];
        
        self.backgroundColor = SBLTodoConstantsEditableCellBackgroundColor;
        
        UIFont *placeholderFont = [SBLTodoConstants cellPlaceholderFont];
        NSDictionary *placeholderAttributes = @{ NSFontAttributeName : placeholderFont };
        NSAttributedString *placeholder = [[NSAttributedString alloc] initWithString:@"What needs to be done?" attributes:placeholderAttributes];
        
        UITextField *textField = [[UITextField alloc] init];
        textField.attributedPlaceholder = placeholder;
        textField.delegate = self;
        [self addSubview:textField];
        
        UIView *cellDivider = [[UIView alloc] init];
        cellDivider.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        [self addSubview:cellDivider];
        
        _textField = textField;
        _cellDivider = cellDivider;
        
        [self clearText];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.textField.frame = CGRectInset(self.bounds, 10, 10);

    CGFloat dividerHeight = [[UIScreen mainScreen] scale];
    self.cellDivider.frame = CGRectMake(0, CGRectGetMaxY(self.bounds) - dividerHeight, CGRectGetWidth(self.bounds), dividerHeight);
}

- (void)clearText {
    UIFont *textFont = [SBLTodoConstants cellFont];
    NSDictionary *textAttributes = @{ NSFontAttributeName : textFont };
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:@"" attributes:textAttributes];
    self.textField.attributedText = attributedText;
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.escNotifier textEntered:textField.text];
    return NO;
}

@end
