/*
 诸葛浩楠  18911420860
 QQ       970474775
 */

#import <UIKit/UIKit.h>

@interface TJWCustomTextView : UITextView
/*
 自定义占位符
 */
@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@end
