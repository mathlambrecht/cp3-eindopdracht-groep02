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

        _appModel = AppModel.getInstance();
        _appModel.addEventListener(AppModel.ARRAY_BILLS_VO_CHANGED, arrBillsVOChangedHandler);
    }

    private function arrBillsVOChangedHandler(event:flash.events.Event):void
    {
        _list = new List();
        _list.width = 200;
        _list.height = 800;
        this.addChild(_list);

        _billsListCollection = new ListCollection();

        for each(var billVO:BillVO in _appModel.arrBillsVO)
        {
            _billsListCollection.addItem({title: billVO.title, billVO: billVO});
        }

        _list.dataProvider = _billsListCollection;
        _list.itemRendererProperties.labelField = "title";

        _list.addEventListener(starling.events.Event.CHANGE, listChangeHandler);
    }

    private function listChangeHandler(event:starling.events.Event):void
    {
        var list:List = List(event.currentTarget);
        var item:Object = list.selectedItem;
    }

    private function layout():void
    {
    }

    override public function setSize(width:Number, height:Number):void
    {
        super.setSize(width, height);
        layout();
    }
}
}
