package be.devine.cp3.billsplit.view.pages.bills
{
import be.devine.cp3.billsplit.model.AppModel;
import be.devine.cp3.billsplit.vo.BillVO;

import feathers.controls.List;

import feathers.controls.Screen;
import feathers.data.ListCollection;

import flash.events.Event;

import starling.events.Event;


public class OldBills extends Screen
{
    // Properties
    private var _appModel:AppModel;

    private var _list:List;
    private var _billsListCollection:ListCollection;

    // Constructor
    public function OldBills()
    {
        trace('[OldBills]');

        _list = new List();
        _billsListCollection = new ListCollection();
        _list.addEventListener(starling.events.Event.CHANGE, listChangeHandler);

        _appModel = AppModel.getInstance();
        _appModel.addEventListener(AppModel.ARRAY_BILLS_VO_CHANGED, arrBillsVOChangedHandler);
    }

    private function arrBillsVOChangedHandler(event:flash.events.Event):void
    {
        for each(var billVO:BillVO in _appModel.arrBillsVO)
        {
            _billsListCollection.addItem({title: billVO.title, billVO: billVO});
        }

        _list.dataProvider = _billsListCollection;
        _list.itemRendererProperties.labelField = "title";
    }

    private function listChangeHandler(event:starling.events.Event):void
    {
        var list:List = List(event.currentTarget);
        var item:Object = list.selectedItem;
    }

    override protected function initialize():void
    {
        this.addChild(_list);
    }

    override protected function draw():void
    {
        _list.width = stage.stageWidth;
    }
}
}
