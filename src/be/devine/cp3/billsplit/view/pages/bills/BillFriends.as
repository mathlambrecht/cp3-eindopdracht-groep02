/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 6/12/13
 * Time: 15:45
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billsplit.view.pages.bills {
import be.devine.cp3.billsplit.config.Config;
import be.devine.cp3.billsplit.model.AppModel;
import be.devine.cp3.billsplit.model.BillModel;
import be.devine.cp3.billsplit.utils.Functions;
import be.devine.cp3.billsplit.vo.FriendVO;

import feathers.controls.Button;
import feathers.controls.LayoutGroup;

import feathers.controls.List;
import feathers.controls.Screen;
import feathers.controls.ScrollContainer;
import feathers.data.ListCollection;
import feathers.events.FeathersEventType;
import feathers.layout.HorizontalLayout;
import feathers.layout.VerticalLayout;

import flash.events.Event;

import starling.events.Event;

public class BillFriends extends Screen{

    // Properties
    private var _appModel:AppModel;
    private var _billModel:BillModel;

    private var _scrollContainer:ScrollContainer;
    private var _buttonGroup:LayoutGroup;

    private var _friendsList:List;
    private var _selectedFriendsList:List;
    private var _friendsListCollection:ListCollection;
    private var _selectedFriendsListCollection:ListCollection;

    private var _submitButton:Button;
    private var _addFriendButton:Button;

    // Constructor
    public function BillFriends()
    {
        trace('[BillFriends]');

        _appModel = AppModel.getInstance();
        _billModel = BillModel.getInstance();
        _appModel.addEventListener(AppModel.ARRAY_FRIENDS_VO_CHANGED, arrFriendsChangedHandler);
        _billModel.addEventListener(BillModel.ARR_FRIENDS_CHANGED, arrSelectedFriendsChangedHandler);

        _scrollContainer = new ScrollContainer();
        _scrollContainer.interactionMode = ScrollContainer.INTERACTION_MODE_TOUCH;
        var layout:VerticalLayout = new VerticalLayout();
        layout.gap = 10;
        _scrollContainer.layout = layout;

        _friendsList = new List();
        _friendsList.allowMultipleSelection = true;
        _friendsListCollection = new ListCollection();
        _friendsList.addEventListener(starling.events.Event.CHANGE, friendListChangedHandler);

        _selectedFriendsList = new List();
        _selectedFriendsList.isSelectable = false;
        _selectedFriendsListCollection = new ListCollection();

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
    private function arrFriendsChangedHandler(event:flash.events.Event):void
    {
        if(_friendsListCollection.length != 0) _friendsListCollection.removeAll();

        for each(var friendVO:FriendVO in _appModel.arrFriendsVO)
        {
            _friendsListCollection.addItem({name: friendVO.name, friendVO: friendVO});
        }

        _friendsList.dataProvider = _friendsListCollection;
        _friendsList.itemRendererProperties.labelField = 'name';
    }

    private function arrFriendsUpdateHandler():void
    {
        if(_friendsListCollection.length != 0) _friendsListCollection.removeAll();
        if(_billModel.arrFriends.length == 0) _friendsList.selectedIndices = new <int>[];

        for each(var friendVO:FriendVO in _appModel.arrFriendsVO)
        {
            _friendsListCollection.addItem({name: friendVO.name, friendVO: friendVO});

            for each(var billFriendVO:FriendVO in _billModel.arrFriends)
            {
                if(Functions.equals(billFriendVO,friendVO)) _friendsList.selectedIndices = _friendsList.selectedIndices.concat(new <int>[_friendsListCollection.length-1]);
            }
        }

        _friendsList.dataProvider = _friendsListCollection;
        _friendsList.itemRendererProperties.labelField = 'name';
    }

    private function arrSelectedFriendsChangedHandler(event:flash.events.Event):void
    {
        if(_selectedFriendsListCollection.length != 0) _selectedFriendsListCollection.removeAll();

        for each(var selectedFriendVO:FriendVO in _billModel.arrFriends)
        {
            _selectedFriendsListCollection.addItem({name: selectedFriendVO.name, friendVO: selectedFriendVO});
        }

        _selectedFriendsList.dataProvider = _selectedFriendsListCollection;
        _selectedFriendsList.itemRendererProperties.labelField = 'name';

        arrFriendsUpdateHandler();
    }

    private function friendListChangedHandler(event:starling.events.Event):void
    {
        var list:List = List(event.currentTarget);
        var listCollection:ListCollection = ListCollection(list.dataProvider);

        for(var index:uint = 0; index < listCollection.length; index++)
        {
            var item:Object = listCollection.getItemAt(index);
            var friendVO:FriendVO = item.friendVO;
            if(list.selectedIndices.indexOf(index) == -1)
            {
                _billModel.removeFriend(friendVO);
            }
            else
            {
                _billModel.addFriend(friendVO);
            }
        }
    }

    private function addFriendButtonTriggeredHander(event:starling.events.Event):void
    {
        _appModel.isAddFriendInBill = true;

        _appModel.currentPage = Config.ADD_FRIEND;
    }

    private function submitButtonTriggeredHandler(event:starling.events.Event):void
    {
        _appModel.currentPage = Config.NEW_BILL;
    }

    private function buttonGroupCreationCompleteHandler(event:starling.events.Event):void {
        draw();
    }

    override protected function initialize():void
    {
        _scrollContainer.addChild(_selectedFriendsList);
        _scrollContainer.addChild(_friendsList);
        _buttonGroup.addChild(_addFriendButton);
        _buttonGroup.addChild(_submitButton);
        addChild(_scrollContainer);
        addChild(_buttonGroup);
    }

    override protected function draw():void
    {
        super.draw();

        _addFriendButton.width = this.width / 2;
        _addFriendButton.height = Config.BUTTON_HEIGHT;

        _submitButton.width = this.width / 2;
        _submitButton.height = Config.BUTTON_HEIGHT;

        _buttonGroup.y = this.height - _buttonGroup.height;

        _scrollContainer.setSize(this.width, this.height-_buttonGroup.height);

        _friendsList.width = this.width;
        _selectedFriendsList.width = this.width;
    }
}
}
