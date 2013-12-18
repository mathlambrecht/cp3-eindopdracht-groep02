/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 6/12/13
 * Time: 08:42
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billsplit.view.pages.bills {
import be.devine.cp3.billsplit.config.Config;
import be.devine.cp3.billsplit.model.AppModel;
import be.devine.cp3.billsplit.model.BillModel;
import be.devine.cp3.billsplit.utils.Functions;
import be.devine.cp3.billsplit.utils.MathUtilities;
import be.devine.cp3.billsplit.vo.ItemVO;

import feathers.controls.Button;
import feathers.controls.LayoutGroup;
import feathers.controls.Screen;
import feathers.controls.TextInput;
import feathers.controls.ToggleSwitch;
import feathers.events.FeathersEventType;
import feathers.layout.HorizontalLayout;

import flash.events.Event;

import starling.display.Image;

import starling.events.Event;
import starling.textures.Texture;

public class NewBill extends Screen{

    // Properties
    private var _appModel:AppModel;
    private var _billModel:BillModel;

    private var _group:LayoutGroup;
    private var _buttonGroup:LayoutGroup;

    private var _textInput:TextInput;
    private var _splitMethodToggle:ToggleSwitch;
    private var _priceButton:Button;
    private var _friendsButton:Button;
    private var _submitButton:Button;

    // Constructor
    public function NewBill()
    {
        trace('[NewBill]');

        _appModel = AppModel.getInstance();

        _billModel = BillModel.getInstance();
        _billModel.addEventListener(BillModel.TITLE_CHANGED,titleChanged);
        _billModel.addEventListener(BillModel.TOTAL_PRICE_CHANGED,totalPriceChanged);
        _billModel.addEventListener(BillModel.SPLITMETHOD_CHANGED,splitMethodChanged);
        _billModel.addEventListener(BillModel.ARR_FRIENDS_CHANGED,arrFriendsChangedHandler);

        _group = new LayoutGroup();
        _group.addEventListener(FeathersEventType.CREATION_COMPLETE, groupCreationCompleteHandler);

        _buttonGroup = new LayoutGroup();
        _buttonGroup.addEventListener(FeathersEventType.CREATION_COMPLETE, groupCreationCompleteHandler);
        _buttonGroup.layout = new HorizontalLayout();

        _textInput = new TextInput();
        _textInput.text = '';
        _textInput.maxChars = 25;
        _textInput.restrict = "a-zA-Z ";
        _textInput.prompt = 'Title goes here';
        _textInput.addEventListener(starling.events.Event.CHANGE, inputChangeHandler);

        _splitMethodToggle = new ToggleSwitch();
        _splitMethodToggle.onText = '€';
        _splitMethodToggle.offText = '%';
        _splitMethodToggle.trackLayoutMode = ToggleSwitch.TRACK_LAYOUT_MODE_ON_OFF;
        _splitMethodToggle.addEventListener(starling.events.Event.CHANGE, toggleChangeHandler);

        _friendsButton = new Button();
        _friendsButton.label = '1 friend';
        _friendsButton.nameList.add( Button.ALTERNATE_NAME_QUIET_BUTTON );
        _friendsButton.addEventListener(starling.events.Event.TRIGGERED, clickHandler);

        _priceButton = new Button();
        _priceButton.label = '? euros';
        _priceButton.nameList.add( Button.ALTERNATE_NAME_QUIET_BUTTON );
        _priceButton.addEventListener(starling.events.Event.TRIGGERED, clickHandler);

        _submitButton = new Button();
        _submitButton.label = 'Split that bill!';
        _submitButton.alpha = 0.5;
    }

    // Methods
    private function splitMethodChanged(event:flash.events.Event):void
    {
        if(_billModel.splitMethod == 'absolute' && _billModel.arrItems.length != 0)
        {
            _billModel.totalPrice = MathUtilities.calculateTotalPrice(_billModel.arrItems);
        }

        _splitMethodToggle.isSelected = (_billModel.splitMethod != 'percentage');
        checkBill();
    }

    private function totalPriceChanged(event:flash.events.Event):void
    {
        trace('totalprice = ' + _billModel.totalPrice);

        _priceButton.label = _billModel.totalPrice + ' euros';
    }

    private function titleChanged(event:flash.events.Event):void
    {
        _textInput.text = _billModel.title;
        checkBill();
    }

    private function arrFriendsChangedHandler(event:flash.events.Event):void
    {
        var friendText:String = (_billModel.arrFriends.length == 1)? ' friend' : ' friends';
        _friendsButton.label = _billModel.arrFriends.length + friendText;
        checkBill();
    }

    private function checkBill():void
    {
        if(_billModel.totalPrice != 0 && _billModel.arrFriends.length >= 2 && _billModel.title != null)
        {
            if(_billModel.splitMethod == 'absolute' && _billModel.arrItems.length == 0)
            {
                _submitButton.alpha = 0.5;
                _submitButton.removeEventListener(starling.events.Event.TRIGGERED, clickHandler);
            }else{
                _submitButton.alpha = 1;
                _submitButton.addEventListener(starling.events.Event.TRIGGERED, clickHandler);
            }
        }else
        {
            _submitButton.alpha = 0.5;
            _submitButton.removeEventListener(starling.events.Event.TRIGGERED, clickHandler);
        }
    }

    private function inputChangeHandler(event:starling.events.Event):void
    {
        _billModel.title = _textInput.text;
    }

    private function toggleChangeHandler(event:starling.events.Event):void
    {
        _billModel.splitMethod = (_splitMethodToggle.isSelected == true)? "absolute" : "percentage" ;
    }

    private function clickHandler(event:starling.events.Event):void
    {
        var button:Button = event.currentTarget as Button;
        var nextScreen:String;

        switch (button){
            case _friendsButton:
                nextScreen = Config.BILL_FRIENDS;
                break;
            case _priceButton:
                nextScreen = (_billModel.splitMethod == "percentage")? Config.BILL_PRICE : Config.BILL_ITEMS;
                break;
            case _submitButton:
                nextScreen = (_billModel.splitMethod == "percentage")? Config.SPLIT_BILL_PERCENTAGE : Config.SPLIT_BILL_ABSOLUTE;
                break;
        }

        _appModel.currentPage = nextScreen;
    }

    override protected function initialize():void
    {
        _buttonGroup.addChild(_friendsButton);
        _buttonGroup.addChild(_priceButton);
        _group.addChild(_buttonGroup);

        _group.addChild(_textInput);
        _group.addChild(_splitMethodToggle);

        _group.addChild(_submitButton);

        addChild(_group);
    }

    private function groupCreationCompleteHandler(event:starling.events.Event):void
    {
        draw();
    }

    override protected function draw():void
    {
        super.draw();

        _textInput.y = 40;
        _textInput.width = this.width;
        _textInput.height = 80;

        _submitButton.width = this.width;
        _submitButton.height = Config.BUTTON_HEIGHT;
        _submitButton.y = this.height - _submitButton.height;

        _friendsButton.width = this.width/2;
        _friendsButton.height = this.height -  _buttonGroup.y - _submitButton.height;

        _priceButton.width = this.width/2;
        _priceButton.height = this.height - _buttonGroup.y - _submitButton.height;

        _buttonGroup.y = _textInput.y + _textInput.height + 40;

        _splitMethodToggle.y = _buttonGroup.y - _splitMethodToggle.height/2;
        _splitMethodToggle.x = this.width/2 - _splitMethodToggle.width/2;
    }
}
}
