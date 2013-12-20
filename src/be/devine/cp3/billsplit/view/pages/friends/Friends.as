
package be.devine.cp3.billsplit.view.pages.friends
{
import be.devine.cp3.billsplit.config.Config;
import be.devine.cp3.billsplit.model.AppModel;
import be.devine.cp3.billsplit.vo.FriendVO;

import feathers.controls.Button;

import feathers.controls.LayoutGroup;

import feathers.controls.List;
import feathers.controls.Screen;
import feathers.data.ListCollection;
import feathers.events.FeathersEventType;
import feathers.layout.HorizontalLayout;

import flash.events.Event;

import starling.events.Event;

public class Friends extends Screen
{
    // Properties
    private var _appModel:AppModel;

    private var _friendsList:List;
    private var _friendsListCollection:ListCollection;

    private var _buttonGroup:LayoutGroup;
    private var _submitButton:Button;
    private var _addFriendButton:Button;

    // Constructor
    public function Friends()
    {
        trace('[Friends]');

        _appModel = AppModel.getInstance();
        _appModel.addEventListener(AppModel.ARRAY_FRIENDS_VO_CHANGED, arrFriendsVOChangedHandler);

        _friendsList = new List();
        _friendsList.isSelectable = false;
        _friendsListCollection = new ListCollection();

        _buttonGroup = new LayoutGroup();
        _buttonGroup.addEventListener(FeathersEventType.CREATION_COMPLETE, buttonGroupCreationCompleteHandler);
        _buttonGroup.layout =  new HorizontalLayout();

        _addFriendButton = new Button();
        _addFriendButton.label = 'Add a new friend';
        _addFriendButton.nameList.add( Button.ALTERNATE_NAME_QUIET_BUTTON );
        _addFriendButton.addEventListener(starling.events.Event.TRIGGERED, addFriendButtonTriggeredHander);

        _submitButton = new Button();
        _submitButton.label = 'Done';
        _submitButton.addEventListener(starling.events.Event.TRIGGERED, submitButtonTriggeredHandler);
    }

    // Methods
    private function arrFriendsVOChangedHandler(event:flash.events.Event):void
    {
        if(_friendsListCollection.length != 0) _friendsListCollection.removeAll();

        for each(var friendVO:FriendVO in _appModel.arrFriendsVO)
        {
            _friendsListCollection.addItem({name: friendVO.name, friendVO: friendVO});
        }

        _friendsList.dataProvider = _friendsListCollection;
        _friendsList.itemRendererProperties.labelField = 'name';
    }

    private function addFriendButtonTriggeredHander(event:starling.events.Event):void
    {
        _appModel.isAddFriendInBill = false;

        _appModel.currentPage = Config.ADD_FRIEND;
    }

    private function submitButtonTriggeredHandler(event:starling.events.Event):void
    {
        _appModel.currentPage = Config.FRIENDS;
    }

    private function buttonGroupCreationCompleteHandler(event:starling.events.Event):void
    {
        draw();
    }

    override protected function initialize():void
    {
        super.initialize();
        addChild(_friendsList);
        _buttonGroup.addChild(_addFriendButton);
        _buttonGroup.addChild(_submitButton);
        addChild(_buttonGroup);
    }

    override protected function draw():void
    {
        super.draw();
        _friendsList.setSize(this.width, this.height);

        _addFriendButton.width = this.width;
        _addFriendButton.height = Config.BUTTON_HEIGHT;

        _buttonGroup.y = this.height - _buttonGroup.height;
    }
}
}
