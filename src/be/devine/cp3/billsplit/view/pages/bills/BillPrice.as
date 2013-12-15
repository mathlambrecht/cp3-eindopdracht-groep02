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
import be.devine.cp3.billsplit.utils.MathUtilities;

import feathers.controls.Button;
import feathers.controls.LayoutGroup;
import feathers.controls.Screen;
import feathers.controls.TextInput;
import feathers.events.FeathersEventType;
import feathers.layout.HorizontalLayout;

import flash.events.Event;

import starling.events.Event;

public class BillPrice extends Screen{

    // Properties
    private var _appModel:AppModel;
    private var _billModel:BillModel;

    private var _group:LayoutGroup;
    private var _buttonGroup:LayoutGroup;

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

        _buttonGroup = new LayoutGroup();
        _buttonGroup.addEventListener(FeathersEventType.CREATION_COMPLETE, groupCreationCompleteHandler);
        _buttonGroup.layout = new HorizontalLayout();

        _textInput = new TextInput();
        _textInput.text = '';
        _textInput.setFocus();
        _textInput.prompt = 'Total price';
        _textInput.restrict = "0-9.";
        _textInput.addEventListener(starling.events.Event.CHANGE, inputChangeHandler);

        _resetButton = new Button();
        _resetButton.label = 'Clear';
        _resetButton.nameList.add( Button.ALTERNATE_NAME_QUIET_BUTTON );
        _resetButton.addEventListener(starling.events.Event.TRIGGERED, resetButtonTriggeredHandler);

        _submitButton = new Button();
        _submitButton.label = 'Done';
        _submitButton.alpha = 0.5;
    }

    // Methods
    private function totalPriceChanged(event:flash.events.Event):void
    {
        _textInput.text = (_billModel.totalPrice != 0)? String(_billModel.totalPrice) : '' ;
    }

    private function inputChangeHandler(event:starling.events.Event):void
    {
        if(_textInput.text.length >= 1){
            _submitButton.addEventListener(starling.events.Event.TRIGGERED, submitButtonTriggeredHandler);
            _submitButton.alpha = 1;
        }else{
            _submitButton.removeEventListener(starling.events.Event.TRIGGERED, submitButtonTriggeredHandler);
            _submitButton.alpha = 0.5;
        }
    }

    private function submitButtonTriggeredHandler(event:starling.events.Event):void
    {
        _billModel.totalPrice = MathUtilities.roundDecimal(Number(_textInput.text));
        _appModel.currentPage = Config.NEW_BILL;
    }

    private function resetButtonTriggeredHandler(event:starling.events.Event):void
    {
        _textInput.text = '';
        _textInput.setFocus();
    }

    private function groupCreationCompleteHandler(event:starling.events.Event):void
    {
        draw();
    }

    override protected function initialize():void
    {
        _group.addChild(_textInput);

        _buttonGroup.addChild(_resetButton);
        _buttonGroup.addChild(_submitButton);
        _group.addChild(_buttonGroup);

        addChild(_group);
    }

    override protected function draw():void
    {
        super.draw();

        _resetButton.width = this.width/2;
        _resetButton.height = Config.BUTTON_HEIGHT;

        _submitButton.width = this.width/2;
        _submitButton.height = Config.BUTTON_HEIGHT;

        _buttonGroup.y = this.height - _buttonGroup.height;

        _textInput.setSize(this.width - 30 , 80);
        _textInput.x = this.width/2 - _textInput.width/2;
        _textInput.y = this.height/2 - _textInput.height/2 - _buttonGroup.height;
    }
}
}
