/*
 诸葛浩楠  18911420860
 QQ       970474775
 */
#import "TJWCustomTextView.h"

@interface TJWCustomTextView ()
{
    UILabel *placeholeLabel;
}

@end


@implementation TJWCustomTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setPlaceholder:@""];
        [self setPlaceholderColor:[UIColor lightGrayColor]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)textChanged:(NSNotification *)notification
{
    if([[self placeholder] length] == 0)
    {
        return;
    }
    
    if([[self text] length] == 0)
    {
        [[self viewWithTag:101] setAlpha:1];
    }
    else
    {
        [[self viewWithTag:101] setAlpha:0];
    }
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self textChanged:nil];
}

- (void)drawRect:(CGRect)rect
{
    if( [[self placeholder] length] > 0 )
    {
        if (placeholeLabel == nil )
        {
            placeholeLabel = [[UILabel alloc] initWithFrame:CGRectMake(8,5,self.bounds.size.width - 16,0)];
            placeholeLabel.lineBreakMode = NSLineBreakByWordWrapping;
            placeholeLabel.numberOfLines = 0;
            placeholeLabel.font = self.font;
            placeholeLabel.backgroundColor = [UIColor clearColor];
            placeholeLabel.textColor = self.placeholderColor;
            placeholeLabel.alpha = 0;
            placeholeLabel.tag = 101;
            [self addSubview:placeholeLabel];
        }
        
        placeholeLabel.text = self.placeholder;
        [placeholeLabel sizeToFit];
        [self sendSubviewToBack:placeholeLabel];
    }
    
    if( [[self text] length] == 0 && [[self placeholder] length] > 0 )
    {
        [[self viewWithTag:101] setAlpha:1];
    }
    
    [super drawRect:rect];
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
