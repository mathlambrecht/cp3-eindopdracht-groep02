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
import be.devine.cp3.billsplit.vo.FriendVO;

import feathers.controls.Button;

import feathers.controls.List;
import feathers.controls.Screen;
import feathers.controls.ScrollContainer;
import feathers.data.ListCollection;
import feathers.layout.VerticalLayout;

import flash.events.Event;

import starling.events.Event;

public class BillFriends extends Screen{

    // Properties
    private var _appModel:AppModel;

    private var _friendsList:List;
    private var _selectedFriendsList:List;
    private var _scrollContainer:ScrollContainer;
    private var _friendsListCollection:ListCollection;
    private var _selectedFriendsListCollection:ListCollection;
    private var _addFriendButton:Button;

    // Constructor
    public function BillFriends()
    {
        trace('[BillFriends]');

        _appModel = AppModel.getInstance();
        _appModel.addEventListener(AppModel.ARRAY_FRIENDS_VO_CHANGED, arrFriendsChangedHandler);
        _appModel.currentBill.addEventListener(BillModel.ARR_FRIENDS_CHANGED, arrSelectedFriendsChangedHandler);

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

        _addFriendButton = new Button();
        _addFriendButton.label = 'Add a new friend';
        _addFriendButton.addEventListener(starling.events.Event.TRIGGERED, clickHandler);
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
        if(_appModel.currentBill.arrFriends.length == 0) _friendsList.selectedIndices = new <int>[];

        for each(var friendVO:FriendVO in _appModel.arrFriendsVO)
        {
            _friendsListCollection.addItem({name: friendVO.name, friendVO: friendVO});

            for each(var billFriendVO:FriendVO in _appModel.currentBill.arrFriends)
            {
                if(FriendVO.equals(billFriendVO,friendVO)) _friendsList.selectedIndices = _friendsList.selectedIndices.concat(new <int>[_friendsListCollection.length-1]);
            }
        }

        _friendsList.dataProvider = _friendsListCollection;
        _friendsList.itemRendererProperties.labelField = 'name';
    }

    private function arrSelectedFriendsChangedHandler(event:flash.events.Event):void
    {
        if(_selectedFriendsListCollection.length != 0) _selectedFriendsListCollection.removeAll();

        for each(var selectedFriendVO:FriendVO in _appModel.currentBill.arrFriends)
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
                _appModel.currentBill.removeFriend(friendVO);
            } else {
                _appModel.currentBill.addFriend(friendVO);
            }
        }
    }

    private function clickHandler(event:starling.events.Event):void
    {
        _appModel.currentPage = Config.ADD_FRIEND;
    }

    override protected function initialize():void
    {
        trace('add');
        _scrollContainer.addChild(_selectedFriendsList);
        _scrollContainer.addChild(_friendsList);
        _scrollContainer.addChild(_addFriendButton);
        this.addChild(_scrollContainer);
    }

    override protected function draw():void
    {
        _scrollContainer.width = stage.stageWidth;
        _scrollContainer.height = stage.stageHeight;

        _friendsList.width = stage.stageWidth;
        _selectedFriendsList.width = stage.stageWidth;

        _addFriendButton.width = stage.stageWidth;
        _addFriendButton.height = 90;
    }
}
}
