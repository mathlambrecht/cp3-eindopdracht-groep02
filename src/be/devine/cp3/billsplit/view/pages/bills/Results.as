package be.devine.cp3.billsplit.view.pages.bills
{
import be.devine.cp3.billsplit.model.AppModel;
import be.devine.cp3.billsplit.model.BillModel;
import be.devine.cp3.billsplit.utils.MathUtilities;
import be.devine.cp3.billsplit.vo.FriendPercentageVO;
import be.devine.cp3.billsplit.vo.FriendVO;

import feathers.controls.List;

import feathers.controls.Screen;
import feathers.data.ListCollection;

import flash.events.Event;

public class Results extends Screen
{
    // Properties
    private var _appModel:AppModel;
    private var _billModel:BillModel;

    private var _list:List;
    private var _listCollection:ListCollection;

    // Constructor
    public function Results()
    {
        trace('[Results]');
        _appModel = AppModel.getInstance();
        _appModel.addEventListener(AppModel.ARRAY_BILLS_VO_CHANGED, commitProperties);

        _billModel = BillModel.getInstance();
        _billModel.addEventListener(BillModel.ARR_FRIENDS_CHANGED, commitProperties);
        _billModel.addEventListener(BillModel.ARR_FRIEND_PERCENTAGE_CHANGED, commitProperties);

        _list = new List();
        _listCollection = new ListCollection();
    }

    private function commitProperties(event:Event):void
    {
        _listCollection.removeAll();

        for each(var friendVO:FriendVO in _billModel.arrFriends)
        {
            for each(var friendPercentageVO:FriendPercentageVO in _billModel.arrFriendPercentage)
            {
                if(friendVO.id == friendPercentageVO.idFriend)
                {
                    _listCollection.addItem({value:MathUtilities.calculatePercentageByFriend(friendPercentageVO.percentage)});
                }
            }
        }

        _list.dataProvider = _listCollection;
        _list.itemRendererProperties.labelField = "value";
    }

    override protected function initialize():void
    {
        super.initialize();
        addChild(_list);
    }

    // Methods
    override protected function draw():void
    {
        super.draw();
        _list.setSize(this.width, this.height);
    }


}
}
