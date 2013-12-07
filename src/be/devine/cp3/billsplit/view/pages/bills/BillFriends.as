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
    private var _scrolContainer:ScrollContainer;
    private var _friendsListCollection:ListCollection;
    private var _selectedFriendsListCollection:ListCollection;

    // Constructor
    public function BillFriends()
    {
        trace('[BillFriends]');

        _appModel = AppModel.getInstance();
        _appModel.addEventListener(AppModel.ARRAY_FRIENDS_VO_CHANGED, arrFriendsVOChangedHandler);
        _appModel.currentBill.addEventListener(BillModel.ARR_FRIENDS_CHANGED, arrFriendsChangedHandler);

        _scrolContainer = new ScrollContainer();
        _scrolContainer.interactionMode = ScrollContainer.INTERACTION_MODE_TOUCH;
        var layout:VerticalLayout = new VerticalLayout();
        layout.gap = 10;
        _scrolContainer.layout = layout;

        _friendsList = new List();
        _friendsList.allowMultipleSelection = true;
        _friendsListCollection = new ListCollection();
        _friendsList.addEventListener(starling.events.Event.TRIGGERED, selectFriendHandler);

        _selectedFriendsList = new List();
        _selectedFriendsListCollection = new ListCollection();
        _selectedFriendsList.addEventListener(starling.events.Event.TRIGGERED, selectFriendHandler);
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

    private function arrFriendsVOUpdateHandler():void
    {
        trace("update");
        if(_friendsListCollection.length != 0) _friendsListCollection.removeAll();

        for each(var friendVO:FriendVO in _appModel.arrFriendsVO)
        {
            _friendsListCollection.addItem({name: friendVO.name, friendVO: friendVO});

            if(_appModel.currentBill.arrFriends.length != 0)
            {
                for each(var billFriendVO:FriendVO in _appModel.currentBill.arrFriends)
                {
                    if(FriendVO.equals(billFriendVO,friendVO)) _friendsList.selectedIndices = _friendsList.selectedIndices.concat(new <int>[_friendsListCollection.length-1]);
                }
            }
        }

        _friendsList.dataProvider = _friendsListCollection;
        _friendsList.itemRendererProperties.labelField = 'name';
    }

    private function arrFriendsChangedHandler(event:flash.events.Event):void {

        for each(var friendVO:FriendVO in _appModel.currentBill.arrFriends)
        {
            _selectedFriendsListCollection.addItem({name: friendVO.name, friendVO: friendVO});
        }

        _selectedFriendsList.dataProvider = _selectedFriendsListCollection;
        _selectedFriendsList.itemRendererProperties.labelField = 'name';

        arrFriendsVOUpdateHandler();
    }

    private function selectFriendHandler(event:starling.events.Event):void
    {
    }

    override protected function initialize():void
    {
        _scrolContainer.addChild(_selectedFriendsList);
        _scrolContainer.addChild(_friendsList);
        this.addChild(_scrolContainer);
    }

    override protected function draw():void
    {
        _friendsList.width = stage.width;
        _selectedFriendsList.width = stage.width;
        _scrolContainer.width = stage.stageWidth;
        _scrolContainer.height = stage.stageHeight - Config.HEADER_HEIGHT;
    }
}
}
