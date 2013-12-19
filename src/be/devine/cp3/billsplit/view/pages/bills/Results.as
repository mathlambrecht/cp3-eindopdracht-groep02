package be.devine.cp3.billsplit.view.pages.bills
{
import be.devine.cp3.billsplit.config.Config;
import be.devine.cp3.billsplit.model.AppModel;
import be.devine.cp3.billsplit.model.BillModel;
import be.devine.cp3.billsplit.utils.MathUtilities;
import be.devine.cp3.billsplit.vo.FriendItemVO;
import be.devine.cp3.billsplit.vo.FriendPercentageVO;
import be.devine.cp3.billsplit.vo.FriendVO;
import be.devine.cp3.billsplit.vo.ItemVO;

import feathers.controls.Button;

import feathers.controls.List;

import feathers.controls.Screen;
import feathers.data.ListCollection;

import flash.events.Event;

import starling.events.Event;

public class Results extends Screen
{
    // Properties
    private var _appModel:AppModel;
    private var _billModel:BillModel;

    private var _list:List;
    private var _listCollection:ListCollection;

    private var _button:Button;

    // Constructor
    public function Results()
    {
        _appModel = AppModel.getInstance();
        _appModel.addEventListener(AppModel.ARRAY_BILLS_VO_CHANGED, commitProperties);

        _billModel = BillModel.getInstance();
        _billModel.addEventListener(BillModel.ARR_FRIENDS_CHANGED, commitProperties);
        _billModel.addEventListener(BillModel.ARR_FRIEND_PERCENTAGE_CHANGED, commitProperties);
        _billModel.addEventListener(BillModel.ARR_ITEMS_CHANGED, commitProperties);
        _billModel.addEventListener(BillModel.ARR_FRIEND_ITEMS_CHANGED, commitProperties);

        _list = new List();
        _listCollection = new ListCollection();

        _button = new Button;
        _button.label = 'Save';
        _button.addEventListener(starling.events.Event.TRIGGERED, buttonTriggeredHandler);
    }



    // Methods
    private function commitProperties(event:flash.events.Event):void
    {
        _listCollection.removeAll();

        if(_billModel.splitMethod == 'percentage')
        {
            for each(var friendVO:FriendVO in _billModel.arrFriends)
            {
                for each(var friendPercentageVO:FriendPercentageVO in _billModel.arrFriendPercentage)
                {
                    if(friendVO.id == friendPercentageVO.idFriend)
                    {
                        _listCollection.addItem({value:friendVO.name + ' totaal: €' + MathUtilities.calculatePercentageByFriend(friendPercentageVO.percentage)});
                    }
                }
            }
        }
        else
        {
            for each(var friendVO:FriendVO in _billModel.arrFriends)
            {
                var price:Number = 0;

                for each(var friendItemVO:FriendItemVO in _billModel.arrFriendItems)
                {
                    if(friendItemVO.idFriend == friendVO.id)
                    {
                        for each(var itemVO:ItemVO in _billModel.arrItems)
                        {
                            if(friendItemVO.idItem == itemVO.id)
                            {
                                price += itemVO.value;
                            }
                        }
                    }
                }

                _listCollection.addItem({value: friendVO.name + ' totaal: €' + price});
            }
        }

        _list.dataProvider = _listCollection;
        _list.itemRendererProperties.labelField = "value";
    }

    private function buttonTriggeredHandler(event:starling.events.Event):void
    {
        _appModel.saveBill();
    }

    override protected function initialize():void
    {
        super.initialize();
        addChild(_list);
        addChild(_button);
    }

    override protected function draw():void
    {
        super.draw();

        _button.width = this.width;
        _button.height = Config.HEADER_HEIGHT;
        _button.y = this.height - _button.height;

        _list.setSize(this.width, this.height - _button.height);
    }
}
}
