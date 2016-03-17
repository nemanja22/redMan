#import "MyScrollerView.h"

@implementation MyScrollerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];
    if(touch.tapCount==2){
        if(self.zoomScale<1.0){
            self.zoomScale=1.0;
            UIView *vi=self.subviews[0];
            vi.center=CGPointMake(160, 240);
        }else{
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:.5];
            self.zoomScale=1.0;
            [UIView commitAnimations];
        }
    }
}


@end