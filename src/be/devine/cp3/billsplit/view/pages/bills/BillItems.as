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
import be.devine.cp3.billsplit.utils.Functions;
import be.devine.cp3.billsplit.utils.MathUtilities;
import be.devine.cp3.billsplit.vo.ItemVO;
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
    private var _billModel:BillModel;

    private var _addItemgroup:LayoutGroup;
    private var _addItemButtonGroup:LayoutGroup;
    private var _buttonGroup:LayoutGroup;

    private var _itemsList:List;
    private var _itemsListCollection:ListCollection;
    
    private var _descriptionInput:TextInput;
    private var _valueInput:TextInput;
    private var _amountStepper:NumericStepper;

    private var _clearButton:Button;
    private var _addItemButton:Button;
    private var _resetButton:Button;
    private var _submitButton:Button;

    // Constructor
    public function BillItems()
    {
        trace('[BillItems]');

        _appModel = AppModel.getInstance();
        _billModel = BillModel.getInstance();
        _billModel.addEventListener(BillModel.ARR_ITEMS_CHANGED, itemsChangedHandler);

        _addItemgroup = new LayoutGroup();
        _addItemgroup.addEventListener(FeathersEventType.CREATION_COMPLETE, groupCreationCompleteHandler);
        _addItemgroup.layout = new VerticalLayout();

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
        _valueInput.maxChars = 8;
        _valueInput.restrict = '0-9.';
        _valueInput.prompt = 'Price';
        _valueInput.addEventListener(starling.events.Event.CHANGE, inputChangeHandler);

        _addItemButtonGroup = new LayoutGroup();
        _addItemButtonGroup.addEventListener(FeathersEventType.CREATION_COMPLETE, groupCreationCompleteHandler);
        _addItemButtonGroup.layout = new HorizontalLayout();
        
        _amountStepper = new NumericStepper();
        _amountStepper.minimum = 1;
        _amountStepper.maximum = 20;
        _amountStepper.step = 1;
        _amountStepper.value = 1;

        _clearButton = new Button();
        _clearButton.label = 'Clear';
        _clearButton.nameList.add( Button.ALTERNATE_NAME_QUIET_BUTTON );
        _clearButton.addEventListener(starling.events.Event.TRIGGERED, clearButtonTriggeredHandler);

        _addItemButton = new Button();
        _addItemButton.label = 'Add';
        _addItemButton.alpha = 0.5;

        _buttonGroup = new LayoutGroup();
        _buttonGroup.addEventListener(FeathersEventType.CREATION_COMPLETE, groupCreationCompleteHandler);
        _buttonGroup.layout = new HorizontalLayout();
        
        _resetButton = new Button();
        _resetButton.label = 'Reset';
        _resetButton.nameList.add( Button.ALTERNATE_NAME_QUIET_BUTTON );
        _resetButton.addEventListener(starling.events.Event.TRIGGERED, resetButtonTriggeredHandler);

        _submitButton = new Button();
        _submitButton.label = 'Done';
        _submitButton.addEventListener(starling.events.Event.TRIGGERED, submitButtonTriggeredHandler);
    }

    // Methods
    private function itemsChangedHandler(event:flash.events.Event):void
    {
        if(_itemsListCollection.length != 0) _itemsListCollection.removeAll();

        for each(var itemVO:ItemVO in _billModel.arrItems)
        {
            _itemsListCollection.addItem({id:itemVO.id, description:itemVO.description, value:itemVO.value, amount:itemVO.amount, itemVO:itemVO});
        }

        _itemsList.dataProvider = _itemsListCollection;
        _itemsList.itemRendererProperties.labelField = 'description';
    }

    private function addItemButtonTriggeredHandler(event:starling.events.Event):void
    {
        var itemVO:ItemVO = new ItemVO();
        itemVO.id = (_billModel.arrFriends.length != 0)? _billModel.arrFriends.length : 1 ;
        itemVO.description = _descriptionInput.text;
        itemVO.value = Number(_valueInput.text);
        itemVO.amount = _amountStepper.value;

        _billModel.addItem(itemVO);
        
        clearInput();
    }

    private function clearButtonTriggeredHandler(event:starling.events.Event):void
    {
        clearInput();
    }

    private function clearInput():void
    {
        _descriptionInput.text = '';
        _valueInput.text = '';
        _amountStepper.value = 1;
    }

    private function resetButtonTriggeredHandler(event:starling.events.Event):void
    {
        _billModel.removeAllItems();
    }

    private function submitButtonTriggeredHandler(event:starling.events.Event):void
    {
        _appModel.currentPage = Config.NEW_BILL;
    }

    private function inputChangeHandler(event:starling.events.Event):void
    {
        if(_descriptionInput.text.length >= 2 && _valueInput.text.length >= 1)
        {
            _addItemButton.alpha = 1;
            _addItemButton.addEventListener(starling.events.Event.TRIGGERED, addItemButtonTriggeredHandler);
        }else
        {
            _addItemButton.removeEventListener(starling.events.Event.TRIGGERED, addItemButtonTriggeredHandler);
            _addItemButton.alpha = 0.5;
        }
    }

    private function listChangeHandler(event:starling.events.Event):void
    {
        var list:List = List(event.currentTarget);
        var selectedItem:Object = list.selectedItem;

        if(selectedItem == null) return;

        _billModel.removeItem(selectedItem.itemVO);
    }

    private function groupCreationCompleteHandler(event:starling.events.Event):void
    {
        draw();
    }

    override protected function initialize():void
    {
        _addItemgroup.addChild(_descriptionInput);
        _addItemgroup.addChild(_valueInput);
        _addItemButtonGroup.addChild(_clearButton);
        _addItemButtonGroup.addChild(_amountStepper);
        _addItemButtonGroup.addChild(_addItemButton);
        _addItemgroup.addChild(_addItemButtonGroup);
        addChild(_addItemgroup);

        addChild(_itemsList);

        _buttonGroup.addChild(_resetButton);
        _buttonGroup.addChild(_submitButton);
        addChild(_buttonGroup);
    }

    override protected function draw():void
    {
        super.draw();

        _descriptionInput.width = this.width;
        _valueInput.width = this.width;

        _clearButton.width = this.width/100 * 30;
        _addItemButton.width = this.width/100 * 30;
        _amountStepper.width = this.width - _clearButton.width - _addItemButton.width;

        _resetButton.width = this.width/2;
        _resetButton.height = Config.BUTTON_HEIGHT;

        _submitButton.width = this.width/2;
        _submitButton.height = Config.BUTTON_HEIGHT;

        _buttonGroup.y = this.height - _buttonGroup.height;

        _itemsList.y = _addItemgroup.height;
        _itemsList.setSize(this.width, this.height - _addItemgroup.height - _buttonGroup.height);
    }
}
}
