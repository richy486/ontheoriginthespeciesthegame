//
//  GameLayer.h
//  Evolution
//
//  Created by Richard Adem on 26/08/12.
//
//

#import "cocos2d.h"
#import "Fish.h"

@interface GameLayer : CCLayer <FishDelegate>

+(CCScene *) scene;

@end
