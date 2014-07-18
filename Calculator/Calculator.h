//
//  Calculator.h
//  Calculator
//
//  Created by Mauricio Minestrelli on 7/2/14.
//  Copyright (c) 2014 Mercadolibre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Operation.h"
#import "DrawNotificationDelegate.h"


@interface Calculator : NSObject
@property (nonatomic,strong) NSNumber * ans;
@property (nonatomic,assign) id<DrawNotificationDelegate> delegate;

-(void)operationPressed:(id<Operation>)operation;
-(NSString*) lastOperationPerformed;
-(NSString*) lastOperationString;
-(void) numberPressed:(NSString *) number;
-(void) commaPressed;
-(void)reset;
-(void) printHistory;
-(void) executeOperation;

@end
