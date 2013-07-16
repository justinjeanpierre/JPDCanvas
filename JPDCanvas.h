//
//  JPDCanvas.h
//  
//
//  Created by Justin Jean-Pierre on 11-06-11.
//  Copyright 2011 Jean-Pierre Digital Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface JPDCanvas : UIView <UIScrollViewDelegate> {
    UIColor *strokeColor;
    float lineWidth;
}

@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, readwrite) float lineWidth;

-(void)deletePaths:(id)sender;
-(void)saveAsPNG;
-(void)saveAsPNGWithName:(NSString *)name atPath:(NSString *)Path;

@end
