//
//  STFileMngrVCtrler.h
//  qunarChatIphone
//
//  Created by chenjie on 15/7/24.
//
//
//  Copyright © 2022 Startalk Ltd.


#import "QIMCommonUIFramework.h"

@interface STFileMngrVCtrler : QTalkViewController

@property (nonatomic,assign) BOOL       isSelect;//是否是选择界面
@property (nonatomic,copy) NSString         * userId;
@property (nonatomic,assign) ChatType    messageSaveType;

@end
