package be.devine.cp3.billsplit.view.pages.bills
{
import be.devine.cp3.billsplit.config.Config;
import be.devine.cp3.billsplit.model.AppModel;

import feathers.controls.Button;

import feathers.controls.LayoutGroup;

import feathers.controls.NumericStepper;

import feathers.controls.Screen;
import feathers.controls.TextInput;
import feathers.events.FeathersEventType;
import feathers.layout.VerticalLayout;

import starling.events.Event;

public class AddItem extends Screen
{
    // Properties
    private var _appModel:AppModel;
    
    private var _group:LayoutGroup;
    private var _descriptionInput:TextInput;
    private var _valueInput:TextInput;
    private var _amountStepper:NumericStepper;
    private var _resetButton:Button;
    private var _submitButton:Button;
    private var _addItemButton:Button;

    private var _check:Boolean;

    // Constructor
    public function AddItem()
    {
        trace('[AddItem]');
        
        _appModel = AppModel.getInstance();

        _group = new LayoutGroup();
        _group.addEventListener(FeathersEventType.CREATION_COMPLETE, groupCreationCompleteHandler);

        var layout:VerticalLayout = new VerticalLayout();
        layout.gap = 10;
        _group.layout = layout;

        _descriptionInput = new TextInput();
        _descriptionInput.text = '';
        _descriptionInput.maxChars = 25;
        _descriptionInput.restrict = "a-zA-Z ";
        _descriptionInput.prompt = 'Description';
        _descriptionInput.addEventListener(Event.CHANGE, inputChangeHandler);

        _valueInput = new TextInput();
        _valueInput.text = '';
        _valueInput.maxChars = 5;
        _valueInput.restrict = '0-9.';
        _valueInput.prompt = 'Price';
        _valueInput.addEventListener(Event.CHANGE, inputChangeHandler);

        _amountStepper = new NumericStepper();
        _amountStepper.minimum = 1;
        _amountStepper.maximum = 20;
        _amountStepper.step = 1;
        _amountStepper.value = 1;
        _amountStepper.addEventListener( Event.CHANGE, stepperChangeHandler );

        _resetButton = new Button();
        _resetButton.label = 'Reset';
        _resetButton.nameList.add( Button.ALTERNATE_NAME_QUIET_BUTTON );
        _resetButton.addEventListener( Event.TRIGGERED, clickHandler );

        _submitButton = new Button();
        _submitButton.label = 'Done';

        _addItemButton = new Button();
        _addItemButton.label = 'Add another item';
        _addItemButton.nameList.add( Button.ALTERNATE_NAME_QUIET_BUTTON );
        _addItemButton.addEventListener( Event.TRIGGERED, clickHandler );
    }

    // Methods
    private function clickHandler(event:Event):void
    {
        var button:Button = event.currentTarget as Button;

        switch (button){
            case _resetButton:
                    clearInput();
                break;
            case _submitButton:
                    _appModel.currentPage = Config.BILL_ITEMS;
                break;
            case _addItemButton:
                    clearInput();
                break;
        }
    }

    private function clearInput():void{
        _descriptionInput.text = '';
        _valueInput.text = '';
        _amountStepper.value = 1;
    }

    private function inputChangeHandler(event:Event):void
    {

    }

    private function groupCreationCompleteHandler(event:Event):void 
    {
        draw();
    }

    public function get check():Boolean {
        return _check;
    }

    public function set check(value:Boolean):void {
        if(_check == value) return;
        _check = value;
    }
    
    override protected function initialize():void
    {
        _group.addChild(_descriptionInput);
        _group.addChild(_valueInput);
        _group.addChild(_amountStepper);
        _group.addChild(_resetButton);
        _group.addChild(_submitButton);
        _group.addChild(_addItemButton);
        this.addChild(_group);
    }

    override protected function draw():void
    {

    }

    private function stepperChangeHandler(event:Event):void {
    }
}
}
