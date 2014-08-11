//
//  GAViewController.m
//  BlurOrShadow
//
//  Created by Garima Agarwal on 8/11/14.
//  Copyright (c) 2014 Garima Agarwal. All rights reserved.
//

#import "GAViewController.h"
#import "UIImage+ImageEffects.h"

@interface GAViewController ()
@property(nonatomic, weak) IBOutlet UIImageView *iv;
@property(nonatomic, weak) IBOutlet UIImageView *iv1;
@property(nonatomic, weak) IBOutlet UIView *bgview;
@property(nonatomic, weak) IBOutlet UIButton *blur;
@end

@implementation GAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self addShadowToView:self.iv];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIImage*) snapshotImageInRect:(CGRect)rect{
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 1);
    //Now grab the snapshot of the screen's content
    [self.view drawViewHierarchyInRect:rect afterScreenUpdates:NO];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImage *lightImage = [snapshotImage applyBlurWithRadius:1.3 tintColor:nil saturationDeltaFactor:0.7 maskImage:nil];
    return lightImage;
}



-(void)addShadowToView:(UIView*)view
{
    CAGradientLayer *gradientTop = [CAGradientLayer layer];
    gradientTop.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 10);
    gradientTop.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:(0.0) green:(0.0) blue:(0.0) alpha:.7] CGColor], (id)[[UIColor colorWithRed:(0) green:(0) blue:(0) alpha:0.0] CGColor], nil];
    view.layer.borderWidth=1.0f;
    [view.layer insertSublayer:gradientTop atIndex:0];
}

- (IBAction)toggleLook:(id)sender {
    if([self.blur.titleLabel.text isEqualToString:@"Blur"]){
        self.bgview.alpha = 1.0;
        self.bgview.backgroundColor = [UIColor clearColor];
        self.blur.titleLabel.text = @"Shadow";
        [self.iv1 setImage:[self snapshotImageInRect:[[UIScreen mainScreen]bounds]]];
    }
    else{
        self.blur.titleLabel.text = @"Blur";
        self.bgview.alpha = 0.5;
        self.bgview.backgroundColor = [UIColor blackColor];
        
    }
}
@end
