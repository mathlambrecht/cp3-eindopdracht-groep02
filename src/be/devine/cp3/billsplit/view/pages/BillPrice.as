/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 6/12/13
 * Time: 15:24
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billsplit.view.pages {
import be.devine.cp3.billsplit.config.Config;
import be.devine.cp3.billsplit.model.AppModel;

import feathers.controls.Button;
import feathers.controls.LayoutGroup;
import feathers.controls.Screen;
import feathers.controls.TextInput;
import feathers.events.FeathersEventType;
import feathers.layout.VerticalLayout;

import starling.events.Event;

public class BillPrice extends Screen{

    // Properties
    private var _appModel:AppModel;

    private var _group:LayoutGroup;
    private var _textInput:TextInput;
    private var _submitButton:Button;
    private var _resetButton:Button;

    // Constructor
    public function BillPrice()
    {
        trace('[BillPrice]');

        _appModel = AppModel.getInstance();
        createBillPrice();
    }

    // Methods
    private function createBillPrice():void
    {
        _group = new LayoutGroup();
        _group.addEventListener(FeathersEventType.CREATION_COMPLETE, groupCreationCompleteHandler);
        addChild(_group);

        var layout:VerticalLayout = new VerticalLayout();
        layout.gap = 10;

        _group.layout = layout;
        _textInput = new TextInput();
        _textInput.text = '';
        _textInput.prompt = 'Total price';
        _textInput.setFocus();
        _textInput.addEventListener(Event.CHANGE, inputChangeHandler);
        _group.addChild(_textInput);

        _resetButton = new Button();
        _resetButton.label = 'reset';
        _resetButton.nameList.add( Button.ALTERNATE_NAME_QUIET_BUTTON );
        _resetButton.addEventListener(Event.TRIGGERED, onClickHandler);
        _group.addChild(_resetButton);

        _submitButton = new Button();
        _submitButton.label = 'Ok';
        _submitButton.nameList.add( Button.STATE_DISABLED );
        _group.addChild(_submitButton);
    }

    private function inputChangeHandler(event:Event):void
    {
        if(_textInput.text.length >= 1){
            _submitButton.addEventListener(Event.TRIGGERED, onClickHandler);
            _submitButton.nameList.remove( Button.STATE_DISABLED );
        }else{
            _submitButton.removeEventListener(Event.TRIGGERED, onClickHandler);
            _submitButton.nameList.add( Button.STATE_DISABLED );
        }
    }

    private function onClickHandler(event:Event):void
    {
        var button:Button = event.currentTarget as Button;

        switch (button){
            case _resetButton:
                    _textInput.text = "";
                    _textInput.setFocus();
                break;
            case _submitButton:
                    _appModel.currentBill.totalPrice = Number(_textInput.text);
                    _appModel.currentPage = Config.NEW_BILL;
                break;
        }
    }

    private function layout():void
    {
        _group.y = 60;
        _group.x = this.width/2 - _group.width/2;
    }

    private function groupCreationCompleteHandler(event:Event):void
    {
        layout();
    }

    override public function setSize(width:Number, height:Number):void
    {
        super.setSize(width,height);
        layout();
    }
}
}
