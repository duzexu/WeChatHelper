//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "MMTableViewCell.h"

#import "UITextFieldDelegate.h"

@class CContact, MMUILabel, MMUIView, NSString, UIButton, UIImageView, WCUITextField;

@interface WCPayGPMemberFillMoneyCell : MMTableViewCell <UITextFieldDelegate>
{
    id <WCPayGPMemberFillMoneyCellDelegate> _delegate;
    MMUIView *_cellContentView;
    WCUITextField *_textField;
    UIImageView *_headImgView;
    MMUILabel *_nicknameLabel;
    MMUIView *_keyboardInputToolBar;
    UIImageView *_checkMarkImgView;
    MMUIView *_lineView;
    UIButton *_previousBtn;
    UIButton *_nextBtn;
    CContact *_contact;
    double _payAmount;
}

- (void).cxx_destruct;
@property(retain, nonatomic) MMUIView *cellContentView; // @synthesize cellContentView=_cellContentView;
@property(retain, nonatomic) UIImageView *checkMarkImgView; // @synthesize checkMarkImgView=_checkMarkImgView;
@property(retain, nonatomic) CContact *contact; // @synthesize contact=_contact;
@property(nonatomic) __weak id <WCPayGPMemberFillMoneyCellDelegate> delegate; // @synthesize delegate=_delegate;
- (id)genKeyboardInputToolbar;
@property(retain, nonatomic) UIImageView *headImgView; // @synthesize headImgView=_headImgView;
- (id)initWithStyle:(long long)arg1 reuseIdentifier:(id)arg2;
@property(retain, nonatomic) MMUIView *keyboardInputToolBar; // @synthesize keyboardInputToolBar=_keyboardInputToolBar;
@property(retain, nonatomic) MMUIView *lineView; // @synthesize lineView=_lineView;
- (void)makeTextFieldBecomeFirstResponder;
@property(retain, nonatomic) UIButton *nextBtn; // @synthesize nextBtn=_nextBtn;
- (void)nextTextField;
@property(retain, nonatomic) MMUILabel *nicknameLabel; // @synthesize nicknameLabel=_nicknameLabel;
@property(nonatomic) double payAmount; // @synthesize payAmount=_payAmount;
@property(retain, nonatomic) UIButton *previousBtn; // @synthesize previousBtn=_previousBtn;
- (void)previousTextField;
- (void)resignTextField;
- (void)setNextBtnEnable:(_Bool)arg1;
- (void)setPreviousBtnEnable:(_Bool)arg1;
@property(retain, nonatomic) WCUITextField *textField; // @synthesize textField=_textField;
- (void)setupContentView;
- (_Bool)textField:(id)arg1 shouldChangeCharactersInRange:(struct _NSRange)arg2 replacementString:(id)arg3;
- (void)textFieldDidChange:(id)arg1;
- (void)textFieldDidEndEditing:(id)arg1;
- (_Bool)textFieldShouldBeginEditing:(id)arg1;
- (void)updateCellContentWithContact:(id)arg1 payAmount:(double)arg2 displayName:(id)arg3 needShowSepLine:(_Bool)arg4;
- (void)updateCheckMarkImgViewWithPayAmount:(double)arg1;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

