/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 6/12/13
 * Time: 18:10
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billsplit.view.pages.friends {
import be.devine.cp3.billsplit.config.Config;
import be.devine.cp3.billsplit.model.AppModel;
import be.devine.cp3.billsplit.model.BillModel;
import be.devine.cp3.billsplit.vo.FriendVO;

import feathers.controls.Button;

import feathers.controls.LayoutGroup;

import feathers.controls.Screen;
import feathers.controls.TextInput;
import feathers.events.FeathersEventType;
import feathers.layout.HorizontalLayout;
import starling.events.Event;

public class AddFriend extends Screen{

    // Properties
    private var _appModel:AppModel;
    private var _billModel:BillModel;

    private var _group:LayoutGroup;
    private var _buttonGroup:LayoutGroup;

    private var _textInput:TextInput;
    private var _resetButton:Button;
    private var _submitButton:Button;
    // Constructor
    public function AddFriend()
    {
        trace('[AddFriend]');

        _appModel = AppModel.getInstance();
        _billModel = BillModel.getInstance();

        _group = new LayoutGroup();
        _group.addEventListener(FeathersEventType.CREATION_COMPLETE, groupCreationCompleteHandler);

        _buttonGroup = new LayoutGroup();
        _buttonGroup.addEventListener(FeathersEventType.CREATION_COMPLETE, groupCreationCompleteHandler);
        _buttonGroup.layout = new HorizontalLayout();

        _textInput = new TextInput();
        _textInput.text = '';
        _textInput.setFocus();
        _textInput.maxChars = 25;
        _textInput.restrict = "a-zA-Z ";
        _textInput.prompt = 'Name of your new friend';
        _textInput.addEventListener(Event.CHANGE, inputChangeHandler);

        _resetButton = new Button();
        _resetButton.label = 'Clear';
        _resetButton.nameList.add( Button.ALTERNATE_NAME_QUIET_BUTTON );
        _resetButton.addEventListener(Event.TRIGGERED, clickHandler);

        _submitButton = new Button();
        _submitButton.label = 'Done';
        _submitButton.alpha = 0.5;
    }

    // Methods
    private function inputChangeHandler(event:Event):void
    {
        if(_textInput.text.length >= 2){
            _submitButton.addEventListener(Event.TRIGGERED, clickHandler);
            _submitButton.alpha = 1;
        }else{
            _submitButton.removeEventListener(Event.TRIGGERED, clickHandler);
            _submitButton.alpha = 0.5;
        }
    }

    private function clickHandler(event:Event):void
    {
        var button:Button = event.currentTarget as Button;

        switch (button)
        {
            case _resetButton:
                _textInput.text = "";
                _textInput.setFocus();
                break;
            case _submitButton:

                var newFriendVO:FriendVO = new FriendVO();

                if(_appModel.arrFriendsVO == null)
                {
                    newFriendVO.id = 0;
                }
                else
                {
                    if(_appModel.arrFriendsVO.length == 0)
                    {
                        newFriendVO.id = 0;
                    }
                    else
                    {
                        var highestID:uint;
                        for each(var friendVO:FriendVO in _appModel.arrFriendsVO)
                        {
                            if (friendVO.id > highestID) highestID = friendVO.id;
                        }
                        newFriendVO.id = highestID + 1;
                    }
                }

                newFriendVO.name = _textInput.text;

                _appModel.addFriend(newFriendVO);

                if(_appModel.isAddFriendInBill)
                {
                    _billModel.addFriend(newFriendVO);
                }

                _textInput.text = 'Name of your new friend';

                if(_appModel.isAddFriendInBill)
                {
                    _appModel.currentPage = Config.BILL_FRIENDS;
                }
                else
                {
                    _appModel.currentPage = Config.FRIENDS;
                }

                _appModel.isNewFriend = true;

                _appModel.saveBill();

                break;

        }
    }

    override protected function initialize():void
    {
        _group.addChild(_textInput);
        _buttonGroup.addChild(_resetButton);
        _buttonGroup.addChild(_submitButton);
        _group.addChild(_buttonGroup);
        addChild(_group);
    }

    private function groupCreationCompleteHandler(event:Event):void
    {
        draw();
    }

    override protected function draw():void
    {
        super.draw();

        _resetButton.width = this.width/2;
        _resetButton.height = Config.BUTTON_HEIGHT;

        _submitButton.width = this.width/2;
        _submitButton.height = Config.BUTTON_HEIGHT;

        _buttonGroup.y = this.height - _buttonGroup.height;

        _textInput.setSize(this.width - 30 , 80);
        _textInput.x = this.width/2 - _textInput.width/2;
        _textInput.y = this.height/2 - _textInput.height/2 - _buttonGroup.height;

    }
}
}
