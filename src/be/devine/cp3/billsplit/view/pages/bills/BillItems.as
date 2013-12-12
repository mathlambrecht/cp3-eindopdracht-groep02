/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 6/12/13
 * Time: 15:43
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billsplit.view.pages.bills {
import be.devine.cp3.billsplit.config.Config;
import be.devine.cp3.billsplit.model.AppModel;
import be.devine.cp3.billsplit.model.BillModel;
import be.devine.cp3.billsplit.vo.ItemVO;

import feathers.controls.Button;

import feathers.controls.List;
import feathers.controls.Screen;
import feathers.data.ListCollection;

import starling.events.Event;

public class BillItems extends Screen{

    //Properties
    private var _appModel:AppModel;
    private var _itemsList:List;
    private var _itemsListCollection:ListCollection;
    private var _addItemButton:Button;

    // Constructor
    public function BillItems()
    {
        trace('[BillItems]');

        _appModel = AppModel.getInstance();
        _appModel.addEventListener(BillModel.ARR_ITEMS_CHANGED, itemsChangedHandler);

        _itemsList = new List();
        _itemsListCollection = new ListCollection();
        _itemsList.addEventListener(Event.CHANGE, listChangeHandler);

        _addItemButton = new Button();
        _addItemButton.label = 'Add item';
        _addItemButton.addEventListener(Event.TRIGGERED, clickHandler);
    }

    // Methods
    private function itemsChangedHandler(event:Event):void
    {
        if(_itemsListCollection.length != 0) _itemsListCollection.removeAll();

        for each(var itemVO:ItemVO in _appModel.currentBill.arrItems)
        {
            _itemsListCollection.addItem({description: itemVO.description, value: itemVO.value, amount: itemVO.amount});
        }

        _itemsList.dataProvider = _itemsListCollection;
        _itemsList.itemRendererProperties.labelField = 'name';
    }

    private function clickHandler(event:Event):void
    {
        _appModel.currentPage = Config.ADD_ITEM;
    }

    private function listChangeHandler(event:Event):void
    {
    }

    override protected function initialize():void
    {
        this.addChild(_itemsList);
    }

    override protected function draw():void
    {
    }
}
}
