/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 5/12/13
 * Time: 18:55
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billsplit.view.pages {
import feathers.controls.Button;
import feathers.controls.LayoutGroup;
import feathers.controls.Screen;
import feathers.events.FeathersEventType;
import feathers.layout.HorizontalLayout;

import starling.events.Event;

public class Home extends Screen{

    // Properties
    private var _oldBillsButton:Button;
    private var _newBillButton:Button;
    private var _buttonGroup:LayoutGroup;

    // Contructor
    public function Home()
    {
        trace('[Home]');

        _buttonGroup = new LayoutGroup();
        _buttonGroup.addEventListener(FeathersEventType.CREATION_COMPLETE, buttonGroupCreationCompleteHandler);
        addChild(_buttonGroup);

        var layout:HorizontalLayout = new HorizontalLayout();
        layout.gap = 40;
        _buttonGroup.layout = layout;

        _oldBillsButton = new Button();
        _oldBillsButton.label = "Old bills";
        _oldBillsButton.addEventListener(Event.TRIGGERED, onClickHandler);
        _buttonGroup.addChild(_oldBillsButton);

        _newBillButton = new Button();
        _newBillButton.label = "New bill";
        _newBillButton.addEventListener(Event.TRIGGERED, onClickHandler);
        _buttonGroup.addChild(_newBillButton);
    }

    // Methods
    private function onClickHandler(event:Event):void
    {
        var button:Button = event.currentTarget as Button;
        trace(button.label);
    }

    private function buttonGroupCreationCompleteHandler(event:Event):void
    {
        _buttonGroup.y = 200;
        _buttonGroup.x = 480/2 - _buttonGroup.width/2;
    }

    override public function setSize(width:Number, height:Number):void {
        super.setSize(width,height);
    }
}
}
