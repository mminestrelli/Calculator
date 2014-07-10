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
