//
//  Fish.h
//  Evolution
//
//  Created by Richard Adem on 26/08/12.
//
//

#import "cocos2d.h"


@class Fish;
@protocol FishDelegate <NSObject>

- (void) fishDidLand:(Fish*) fish;

@end

@interface Fish : CCNode
@property (assign) id<FishDelegate> delegate;
@property CGFloat speed;
@property BOOL fresh;

- (void) setUp;
- (void) fireFish:(float) power;
- (void) explode;
@end
