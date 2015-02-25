#import "SBLTodoTableViewCell.h"
#import "SBLTodoConstants.h"

@interface SBLTodoTableViewCell()

@property (nonatomic, readonly) UIView *cellDivider;

@end

@implementation SBLTodoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = SBLTodoConstantsCellBackgroundColor;
        
        UIView *cellDivider = [[UIView alloc] init];
        cellDivider.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        [self addSubview:cellDivider];
        
        _cellDivider = cellDivider;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat dividerHeight = [[UIScreen mainScreen] scale];
    self.cellDivider.frame = CGRectMake(0, CGRectGetMaxY(self.bounds) - dividerHeight, CGRectGetWidth(self.bounds), dividerHeight);
}

@end
