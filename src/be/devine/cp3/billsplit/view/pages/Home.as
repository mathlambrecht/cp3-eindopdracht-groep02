/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 5/12/13
 * Time: 18:55
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billsplit.view.pages {
import be.devine.cp3.billsplit.config.Config;
import be.devine.cp3.billsplit.model.AppModel;

import feathers.controls.Button;
import feathers.controls.LayoutGroup;
import feathers.controls.Screen;
import feathers.events.FeathersEventType;
import feathers.layout.HorizontalLayout;

import starling.events.Event;

public class Home extends Screen{

    // Properties
    private var _appModel:AppModel;

    private var _oldBillsButton:Button;
    private var _newBillButton:Button;
    private var _buttonGroup:LayoutGroup;

    private static var OLD_BILLS:String = 'Old bills';
    private static var NEW_BILL:String = 'New bill';

    // Contructor
    public function Home()
    {
        trace('[Home]');

        _appModel = AppModel.getInstance();

        _buttonGroup = new LayoutGroup();
        _buttonGroup.addEventListener(FeathersEventType.CREATION_COMPLETE, buttonGroupCreationCompleteHandler);
        addChild(_buttonGroup);

        var layout:HorizontalLayout = new HorizontalLayout();
        layout.gap = 40;
        _buttonGroup.layout = layout;

        _oldBillsButton = new Button();
        _oldBillsButton.label = "Old bill";
        _oldBillsButton.name = OLD_BILLS;
        _oldBillsButton.addEventListener(Event.TRIGGERED, onClickHandler);
        _buttonGroup.addChild(_oldBillsButton);

        _newBillButton = new Button();
        _newBillButton.label = "New bill";
        _newBillButton.name = NEW_BILL;
        _newBillButton.addEventListener(Event.TRIGGERED, onClickHandler);
        _buttonGroup.addChild(_newBillButton);
    }

    // Methods
    private function onClickHandler(event:Event):void
    {
        var button:Button = event.currentTarget as Button;
        var nextScreen:String;

        switch (button.name){
            case OLD_BILLS:
                nextScreen = Config.OLD_BILLS;
                break;
            case NEW_BILL:
                nextScreen = Config.NEW_BILL;
                break;
        }

        _appModel.currentPage = nextScreen;
    }

    private function buttonGroupCreationCompleteHandler(event:Event):void
    {
        _buttonGroup.y = this.height - _buttonGroup.height - 50;
        _buttonGroup.x = this.width/2 - _buttonGroup.width/2;
    }

    override public function setSize(width:Number, height:Number):void {
        super.setSize(width,height);
    }
}
}
