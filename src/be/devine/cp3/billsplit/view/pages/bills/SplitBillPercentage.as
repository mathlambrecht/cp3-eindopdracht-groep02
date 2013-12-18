package be.devine.cp3.billsplit.view.pages.bills
{
import be.devine.cp3.billsplit.config.Config;
import be.devine.cp3.billsplit.model.AppModel;
import be.devine.cp3.billsplit.model.BillModel;
import be.devine.cp3.billsplit.utils.MathUtilities;
import be.devine.cp3.billsplit.view.components.CustomLayoutGroupItemRendererPercentage;
import be.devine.cp3.billsplit.vo.FriendPercentageVO;
import be.devine.cp3.billsplit.vo.FriendVO;

import feathers.controls.Button;
import feathers.controls.LayoutGroup;

import feathers.controls.List;
import feathers.controls.Screen;
import feathers.controls.renderers.IListItemRenderer;
import feathers.data.ListCollection;
import feathers.events.FeathersEventType;
import feathers.layout.HorizontalLayout;

import flash.events.Event;

import starling.events.Event;

public class SplitBillPercentage extends Screen
{
    // Properties
    private var _appModel:AppModel;
    private var _billModel:BillModel;

    private var _list:List;
    private var _listCollection:ListCollection;

    private var _buttonGroup:LayoutGroup;
    private var _buttonSubmit:Button;
    private var _buttonReset:Button;

    private var _isSplitEqual:Boolean;

    // Constructor
    public function SplitBillPercentage()
    {
        trace('[SplitBillPercentage]');

        _appModel = AppModel.getInstance();

        _billModel = BillModel.getInstance();
        _billModel.addEventListener(BillModel.BILL_CHANGED, currentBillChangedHandler);
        _billModel.addEventListener(BillModel.ARR_FRIENDS_CHANGED, arrFriendsChangedHandler);
        _billModel.addEventListener(BillModel.PERCENTAGE_LEFT_CHANGED, percentageLeftChangedHandler);

        _list = new List();
        _list.isSelectable = false;

        _list.itemRendererFactory = function():IListItemRenderer
        {
            var renderer:CustomLayoutGroupItemRendererPercentage = new CustomLayoutGroupItemRendererPercentage();
            renderer.addEventListener(starling.events.Event.CHANGE, rendererChangeHandler);
            return renderer;
        };

        _listCollection = new ListCollection();

        _buttonGroup = new LayoutGroup();
        _buttonGroup.addEventListener(FeathersEventType.CREATION_COMPLETE, buttonGroupCreationCompleteHandler);
        _buttonGroup.layout =  new HorizontalLayout();

        _buttonSubmit = new Button();
        _buttonSubmit.label = 'Split !';
        _buttonSubmit.addEventListener(starling.events.Event.TRIGGERED, _buttonSubmitTriggeredHandler);

        _buttonReset = new Button();
        _buttonReset.label = 'Reset';
        _buttonReset.addEventListener(starling.events.Event.TRIGGERED, buttonResetTriggeredHandler);
    }

    // Methods
    private function currentBillChangedHandler(event:flash.events.Event):void
    {
        _isSplitEqual = false;
        commitProperties();
    }

    private function arrFriendsChangedHandler(event:flash.events.Event):void
    {
        _isSplitEqual = true;
        commitProperties();
    }

    private function rendererChangeHandler(event:starling.events.Event):void
    {
        var tmpArray:Array = [];

        for each(var listObject:Object in _listCollection.data)
        {
            var friendPercentageVO:FriendPercentageVO = new FriendPercentageVO();
            friendPercentageVO.idFriend = listObject.idFriend;
            friendPercentageVO.percentage = listObject.value;

            tmpArray.push(friendPercentageVO);
        }

        _billModel.arrFriendPercentage = tmpArray;

        _billModel.percentageLeft = MathUtilities.calculatePercentageLeft();
    }

    private function _buttonSubmitTriggeredHandler(event:starling.events.Event):void
    {
        _appModel.currentPage = Config.RESULTS;
    }

    private function buttonResetTriggeredHandler(event:starling.events.Event):void
    {
        _isSplitEqual = true;
        commitProperties();
    }

    private function commitProperties():void
    {
        var tmpArray:Array = [];

        _listCollection.removeAll();

        if(_isSplitEqual)
        {
            var equalPercentage:Number = MathUtilities.divideEqual(_billModel.arrFriends.length);

            for each(var friendVO:FriendVO in _billModel.arrFriends)
            {
                var friendPercentageVO:FriendPercentageVO = new FriendPercentageVO();

                friendPercentageVO.idFriend = friendVO.id;
                friendPercentageVO.percentage = equalPercentage;

                tmpArray.push(friendPercentageVO);
            }

            _billModel.arrFriendPercentage = tmpArray;
        }

        for each(var friendVO:FriendVO in _billModel.arrFriends)
        {
            for each(var friendPercentage:FriendPercentageVO in _billModel.arrFriendPercentage)
            {
                if(friendVO.id == friendPercentage.idFriend)
                {
                    _listCollection.addItem({value: friendPercentage.percentage, label:friendVO.name, idFriend:friendPercentage.idFriend});
                }
            }
        }

        _list.dataProvider = _listCollection;

        _isSplitEqual = false;
    }

    private function percentageLeftChangedHandler(event:flash.events.Event):void
    {
        if(_billModel.percentageLeft == 0)
        {
            _buttonSubmit.alpha = 1;
            _buttonSubmit.addEventListener(starling.events.Event.TRIGGERED, _buttonSubmitTriggeredHandler);
        }else
        {
            _buttonSubmit.alpha = 0.5;
            _buttonSubmit.removeEventListener(starling.events.Event.TRIGGERED, _buttonSubmitTriggeredHandler);
        }
    }

    private function buttonGroupCreationCompleteHandler(event:starling.events.Event):void
    {
        draw();
    }

    override protected function initialize():void
    {
        addChild(_list);
        _buttonGroup.addChild(_buttonReset);
        _buttonGroup.addChild(_buttonSubmit);
        addChild(_buttonGroup);
    }

    override protected function draw():void
    {
        super.draw();

        _list.setSize(this.width, this.height - Config.BUTTON_HEIGHT);
        _buttonReset.setSize(this.width / 2 , Config.BUTTON_HEIGHT);
        _buttonSubmit.setSize(this.width / 2 , Config.BUTTON_HEIGHT);

        _buttonGroup.y = this.height - _buttonGroup.height;
    }
}
}
