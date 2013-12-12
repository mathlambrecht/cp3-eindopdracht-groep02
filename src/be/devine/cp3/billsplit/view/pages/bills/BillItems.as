/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 6/12/13
 * Time: 15:43
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billsplit.view.pages.bills {
import be.devine.cp3.billsplit.model.AppModel;
import be.devine.cp3.billsplit.model.BillModel;
import be.devine.cp3.billsplit.vo.ItemVO;

import feathers.controls.Button;
import feathers.controls.LayoutGroup;

import feathers.controls.List;
import feathers.controls.NumericStepper;
import feathers.controls.Screen;
import feathers.controls.TextInput;
import feathers.data.ListCollection;
import feathers.events.FeathersEventType;
import feathers.layout.HorizontalLayout;
import feathers.layout.VerticalLayout;

import starling.events.Event;

import flash.events.Event;

public class BillItems extends Screen{

    //Properties
    private var _appModel:AppModel;

    private var _group:LayoutGroup;
    private var _buttonGroup:LayoutGroup;

    private var _itemsList:List;
    private var _itemsListCollection:ListCollection;
    private var _descriptionInput:TextInput;
    private var _valueInput:TextInput;
    private var _amountStepper:NumericStepper;

    private var _resetButton:Button;
    private var _addItemButton:Button;

    // Constructor
    public function BillItems()
    {
        trace('[BillItems]');

        _appModel = AppModel.getInstance();
        _appModel.currentBill.addEventListener(BillModel.ARR_ITEMS_CHANGED, itemsChangedHandler);

        _group = new LayoutGroup();
        _group.addEventListener(FeathersEventType.CREATION_COMPLETE, groupCreationCompleteHandler);

        var layout:VerticalLayout = new VerticalLayout();
        layout.gap = 5;
        _group.layout = layout;

        _itemsList = new List();
        _itemsListCollection = new ListCollection();
        _itemsList.addEventListener(starling.events.Event.CHANGE, listChangeHandler);

        _descriptionInput = new TextInput();
        _descriptionInput.text = '';
        _descriptionInput.maxChars = 25;
        _descriptionInput.restrict = "a-zA-Z ";
        _descriptionInput.prompt = 'Description';
        _descriptionInput.addEventListener(starling.events.Event.CHANGE, inputChangeHandler);

        _valueInput = new TextInput();
        _valueInput.text = '';
        _valueInput.maxChars = 5;
        _valueInput.restrict = '0-9.';
        _valueInput.prompt = 'Price';
        _valueInput.addEventListener(starling.events.Event.CHANGE, inputChangeHandler);

        _amountStepper = new NumericStepper();
        _amountStepper.minimum = 1;
        _amountStepper.maximum = 20;
        _amountStepper.step = 1;
        _amountStepper.value = 1;

        _buttonGroup = new LayoutGroup();
        var buttonLayout:HorizontalLayout = new HorizontalLayout();
        buttonLayout.gap = 5;
        _buttonGroup.layout = buttonLayout;

        _resetButton = new Button();
        _resetButton.label = 'Reset';
        _resetButton.nameList.add( Button.ALTERNATE_NAME_QUIET_BUTTON );
        _resetButton.addEventListener(starling.events.Event.TRIGGERED, clickHandler);

        _addItemButton = new Button();
        _addItemButton.label = 'Add';
        _addItemButton.alpha = 0.5;
    }

    // Methods
    private function itemsChangedHandler(event:flash.events.Event):void
    {
        trace('items');
        if(_itemsListCollection.length != 0) _itemsListCollection.removeAll();

        for each(var itemVO:ItemVO in _appModel.currentBill.arrItems)
        {
            trace(itemVO);
            trace(itemVO.description);
            _itemsListCollection.addItem({id: itemVO.id, description: itemVO.description, value: itemVO.value, amount: itemVO.amount});
        }

        _itemsList.dataProvider = _itemsListCollection;
        _itemsList.itemRendererProperties.labelField = 'description';
    }

    private function clickHandler(event:starling.events.Event):void
    {
        var button:Button = event.currentTarget as Button;

        if(button == _addItemButton)
        {
            var itemVO:ItemVO = new ItemVO();
            itemVO.id = (_appModel.currentBill.arrFriends.length != 0)? _appModel.currentBill.arrFriends.length : 1 ;
            itemVO.description = _descriptionInput.text;
            itemVO.value = Number(_valueInput.text);
            itemVO.amount = _amountStepper.value;

            trace(itemVO.id);
            _appModel.currentBill.addItem(itemVO);
        }

        _descriptionInput.text = '';
        _valueInput.text = '';
        _amountStepper.value = 1;
    }

    private function inputChangeHandler(event:starling.events.Event):void
    {
        if(_descriptionInput.text.length >= 2 && _valueInput.text.length >= 1)
        {
            _addItemButton.alpha = 1;
            _addItemButton.addEventListener(starling.events.Event.TRIGGERED, clickHandler);
        }else
        {
            _addItemButton.removeEventListener(starling.events.Event.TRIGGERED, clickHandler);
            _addItemButton.alpha = 0.5;
        }
    }

    private function listChangeHandler(event:starling.events.Event):void
    {
    }

    private function groupCreationCompleteHandler(event:starling.events.Event):void
    {
        draw();
    }

    override protected function initialize():void
    {
        _group.addChild(_descriptionInput);
        _group.addChild(_valueInput);
        _group.addChild(_amountStepper);
        _buttonGroup.addChild(_resetButton);
        _buttonGroup.addChild(_addItemButton);
        _group.addChild(_buttonGroup);
        _group.addChild(_itemsList);
        this.addChild(_group);
        draw();
    }

    override protected function draw():void
    {
        super.draw();
        _descriptionInput.x = stage.stageWidth/2 - _descriptionInput.width/2;
        _valueInput.x = stage.stageWidth/2 - _valueInput.width/2;
        _amountStepper.x = stage.stageWidth/2 - _amountStepper.width/2;

        _resetButton.width = 100;
        _addItemButton.width = 100;
        _buttonGroup.x = stage.stageWidth/2 - _buttonGroup.width/2;

        _itemsList.width = stage.stageWidth;
        _itemsList.y = _itemsList.y + 30;

        _group.y = 40;
    }
}
}
