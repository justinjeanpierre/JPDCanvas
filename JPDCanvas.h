//
//  JPDCanvas.h
//  
//
//  Created by Justin Jean-Pierre on 11-06-11.
//  Copyright 2011 Jean-Pierre Digital Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

/** JPDCanvas will draw user touches on screen.
 
 */

@interface JPDCanvas : UIView <UIScrollViewDelegate> {
    UIColor *strokeColor;
    float lineWidth;
}

/**
 @name Properties
 */

/** Specifies the colour used to draw the stroke.
 
 */
@property (nonatomic, strong) UIColor *strokeColor;

/** Specifies the width of each stroke.
 */
@property (nonatomic, readwrite) float lineWidth;

/**
 @name Instance Methods
 */

/**  Deletes any paths (lines) currently in the view.
 @param sender    ignored
 */

-(void)deletePaths:(id)sender;

/** Saves image.png in device's /Documents folder
 
 */
-(void)saveAsPNG;

/** Saves image as a PNG with specified filename, at specified path
 
 
 @param fileName    image will be saved as this string with .png extension
 @param Path        desired location for saved file
 */
-(void)saveAsPNGWithName:(NSString *)fileName atPath:(NSString *)Path;

@end
