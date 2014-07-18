//
//  DrawNotificationDelegate.h
//  Calculator
//
//  Created by Mauricio Minestrelli on 7/18/14.
//  Copyright (c) 2014 Mercadolibre. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DrawNotificationDelegate <NSObject>
-(void) onDisplayChange:(NSString*) upperDisplay withResult:(NSNumber*)result;
@end
