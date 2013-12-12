package be.devine.cp3.billsplit.view.pages.bills
{
import be.devine.cp3.billsplit.model.BillModel;
import be.devine.cp3.billsplit.view.components.CustomLayoutGroupItemRenderer;
import be.devine.cp3.billsplit.vo.FriendPercentageVO;
import be.devine.cp3.billsplit.vo.FriendVO;

import feathers.controls.List;
import feathers.controls.Screen;
import feathers.controls.renderers.IListItemRenderer;
import feathers.data.ListCollection;

import flash.events.Event;

public class SplitBillPercentage extends Screen
{
    // Properties
    private var _billModel:BillModel;

    private var _list:List;
    private var _listCollection:ListCollection;

    // Constructor
    public function SplitBillPercentage()
    {
        trace('[SplitBillPercentage]');

        _billModel = BillModel.getInstance();
        _billModel.addEventListener(BillModel.BILL_CHANGED, currentBillChangedHandler);

        _list = new List();
        _list.isSelectable = false;

        _list.itemRendererFactory = function():IListItemRenderer
        {
            var renderer:CustomLayoutGroupItemRenderer = new CustomLayoutGroupItemRenderer();
            return renderer;
        }

        _listCollection = new ListCollection();
    }

    private function currentBillChangedHandler(event:Event):void
    {
        _listCollection.removeAll();

        for each(var friendVO:FriendVO in _billModel.arrFriends)
        {
            for each(var friendPercentage:FriendPercentageVO in _billModel.arrFriendPercentage)
            {
                if(friendVO.id == friendPercentage.idFriend)
                {
                    _listCollection.addItem({value: friendPercentage.percentage, label:friendVO.name});
                }
            }
        }

        _list.dataProvider = _listCollection;
    }

    // Methods
    override protected function initialize():void
    {
        addChild(_list);
    }

    override protected function draw():void
    {
        _list.setSize(this.width, this.height);
    }
}
}
