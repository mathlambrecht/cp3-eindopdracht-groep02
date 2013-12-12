package be.devine.cp3.billsplit.view.pages.bills
{
import be.devine.cp3.billsplit.model.AppModel;
import be.devine.cp3.billsplit.view.components.CustomLayoutGroupItemRenderer;
import be.devine.cp3.billsplit.vo.BillVO;
import be.devine.cp3.billsplit.vo.FriendPercentageVO;
import be.devine.cp3.billsplit.vo.FriendVO;

import feathers.controls.List;
import feathers.controls.Screen;
import feathers.controls.renderers.IListItemRenderer;
import feathers.data.ListCollection;

public class SplitBillPercentage extends Screen
{
    // Properties
    private var _appModel:AppModel;

    private var _list:List;
    private var _listCollection:ListCollection;

    // Constructor
    public function SplitBillPercentage()
    {
        trace('[SplitBill]');

        _appModel = AppModel.getInstance();

        _list = new List();
        _list.isSelectable = false;

        _list.itemRendererFactory = function():IListItemRenderer
        {
            var renderer:CustomLayoutGroupItemRenderer = new CustomLayoutGroupItemRenderer();
            return renderer;
        }

        _listCollection = new ListCollection();

        for each(var friendVO:FriendVO in _appModel.currentBill.arrFriends)
        {
            for each(var friendPercentage:FriendPercentageVO in _appModel.currentBill.arrFriendPercentage)
            {
                if(friendVO.id = friendPercentage.idFriend)
                {
                    _listCollection.addItem({value: friendPercentage.percentage, label:friendVO.name});
                }
            }
        }
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
