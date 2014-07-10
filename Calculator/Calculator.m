//
//  Calculator.m
//  Calculator
//
//  Created by Mauricio Minestrelli on 7/2/14.
//  Copyright (c) 2014 Mercadolibre. All rights reserved.
//

#import "Calculator.h"
@interface Calculator(){
    id<MultiplesOfTwo> _delegates;
}
@end



@implementation Calculator
@synthesize delegate=_delegate;

-(id) init{
    if([super init]){
       
        self.ans = [NSNumber numberWithFloat:0.0];
    }
    
    return self;
}
/*
-(void)add:(float) value{
    
    NSNumber * tempNumber = [[[NSNumber alloc]initWithFloat:([self.ans floatValue]+value)]autorelease];
    self.ans = tempNumber;

    NSLog(@"%f",[self.ans floatValue]);
}

-(void)substract:(float) value{

    self.ans=[[[NSNumber alloc]initWithFloat:([self.ans floatValue]-value)] autorelease];
    NSLog(@"%f",[self.ans floatValue]);
    
}
-(void)multiply:(float) value{
    self.ans=[[[NSNumber alloc]initWithFloat:([self.ans floatValue]*value)]autorelease];
    NSLog(@"%f",[self.ans floatValue]);
}
-(void)divide:(float) value{
    self.ans=[[[NSNumber alloc]initWithFloat:([self.ans floatValue]/value)]autorelease];
    NSLog(@"%f",[self.ans floatValue]);
}
*/
-(void) executeOperation:(id<Operation>)operation withValue: (CGFloat) value{
    self.ans=[NSNumber numberWithFloat:[operation operate:[self.ans floatValue] with:value]];
}
-(void)reset{
    self.ans = [[[NSNumber alloc]initWithFloat:0]autorelease];

}
-(void) startCalculatingMultiple2{
    
    NSMutableArray * multiplesArray = [NSMutableArray array];
    for(int i=0; i<1000; i++){
        [multiplesArray addObject:[[NSNumber alloc]initWithInt:(i*2) ]];
    }
    
    NSArray * arr = [NSArray arrayWithArray:multiplesArray];
    [self.delegate onMultipleOfTwoOperationFinished:arr];
    
}
-(NSMutableArray*)MultiplesOfTwo{
    NSMutableArray * array= [NSMutableArray array];
    int i;
    for (i=0;i<10000 ; i++) {
        [array addObject:[[NSNumber alloc]initWithInt:i*2]];
    }
    return nil;
}

-(void) dealloc{
    
    
    if (self.ans){
        [self.ans release];
    }
    [super dealloc];
}

@end
