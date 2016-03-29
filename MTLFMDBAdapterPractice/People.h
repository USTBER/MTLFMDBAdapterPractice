//
//  People.h
//  MTLFMDBAdapterPractice
//
//  Created by LiChunxing on 16/3/29.
//  Copyright © 2016年 Demo. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <MTLFMDBAdapter.h>

@interface People : MTLModel
<MTLFMDBSerializing>
@property (nonatomic, readonly, assign) int personalID;
//@property (nonatomic, copy) NSString *guid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *adress;
@property (nonatomic, copy) NSString *skill;

@end
