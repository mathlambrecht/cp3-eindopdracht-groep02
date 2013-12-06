/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 6/12/13
 * Time: 08:42
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billsplit.view.pages {
import be.devine.cp3.billsplit.config.Config;

import feathers.controls.Button;
import feathers.controls.LayoutGroup;
import feathers.controls.Screen;
import feathers.controls.TextInput;
import feathers.controls.ToggleSwitch;
import feathers.controls.text.TextFieldTextRenderer;
import feathers.core.ITextRenderer;
import feathers.events.FeathersEventType;
import feathers.layout.VerticalLayout;

import starling.events.Event;

public class NewBill extends Screen{

    // Properties
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

        createNewBill();
    }

    // Methods
    private function createNewBill():void{

        _group = new LayoutGroup();
        _group.addEventListener(FeathersEventType.CREATION_COMPLETE, groupCreationCompleteHandler);
        addChild(_group);

        var layout:VerticalLayout = new VerticalLayout();
        layout.gap = 10;
        _group.layout = layout;

        _textInput = new TextInput();
        _textInput.text = '';
        _textInput.prompt = 'Title goes here';
        _textInput.setFocus();
        _group.addChild(_textInput);

        _splitMethodToggle = new ToggleSwitch();
        _splitMethodToggle.onText = "%";
        _splitMethodToggle.offText = "€";
        _splitMethodToggle.trackLayoutMode = ToggleSwitch.TRACK_LAYOUT_MODE_ON_OFF;
        _group.addChild(_splitMethodToggle);

        _friendsButton = new Button();
        _friendsButton.label = '8 friends';
        _friendsButton.name = Config.BILL_FRIENDS;
        _friendsButton.nameList.add( Button.ALTERNATE_NAME_QUIET_BUTTON );
        _friendsButton.addEventListener(Event.TRIGGERED, onClickHandler);
        _group.addChild(_friendsButton);


        // todo: if splitmetho != null -> addEventListener
        // todo: if splitmethod == % -> name = Config.BILL_PRICE // if splitmethod == € -> name = Config.BILL_ITEMS

        _priceButton = new Button();
        _priceButton.label = '34 euros';
        _priceButton.name = '';
        _priceButton.nameList.add( Button.ALTERNATE_NAME_QUIET_BUTTON );
        _priceButton.addEventListener(Event.TRIGGERED, onClickHandler);
        _group.addChild(_priceButton);

        _submitButton = new Button();
        _submitButton.label = 'Split that bill!';
        _submitButton.name = Config.SPLIT_BILL;
        _submitButton.addEventListener(Event.TRIGGERED, onClickHandler);
        _group.addChild(_submitButton)
    }

    private function onClickHandler(event:Event):void
    {
        var button:Button = event.currentTarget as Button;
        trace(button.name);
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
