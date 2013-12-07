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

import flash.events.Event;

import starling.events.Event;

public class BillFriends extends Screen{

    // Properties
    private var _appModel:AppModel;

    private var _list:List;
    private var _scrolContainer:ScrollContainer;
    private var _friendsListCollection:ListCollection;

    // Constructor
    public function BillFriends()
    {
        trace('[BillFriends]');

        _appModel = AppModel.getInstance();
        _appModel.addEventListener(AppModel.ARRAY_FRIENDS_VO_CHANGED, arrFriendsVOChangedHandler);
        _appModel.currentBill.addEventListener(BillModel.ARR_FRIENDS_CHANGED, arrFriendsChangedHandler);

        _scrolContainer = new ScrollContainer();

        _list = new List();
        _friendsListCollection = new ListCollection();
        _list.addEventListener(starling.events.Event.TRIGGERED, selectFriendHandler);
    }

    // Methods
    private function arrFriendsVOChangedHandler(event:flash.events.Event):void
    {/*
        for each(var friendVO:FriendVO in _appModel.arrFriendsVO)
        {
            _friendsListCollection.addItem({name: friendVO.name, friendVO: friendVO});
        }

        _list.dataProvider = _friendsListCollection;
        _list.itemRendererProperties.labelField = "name";*/
    }

    private function arrFriendsChangedHandler(event:flash.events.Event):void {

        for each(var friendVO:FriendVO in _appModel.currentBill.arrFriends)
        {
            _friendsListCollection.addItem({name: friendVO.name, friendVO: friendVO});
        }

        _list.dataProvider = _friendsListCollection;
        _list.itemRendererProperties.labelField = "name";
    }

    private function selectFriendHandler(event:starling.events.Event):void
    {
    }

    override protected function initialize():void
    {
        _scrolContainer.addChild(_list);
        this.addChild(_scrolContainer);
    }

    override protected function draw():void
    {
        _list.width = stage.width;
        _scrolContainer.width = stage.stageWidth;
        _scrolContainer.height = stage.stageHeight - Config.HEADER_HEIGHT;
    }
}
}
