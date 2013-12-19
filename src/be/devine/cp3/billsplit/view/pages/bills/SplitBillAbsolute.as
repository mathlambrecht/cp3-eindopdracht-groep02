package be.devine.cp3.billsplit.view.pages.bills {
import be.devine.cp3.billsplit.config.Config;
import be.devine.cp3.billsplit.model.AppModel;
import be.devine.cp3.billsplit.model.BillModel;
import be.devine.cp3.billsplit.utils.Functions;
import be.devine.cp3.billsplit.vo.FriendItemVO;
import be.devine.cp3.billsplit.vo.FriendVO;
import be.devine.cp3.billsplit.vo.ItemVO;

import feathers.controls.Button;
import feathers.controls.Check;

import feathers.controls.LayoutGroup;

import feathers.controls.List;

import feathers.controls.Screen;
import feathers.controls.TextInput;
import feathers.data.ListCollection;
import feathers.events.FeathersEventType;
import feathers.layout.HorizontalLayout;

import flash.events.Event;

import starling.display.Quad;

import starling.display.Sprite;

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

    private var _bg:Quad;
    private var _textFieldGroup:LayoutGroup;
    private var _itemTextField:TextInput;
    private var _amountTextField:TextInput;

    // Constructor
    public function SplitBillAbsolute()
    {
        _appModel = AppModel.getInstance();

        _billModel = BillModel.getInstance();
        //_billModel.addEventListener(BillModel.ARR_FRIENDS_CHANGED, arrFriendsUpdateHandler);
        _billModel.addEventListener(BillModel.ARR_FRIEND_ITEMS_CHANGED, arrFriendsUpdateHandler);
        _billModel.addEventListener(BillModel.CURRENT_ITEM_INDEX_CHANGED, currentItemIndexChangedHandler);

        _list = new List();
        _listCollection = new ListCollection();
        _list.allowMultipleSelection = true;
        _list.addEventListener(starling.events.Event.CHANGE, listChangeHandler);

        _buttonGroup = new LayoutGroup();
        _buttonGroup.addEventListener(FeathersEventType.CREATION_COMPLETE, buttonGroupCreationCompleteHandler);
        _buttonGroup.layout =  new HorizontalLayout();

        _buttonPrev = new Button();
        _buttonPrev.label = '<';
        _buttonPrev.addEventListener(starling.events.Event.TRIGGERED, buttonPrevTriggeredHandler);

        _buttonNext = new Button();
        _buttonNext.label = '>';
        _buttonNext.addEventListener(starling.events.Event.TRIGGERED, buttonNextTriggeredHandler);

        _buttonReset = new Button();
        _buttonReset.label = 'Reset';
        _buttonReset.nameList.add( Button.ALTERNATE_NAME_QUIET_BUTTON );
        _buttonReset.addEventListener(starling.events.Event.TRIGGERED, buttonResetTriggeredHandler);

        _buttonSplit = new Button();
        _buttonSplit.label = 'Split';
        _buttonSplit.addEventListener(starling.events.Event.TRIGGERED, buttonSplitTriggeredHandler);

        _textFieldGroup = new LayoutGroup();
        _textFieldGroup.addEventListener(FeathersEventType.CREATION_COMPLETE, buttonGroupCreationCompleteHandler);

        _bg = new Quad(1,1,0x000000);

        _itemTextField = new TextInput();
        _itemTextField.text = '';
        _itemTextField.isEditable = false;

        _amountTextField = new TextInput();
        _amountTextField.text = '';
        _amountTextField.isEditable = false;
    }

    // Methods
    private function currentItemIndexChangedHandler(event:flash.events.Event):void
    {
        commitProperties();
    }

    private function listChangeHandler(event:starling.events.Event):void
    {
        var list:List = List(event.currentTarget);
        var listCollection:ListCollection = ListCollection(list.dataProvider);


        /* alleen selected items worden geupdate, de gedeselecteerde niet */

        /*
        if(_list.selectedItems.length >= _billModel.currentItemAmount + 1)
        {
            _list.isSelectable = false;
        }
        else if(_list.selectedItems.length <= _billModel.currentItemAmount + 1)
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

            //tmpArray.push(friendItemVO);
            _billModel.arrFriendItems = _billModel.arrFriendItems.concat(friendItemVO);
        }*/


        if(_list.selectedItems.length >= _billModel.currentItemAmount + 1)
        {
            _billModel.removeAllFriendItemsByItem(_billModel.arrItems[_billModel.currentItemIndex].id);
        }

        for(var index:uint = 0; index < listCollection.length; index++)
        {
            var item:Object = listCollection.getItemAt(index);
            var friendVO:FriendVO = item.friendVO;

            if(list.selectedIndices.indexOf(index) == -1)
            {
                for each(var friendItemVO in _billModel.arrFriendItems)
                {
                    if(friendItemVO.idFriend == friendVO.id && friendItemVO.idItem == _billModel.arrItems[_billModel.currentItemIndex].id)
                    {
                        _billModel.removeFriendItem(friendItemVO);
                    }
                }
            }
            else
            {
                var friendItemVO:FriendItemVO = new FriendItemVO();
                friendItemVO.idFriend = friendVO.id;
                friendItemVO.idItem = _billModel.arrItems[_billModel.currentItemIndex].id;
                _billModel.addFriendItem(friendItemVO);
            }
        }

        checkFriendItems();
    }

    // als friend items changed
    private function arrFriendsUpdateHandler(event:flash.events.Event):void
    {
        if(_listCollection.length != 0) _listCollection.removeAll();
        if(_billModel.arrFriendItems.length == 0) _list.selectedIndices = new <int>[];

        if(_billModel.arrItems[_billModel.currentItemIndex] == null) return;

        for each(var friendVO:FriendVO in _billModel.arrFriends)
        {
            _listCollection.addItem({name: friendVO.name, friendVO:friendVO});

            for each(var friendItemVO:FriendItemVO in _billModel.arrFriendItems)
            {
                if(friendVO.id == friendItemVO.idFriend && friendItemVO.idItem == _billModel.arrItems[_billModel.currentItemIndex].id)
                {
                    _list.selectedIndices = _list.selectedIndices.concat(new <int>[_listCollection.length-1]);
                }
            }
        }

        _list.dataProvider = _listCollection;
        _list.itemRendererProperties.labelField = "name";

        trace(_billModel.arrFriendItems);
    }

    private function commitProperties():void
    {
        if(_billModel.arrItems[_billModel.currentItemIndex] != null)
        {
            _itemTextField.text = _billModel.arrItems[_billModel.currentItemIndex].description;
            _amountTextField.text = _billModel.arrItems[_billModel.currentItemIndex].amount;
        }

        /*
       _listCollection.removeAll();


        for each(var friendVO:FriendVO in _billModel.arrFriends)
        {
            _listCollection.addItem({name: friendVO.name, friendVO:friendVO});
        }

        _list.dataProvider = _listCollection;
        _list.itemRendererProperties.labelField = "name";

*/
        arrFriendsUpdateHandler(null);
    }

    private function checkFriendItems():void
    {
        var check:Boolean = false;
        for each(var item:ItemVO in _billModel.arrItems)
        {
            var counter:uint = 0;
            for each(var friendItem:FriendItemVO in _billModel.arrFriendItems) if(friendItem.idItem == item.id) counter++;
            check = ((item.amount == counter));
        }

        if(check)
        {
            _buttonSplit.alpha = 1;
            _buttonSplit.addEventListener(starling.events.Event.TRIGGERED, buttonSplitTriggeredHandler);
        }else
        {
            _buttonSplit.alpha = 0.5;
            _buttonSplit.removeEventListener(starling.events.Event.TRIGGERED, buttonSplitTriggeredHandler);
        }
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
        _billModel.removeAllFriendItemsByItem(_billModel.arrItems[_billModel.currentItemIndex].id);
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

        trace('INIT LIST');
        addChild(_list);

        _buttonGroup.addChild(_buttonPrev);
        _buttonGroup.addChild(_buttonNext);
        _buttonGroup.addChild(_buttonReset);
        _buttonGroup.addChild(_buttonSplit);

        _textFieldGroup.addChild(_bg);
        _textFieldGroup.addChild(_itemTextField);
        _textFieldGroup.addChild(_amountTextField);

        addChild(_textFieldGroup);
        addChild(_buttonGroup);
    }

    override protected function draw():void
    {
        super.draw();

        _textFieldGroup.width = this.width;
        _textFieldGroup.height = 70;

        _bg.width = _textFieldGroup.width;
        _bg.height = _textFieldGroup.height;

        _itemTextField.width = this.width / 100 * 80;
        _itemTextField.y = _textFieldGroup.height / 2 - _itemTextField.height / 2;

        _amountTextField.width = this.width / 100 * 20;
        _amountTextField.x = this.width - _amountTextField.width;
        _amountTextField.y = _textFieldGroup.height / 2 - _amountTextField.height / 2;

        _buttonNext.width = this.width / 100 * 15;
        _buttonPrev.width = this.width / 100 * 15;
        _buttonReset.width = this.width / 100 * 35;
        _buttonSplit.width = this.width / 100 * 35;

        _buttonNext.height = Config.BUTTON_HEIGHT;
        _buttonPrev.height = Config.BUTTON_HEIGHT;
        _buttonReset.height = Config.BUTTON_HEIGHT;
        _buttonSplit.height = Config.BUTTON_HEIGHT;

        _buttonGroup.y = this.height - _buttonGroup.height;

        _list.width = this.width;
        _list.height = this.height - _buttonGroup.height - _textFieldGroup.height;
        _list.y = _textFieldGroup.height;
    }
}
}
