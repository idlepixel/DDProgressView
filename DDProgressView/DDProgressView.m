//
//  DDProgressView.m
//  DDProgressView
//
//  Created by Damien DeVille on 3/13/11.
//  Copyright 2011 Snappy Code. All rights reserved.
//

#import "DDProgressView.h"

#define kDefaultOuterLineWidth      2.0f
#define kDefaultGapWidth            2.0f

@implementation DDProgressView

- (id)init
{
	self = [super init];
    if (self) {
        [self configure];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame: frame] ;
	if (self)
	{
        [self configure];
	}
	return self ;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configure];
    }
    return self;
}

- (void)configure
{
    self.backgroundColor = [UIColor clearColor] ;
    
    self.innerColor = [UIColor lightGrayColor] ;
    self.outerColor = [UIColor lightGrayColor] ;
    self.emptyColor = [UIColor clearColor] ;
    self.outerLineWidth = kDefaultOuterLineWidth;
    self.gapWidth = kDefaultGapWidth;
}

- (void)setOuterLineWidth:(CGFloat)outerLineWidth
{
    outerLineWidth = MAX(0.0f, outerLineWidth);
    
    if (outerLineWidth != _outerLineWidth) {
        _outerLineWidth = outerLineWidth;
        [self setNeedsDisplay];
    }
}

- (void)setGapWidth:(CGFloat)gapWidth
{
    if (gapWidth != _gapWidth) {
        _gapWidth = gapWidth;
        [self setNeedsDisplay];
    }
}

- (void)setProgress:(float)theProgress
{
	// make sure the user does not try to set the progress outside of the bounds
    theProgress = MAX(0.0f, MIN(1.0f, theProgress));
    
    if (theProgress != _progress) {
        _progress = theProgress;
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext() ;
	
	// save the context
	CGContextSaveGState(context) ;
	
	// allow antialiasing
	CGContextSetAllowsAntialiasing(context, TRUE) ;
	
    CGFloat halfLineWidth = _outerLineWidth/2.0f;
    CGFloat radius;
    
    if (halfLineWidth > 0.0f) {
    
        // we first draw the outter rounded rectangle
        rect = CGRectInset(rect, halfLineWidth, halfLineWidth) ;
        radius = 0.5f * rect.size.height ;
        
        [_outerColor setStroke] ;
        CGContextSetLineWidth(context, _outerLineWidth) ;
        
        CGContextBeginPath(context) ;
        CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMidY(rect)) ;
        CGContextAddArcToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetMidX(rect), CGRectGetMinY(rect), radius) ;
        CGContextAddArcToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMidY(rect), radius) ;
        CGContextAddArcToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect), CGRectGetMidX(rect), CGRectGetMaxY(rect), radius) ;
        CGContextAddArcToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMidY(rect), radius) ;
        CGContextClosePath(context) ;
        CGContextDrawPath(context, kCGPathStroke) ;
    }
    
    // draw the empty rounded rectangle (shown for the "unfilled" portions of the progress
    rect = CGRectInset(rect, halfLineWidth + _gapWidth, halfLineWidth + _gapWidth) ;
	radius = 0.5f * rect.size.height ;
	
	[_emptyColor setFill] ;
	
	CGContextBeginPath(context) ;
	CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMidY(rect)) ;
	CGContextAddArcToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetMidX(rect), CGRectGetMinY(rect), radius) ;
	CGContextAddArcToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMidY(rect), radius) ;
	CGContextAddArcToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect), CGRectGetMidX(rect), CGRectGetMaxY(rect), radius) ;
	CGContextAddArcToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMidY(rect), radius) ;
	CGContextClosePath(context) ;
	CGContextFillPath(context) ;
    
	// draw the inside moving filled rounded rectangle
	radius = 0.5f * rect.size.height ;
	
	// make sure the filled rounded rectangle is not smaller than 2 times the radius
	rect.size.width *= _progress ;
	if (rect.size.width < 2 * radius)
		rect.size.width = 2 * radius ;
	
	[_innerColor setFill] ;
	
	CGContextBeginPath(context) ;
	CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMidY(rect)) ;
	CGContextAddArcToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetMidX(rect), CGRectGetMinY(rect), radius) ;
	CGContextAddArcToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMidY(rect), radius) ;
	CGContextAddArcToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect), CGRectGetMidX(rect), CGRectGetMaxY(rect), radius) ;
	CGContextAddArcToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMidY(rect), radius) ;
	CGContextClosePath(context) ;
	CGContextFillPath(context) ;
	
	// restore the context
	CGContextRestoreGState(context) ;
}

@end
