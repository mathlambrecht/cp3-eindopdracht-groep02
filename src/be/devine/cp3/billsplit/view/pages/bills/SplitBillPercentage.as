package be.devine.cp3.billsplit.view.pages.bills
{
import be.devine.cp3.billsplit.view.components.CustomLayoutGroupItemRenderer;

import feathers.controls.List;
import feathers.controls.Screen;
import feathers.controls.renderers.IListItemRenderer;
import feathers.data.ListCollection;

public class SplitBillPercentage extends Screen
{
    // Properties
    private var _list:List;

    // Constructor
    public function SplitBillPercentage()
    {
        trace('[SplitBill]');

        _list = new List();
        _list.itemRendererFactory = function():IListItemRenderer
        {
            var renderer:CustomLayoutGroupItemRenderer = new CustomLayoutGroupItemRenderer();
            return renderer;
        }

        _list.dataProvider = new ListCollection
        ([
            {value: 20},
            {value: 20},
            {value: 20},
            {value: 20},
            {value: 20}
        ]);
    }

    // Methods
    override protected function initialize():void
    {
        addChild(_list);
    }

    override protected function draw():void
    {
        this.width = stage.width;
    }
}
}
