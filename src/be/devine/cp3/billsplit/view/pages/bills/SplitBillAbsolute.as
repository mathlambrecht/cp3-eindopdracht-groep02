package be.devine.cp3.billsplit.view.pages.bills {
import be.devine.cp3.billsplit.config.Config;
import be.devine.cp3.billsplit.model.AppModel;
import be.devine.cp3.billsplit.model.BillModel;
import be.devine.cp3.billsplit.vo.FriendItemVO;
import be.devine.cp3.billsplit.vo.FriendVO;

import feathers.controls.Button;
import feathers.controls.Check;

import feathers.controls.LayoutGroup;

import feathers.controls.List;

import feathers.controls.Screen;
import feathers.data.ListCollection;
import feathers.events.FeathersEventType;
import feathers.layout.HorizontalLayout;

import flash.events.Event;

import starling.events.Event;

public class SplitBillAbsolute extends Screen
{
    // Properties
    private var _appModel:AppModel;
    private var _billModel:BillModel;

    private var _list:List;
    private var _listCollection:ListCollection;

    private var _buttonGroup:LayoutGroup;
    private var _buttonPrev:Button;
    private var _buttonNext:Button;
    private var _buttonReset:Button;
    private var _buttonSplit:Button;

    // Constructor
    public function SplitBillAbsolute()
    {
        _appModel = AppModel.getInstance();

        _billModel = BillModel.getInstance();
        _billModel.addEventListener(BillModel.ARR_FRIENDS_CHANGED, arrFriendsChangedHandler);
        _billModel.addEventListener(BillModel.CURRENT_ITEM_INDEX_CHANGED, currentItemIndexChangedHandler);

        _list = new List();
        _listCollection = new ListCollection();
        _list.addEventListener(starling.events.Event.CHANGE, listChangeHandler);

        _buttonGroup = new LayoutGroup();
        _buttonGroup.addEventListener(FeathersEventType.CREATION_COMPLETE, buttonGroupCreationCompleteHandler);
        _buttonGroup.layout =  new HorizontalLayout();

        _buttonPrev = new Button(); _buttonPrev.label = 'Prev';
        _buttonNext = new Button(); _buttonNext.label = 'Next';
        _buttonReset = new Button(); _buttonReset.label = 'Reset'
        _buttonSplit = new Button(); _buttonSplit.label = 'Split'

        _buttonPrev.addEventListener(starling.events.Event.TRIGGERED, buttonPrevTriggeredHandler);
        _buttonNext.addEventListener(starling.events.Event.TRIGGERED, buttonNextTriggeredHandler);
        _buttonReset.addEventListener(starling.events.Event.TRIGGERED, buttonResetTriggeredHandler);
        _buttonSplit.addEventListener(starling.events.Event.TRIGGERED, buttonSplitTriggeredHandler);
    }

    // Methods
    private function arrFriendsChangedHandler(event:flash.events.Event):void
    {
        commitProperties();
    }

    private function currentItemIndexChangedHandler(event:flash.events.Event):void
    {
        commitProperties();
    }

    private function listChangeHandler(event:starling.events.Event):void
    {
        if(_list.selectedItems.length == _billModel.currentItemAmount)
        {
            _list.isSelectable = false;
        }
        else if(_list.selectedItems.length < _billModel.currentItemAmount)
        {
            _list.isSelectable = true;
        }

        var tmpArray:Array = [];

        for each(var friendItemVO:FriendItemVO in _billModel.arrFriendItems)
        {
            if(friendItemVO.idItem != _billModel.arrItems[_billModel.currentItemIndex].id)
            {
                tmpArray.push(friendItemVO);
            }
        }

        for each(var selectedFriend:Object in _list.selectedItems)
        {
            var friendItemVO:FriendItemVO = new FriendItemVO();
            friendItemVO.idFriend = selectedFriend.id;
            friendItemVO.idItem = _billModel.arrItems[_billModel.currentItemIndex].id;

            tmpArray.push(friendItemVO);
        }

        _billModel.arrFriendItems = tmpArray;
    }

    private function commitProperties():void
    {
        _listCollection.removeAll();

        _list.allowMultipleSelection = true;

        for each(var friendVO:FriendVO in _billModel.arrFriends)
        {
            _listCollection.addItem({name: friendVO.name, id:friendVO.id});
        }

        _list.dataProvider = _listCollection;
        _list.itemRendererProperties.labelField = "name";
    }

    private function buttonPrevTriggeredHandler(event:starling.events.Event):void
    {
        if(_billModel.currentItemIndex == 0)
        {
            _billModel.currentItemIndex = _billModel.arrItems.length - 1;
        }
        else
        {
            _billModel.currentItemIndex -= 1;
        }
    }

    private function buttonNextTriggeredHandler(event:starling.events.Event):void
    {
        if(_billModel.currentItemIndex == _billModel.arrItems.length - 1)
        {
            _billModel.currentItemIndex = 0;
        }
        else
        {
            _billModel.currentItemIndex += 1;
        }
    }

    private function buttonResetTriggeredHandler(event:starling.events.Event):void
    {
        _billModel.arrFriendItems = [];
    }

    private function buttonSplitTriggeredHandler(event:starling.events.Event):void
    {
        _appModel.currentPage = Config.RESULTS;
    }

    private function buttonGroupCreationCompleteHandler(event:starling.events.Event):void
    {
        draw();
    }

    override protected function initialize():void
    {
        addChild(_list);

        _buttonGroup.addChild(_buttonPrev);
        _buttonGroup.addChild(_buttonNext);
        _buttonGroup.addChild(_buttonReset);
        _buttonGroup.addChild(_buttonSplit);

        addChild(_buttonGroup);
    }

    override protected function draw():void
    {
        super.draw();

        _list.width = this.width;
        _buttonGroup.x = this.width/2 - _buttonGroup.width / 2;
        _buttonGroup.y = this.height - _buttonGroup.height;
    }
}
}
