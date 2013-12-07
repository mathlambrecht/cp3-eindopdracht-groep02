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

import feathers.controls.Button;
import feathers.controls.LayoutGroup;
import feathers.controls.Screen;
import feathers.controls.TextInput;
import feathers.controls.ToggleSwitch;
import feathers.events.FeathersEventType;
import feathers.layout.VerticalLayout;

import flash.events.Event;

import starling.events.Event;

public class NewBill extends Screen{

    // Properties
    private var _appModel:AppModel;

    private var _group:LayoutGroup;
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
        _appModel.currentBill.addEventListener(BillModel.SPLITMETHOD_CHANGED,splitMethodChanged);
        _appModel.currentBill.addEventListener(BillModel.TOTAL_PRICE_CHANGED,totalPriceChanged);
        _appModel.currentBill.addEventListener(BillModel.TITLE_CHANGED,titleChanged);
        _appModel.currentBill.addEventListener(BillModel.ARR_FRIENDS_CHANGED, arrFriendsChangedHandler);

        _group = new LayoutGroup();
        _group.addEventListener(FeathersEventType.CREATION_COMPLETE, groupCreationCompleteHandler);

        var layout:VerticalLayout = new VerticalLayout();
        layout.gap = 10;
        _group.layout = layout;

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
        _submitButton.nameList.add( Button.STATE_DISABLED );
        // _submitButton.addEventListener(starling.events.Event.TRIGGERED, clickHandler);
    }

    // Methods
    private function splitMethodChanged(event:flash.events.Event):void
    {
    }

    private function totalPriceChanged(event:flash.events.Event):void
    {
        if(_appModel.currentBill.totalPrice != 0) _priceButton.label = _appModel.currentBill.totalPrice + ' euros';
    }

    private function titleChanged(event:flash.events.Event):void
    {
        _textInput.text = _appModel.currentBill.title;
    }

    private function arrFriendsChangedHandler(event:flash.events.Event):void
    {
        var friendText:String = (_appModel.currentBill.arrFriends.length == 1)? ' friend' : ' friends';
        _friendsButton.label = _appModel.currentBill.arrFriends.length + friendText;
    }

    private function createNewBill():void{
    }

    private function inputChangeHandler(event:starling.events.Event):void
    {
        _appModel.currentBill.title = _textInput.text;
    }

    private function toggleChangeHandler(event:starling.events.Event):void
    {
        _appModel.currentBill.splitMethod = (_splitMethodToggle.isSelected == true)? "absolute" : "percentage" ;
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
                nextScreen = (_appModel.currentBill.splitMethod == "percentage")? Config.BILL_PRICE : Config.BILL_ITEMS;
                break;
        }

        _appModel.currentPage = nextScreen;
    }

    override protected function initialize():void
    {
        _group.addChild(_textInput);
        _group.addChild(_splitMethodToggle);
        _group.addChild(_friendsButton);
        _group.addChild(_priceButton);
        _group.addChild(_submitButton);
        this.addChild(_group);
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
