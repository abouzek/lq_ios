//
//  AVArrayTableViewAdapter.h
//  Anniversary
//
//  Created by Alan Bouzek on 12/16/14.
//  Copyright (c) 2014 Alan Bouzek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVConstants.h"

@interface AVArrayTableViewAdapter : NSObject <UITableViewDataSource, UITableViewDelegate>

-(instancetype)initWithItems:(NSArray *)items
              cellIdentifier:(NSString *)cellIdentifier
          cellConfigureBlock:(AVCellConfigureBlock)cellConfigureBlock
            selectItemBlock:(AVSelectItemBlock)selectItemBlock;

@end
