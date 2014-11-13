//
//  DLSymptomFrame.h
//  ProgrammerHealth
//
//  Created by David on 11/7/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DLSymptom;

@interface DLSymptomFrame : NSObject

/**
 *  SymptomFrame模型中的Symptom模型
 */
@property (nonatomic, strong) DLSymptom *symptom;

@property (nonatomic, assign) CGFloat contentHeight;

@end
