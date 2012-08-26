//
//  Fish.h
//  Evolution
//
//  Created by Richard Adem on 26/08/12.
//
//

#import "cocos2d.h"
#import "GameConfig.h"

@interface Fish : CCSprite
@property CGFloat speed;
@property BOOL fresh;

- (void) setUp;
- (void) fireFish;
@end
