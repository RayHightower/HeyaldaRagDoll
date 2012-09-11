//
//  RagDollSprites.m
//  HeyaldaRagDoll
//
//  Created by Jim Range on 7/16/12.
//  Copyright 2012 Heyalda Corporation. All rights reserved.
//
/*
 
 Copyright 2012 Heyalda Corporation. All rights reserved.
 
 You may use this source code in personal or commercial projects without attribution to the copyright 
 owner of this source code as long as no significant portion of this source code is distributed with
 the work product. 
 
 All digital image media included in this sample project that were created by Heyalda Corporation 
 must not be redistributed in any way; no license to do so is granted.
 
 For example, this source code can be used to create a compiled application that can be sold in the 
 Apple App Store under the condition that none of the digital images created by Heyalda Corporation 
 are included in the application and the application must not include the source code text.
 
 If you publish, distribute, or otherwise make available a significant portion of this source code, 
 you must first receive permission from Heyalda Corporation to do so.
 
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT 
 NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
 NON-INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, 
 DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 */

#import "RagDollSprites.h"

@implementation RagDollSprites

@synthesize head;
@synthesize torso;
@synthesize upperArm1;
@synthesize lowerArm1;
@synthesize upperLeg1;
@synthesize lowerLeg1;
@synthesize upperArm2;
@synthesize lowerArm2;
@synthesize upperLeg2;
@synthesize lowerLeg2;


-(id) initWithSpriteBatchNode:(CCSpriteBatchNode*)batchNode {
    self = [super init];
    if (self) {
        spriteBatchNode = batchNode;
        
        self.head = [CCSprite spriteWithSpriteFrameName:@"head.png"];
        self.torso = [CCSprite spriteWithSpriteFrameName:@"torso.png"];

        self.upperArm1 = [CCSprite spriteWithSpriteFrameName:@"upperArm.png"];
        self.lowerArm1 = [CCSprite spriteWithSpriteFrameName:@"lowerArm.png"];
        self.upperLeg1 = [CCSprite spriteWithSpriteFrameName:@"upperLeg.png"];
        self.lowerLeg1 = [CCSprite spriteWithSpriteFrameName:@"lowerLeg.png"];
        
        self.upperArm2 = [CCSprite spriteWithSpriteFrameName:@"upperArm.png"];
        self.lowerArm2 = [CCSprite spriteWithSpriteFrameName:@"lowerArm.png"];
        self.upperLeg2 = [CCSprite spriteWithSpriteFrameName:@"upperLeg.png"];
        self.lowerLeg2 = [CCSprite spriteWithSpriteFrameName:@"lowerLeg.png"];

        [spriteBatchNode addChild:head z:-1];

        [spriteBatchNode addChild:torso z:0];
        
        [spriteBatchNode addChild:upperArm1 z:2];
        [spriteBatchNode addChild:lowerArm1 z:1];

        [spriteBatchNode addChild:upperLeg1 z:-1];
        [spriteBatchNode addChild:lowerLeg1 z:-2];

        [spriteBatchNode addChild:upperArm2 z:-10];
        [spriteBatchNode addChild:lowerArm2 z:-11];
        
        [spriteBatchNode addChild:upperLeg2 z:-8];
        [spriteBatchNode addChild:lowerLeg2 z:-9];

        
    }
    
    return self;
}

-(void) dealloc {

    // Remove the sprites from the CCSpriteBatchNode that they were added to.
    if (spriteBatchNode != nil) {
        [spriteBatchNode removeChild:head cleanup:YES];

        [spriteBatchNode removeChild:torso cleanup:YES];

        [spriteBatchNode removeChild:upperArm1 cleanup:YES];
        [spriteBatchNode removeChild:lowerArm1 cleanup:YES];

        [spriteBatchNode removeChild:upperLeg1 cleanup:YES];
        [spriteBatchNode removeChild:lowerLeg1 cleanup:YES];

        [spriteBatchNode removeChild:upperArm2 cleanup:YES];
        [spriteBatchNode removeChild:lowerArm2 cleanup:YES];

        [spriteBatchNode removeChild:upperLeg2 cleanup:YES];
        [spriteBatchNode removeChild:lowerLeg2 cleanup:YES];
        
    }
    
    
    self.head = nil;
    self.torso = nil;

    self.upperArm1 = nil;
    self.lowerArm1 = nil;
    self.upperLeg1 = nil;
    self.lowerLeg1 = nil;
    
    self.upperArm2 = nil;
    self.lowerArm2 = nil;
    self.upperLeg2 = nil;
    self.lowerLeg2 = nil;

    [super dealloc];
}


@end
