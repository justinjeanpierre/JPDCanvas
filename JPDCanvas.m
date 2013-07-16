//
//  JPDCanvas.m
//  
//
//  Created by Justin Jean-Pierre on 11-06-11.
//  Copyright 2011 Jean-Pierre Digital Inc. All rights reserved.
//

#import "JPDCanvas.h"

@interface JPDCanvas () {
    CGMutablePathRef path;
    CGContextRef context;
    CGImageRef imgref;
}

@end


@implementation JPDCanvas

#pragma mark - lifecycle

@synthesize strokeColor;
@synthesize lineWidth;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        path = CGPathCreateMutable();
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self becomeFirstResponder];
    UITouch *touch = [[event touchesForView:self] anyObject];
    CGPoint location = [touch locationInView:self];
    CGPathMoveToPoint (path, nil, location.x, location.y);
    CGPathAddLineToPoint (path, nil, location.x, location.y);
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event touchesForView:self] anyObject];
    CGPoint location = [touch locationInView:self];
    CGPoint previousLocation = [touch previousLocationInView:self];
    CGPathMoveToPoint (path, nil, previousLocation.x, previousLocation.y);
    CGPathAddLineToPoint (path, nil, location.x, location.y);
    [self setNeedsDisplay];
}

#pragma mark - draw

-(void)drawRect:(CGRect)rect {
    context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context,4.0);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextAddPath(context,path);
    CGContextStrokePath(context);
    
    CGContextSaveGState(context);
}

#pragma mark - shake

-(BOOL)canBecomeFirstResponder{
    return YES;
}

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.subtype == UIEventSubtypeMotionShake) {
        [self deletePaths:nil];
    }
    [super motionEnded:motion withEvent:event];
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (event.subtype == UIEventSubtypeMotionShake) {
    }
    [super motionEnded:motion withEvent:event];
}

-(void)deletePaths:(id)sender {    
    CGPathRelease(path);
    path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, 0);
    CGPathAddLineToPoint(path, nil, 0, 0);
    [self setNeedsDisplay];
}

#pragma mark - save

-(void)saveAsPNG {
    // saves as "image.png" in /Documents folder
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/image.png"];
    NSData *imageData = UIImagePNGRepresentation(img);
    [imageData writeToFile:filePath atomically:YES];
}

-(void)saveAsPNGWithName:(NSString *)name atPath:(NSString *)Path {
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    NSString *slashDocuments = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *slashUser = [slashDocuments stringByAppendingPathComponent:[[NSUserDefaults standardUserDefaults] objectForKey:@"LoggedInUser"]];
    NSString *filePath = [slashUser stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", name]];
    NSData *imageData = UIImagePNGRepresentation(img);
    [imageData writeToFile:filePath atomically:YES];
}

@end
