//
//  DDProgressView.h
//  DDProgressView
//
//  Created by Damien DeVille on 3/13/11.
//  Copyright 2011 Snappy Code. All rights reserved.
//

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#elif TARGET_OS_MAC
#import "AppKitCompatibility.h"
#endif

@interface DDProgressView : UIView
{
    
}

@property (nonatomic,strong) UIColor *innerColor ;
@property (nonatomic,strong) UIColor *outerColor ;
@property (nonatomic,strong) UIColor *emptyColor ;
@property (nonatomic,assign) CGFloat progress ;
@property (nonatomic,assign) CGFloat preferredFrameHeight ;

@end
