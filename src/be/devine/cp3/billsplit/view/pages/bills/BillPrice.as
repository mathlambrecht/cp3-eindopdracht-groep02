/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 6/12/13
 * Time: 15:24
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billsplit.view.pages.bills {
import be.devine.cp3.billsplit.config.Config;
import be.devine.cp3.billsplit.model.AppModel;
import be.devine.cp3.billsplit.model.BillModel;

import feathers.controls.Button;
import feathers.controls.LayoutGroup;
import feathers.controls.Screen;
import feathers.controls.TextInput;
import feathers.events.FeathersEventType;
import feathers.layout.VerticalLayout;

import flash.events.Event;

import starling.events.Event;

public class BillPrice extends Screen{

    // Properties
    private var _appModel:AppModel;
    private var _billModel:BillModel;

    private var _group:LayoutGroup;
    private var _textInput:TextInput;
    private var _submitButton:Button;
    private var _resetButton:Button;

    // Constructor
    public function BillPrice()
    {
        trace('[BillPrice]');

        _appModel = AppModel.getInstance();

        _billModel = BillModel.getInstance();
        _billModel.addEventListener(BillModel.TOTAL_PRICE_CHANGED,totalPriceChanged);

        _group = new LayoutGroup();
        _group.addEventListener(FeathersEventType.CREATION_COMPLETE, groupCreationCompleteHandler);
        addChild(_group);

        var layout:VerticalLayout = new VerticalLayout();
        layout.gap = 10;
        _group.layout = layout;

        _textInput = new TextInput();
        _textInput.text = '';
        _textInput.prompt = 'Total price';
        _textInput.restrict = "0-9.";
        _textInput.addEventListener(starling.events.Event.CHANGE, inputChangeHandler);
        _group.addChild(_textInput);

        _resetButton = new Button();
        _resetButton.label = 'reset';
        _resetButton.nameList.add( Button.ALTERNATE_NAME_QUIET_BUTTON );
        _resetButton.addEventListener(starling.events.Event.TRIGGERED, clickHandler);
        _group.addChild(_resetButton);

        _submitButton = new Button();
        _submitButton.label = 'Ok';
        _submitButton.alpha = 0.5;
        _group.addChild(_submitButton);
    }

    // Methods
    private function totalPriceChanged(event:flash.events.Event):void
    {
        _textInput.text = (_billModel.totalPrice != 0)? String(_billModel.totalPrice) : '' ;
    }

    private function inputChangeHandler(event:starling.events.Event):void
    {
        if(_textInput.text.length >= 1){
            _submitButton.addEventListener(starling.events.Event.TRIGGERED, clickHandler);
            _submitButton.alpha = 1;
        }else{
            _submitButton.removeEventListener(starling.events.Event.TRIGGERED, clickHandler);
            _submitButton.alpha = 0.5;
        }
    }

    private function clickHandler(event:starling.events.Event):void
    {
        var button:Button = event.currentTarget as Button;

        switch (button){
            case _resetButton:
                    _textInput.text = "";
                    _textInput.setFocus();
                break;
            case _submitButton:
                    _billModel.totalPrice = Number(_textInput.text);
                    _appModel.currentPage = Config.NEW_BILL;
                break;
        }
    }

    private function groupCreationCompleteHandler(event:starling.events.Event):void
    {
        draw();
    }

    override protected function draw():void
    {
        _group.y = 60;
        _group.x = this.width/2 - _group.width/2;
    }
}
}
