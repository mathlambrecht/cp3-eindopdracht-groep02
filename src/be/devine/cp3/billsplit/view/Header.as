/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 5/12/13
 * Time: 20:54
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billsplit.view {

import be.devine.cp3.billsplit.model.AppModel;

import feathers.controls.Button;
import feathers.controls.Screen;
import feathers.controls.ScreenNavigator;

import starling.display.Quad;
import starling.events.Event;
import starling.text.TextField;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class Header extends Screen {

    // Properties
    private var _appModel:AppModel;
    private var _navigator:ScreenNavigator;

    private var _background:Quad;
    private var _textField:TextField;
    private var _backButton:Button;

    // Constructor
    public function Header()
    {
        trace('[Header]');

        _appModel = AppModel.getInstance();
        createHeader();
    }

    // Methods
    private function createHeader():void
    {
        _background = new Quad(1,1,0x000000);
        addChild(_background);

        _textField = new TextField(200,65,'Title','Verdana',18,0xffffff);
        _textField.hAlign = HAlign.CENTER;
        _textField.vAlign = VAlign.CENTER;
        addChild(_textField);

        // todo: positionering (button group?)
        _backButton = new Button();
        _backButton.nameList.add( Button.ALTERNATE_NAME_BACK_BUTTON );
        _backButton.addEventListener(Event.TRIGGERED, backButtonClickHandler);
        this.addChild(_backButton);
    }

    override public function setSize(width:Number,height:Number):void
    {
        super.setSize(width,height);

        _background.width = width;
        _background.height = height;

        _textField.width = width;
        _textField.height = height;
    }

    private function backButtonClickHandler(event:Event):void {
        trace('back');
    }
}
}
