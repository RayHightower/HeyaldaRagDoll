//
//  RagDollSprites.h
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

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface RagDollSprites : NSObject {
    CCSprite* head;
    CCSprite* torso;

    CCSprite* upperArm1;
    CCSprite* lowerArm1;
    CCSprite* upperLeg1;
    CCSprite* lowerLeg1;

    CCSprite* upperArm2;
    CCSprite* lowerArm2;
    CCSprite* upperLeg2;
    CCSprite* lowerLeg2;

    CCSpriteBatchNode* spriteBatchNode; // Weak reference
}

@property (nonatomic, retain)     CCSprite* head;
@property (nonatomic, retain)     CCSprite* torso;

@property (nonatomic, retain)     CCSprite* upperArm1;
@property (nonatomic, retain)     CCSprite* lowerArm1;
@property (nonatomic, retain)     CCSprite* upperLeg1;
@property (nonatomic, retain)     CCSprite* lowerLeg1;

@property (nonatomic, retain)     CCSprite* upperArm2;
@property (nonatomic, retain)     CCSprite* lowerArm2;
@property (nonatomic, retain)     CCSprite* upperLeg2;
@property (nonatomic, retain)     CCSprite* lowerLeg2;

-(id) initWithSpriteBatchNode:(CCSpriteBatchNode*)batchNode;

@end
