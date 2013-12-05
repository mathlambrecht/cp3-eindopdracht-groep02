/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 5/12/13
 * Time: 12:57
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billsplit
{
import be.devine.cp3.billsplit.model.AppModel;
import be.devine.cp3.billsplit.service.JSONService;
import be.devine.cp3.billsplit.view.Content;
import be.devine.cp3.billsplit.view.Header;

import feathers.themes.MinimalMobileTheme;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.ResizeEvent;

public class Application extends Sprite
{
    // Properties
    private var _appModel:AppModel;
    private var _JSONService:JSONService;

    private var _header:Header;
    private var _content:Content;

    // Constructor
    public function Application()
    {
        new MinimalMobileTheme();

        _appModel = AppModel.getInstance();

        _header = new Header(_appModel);
        addChild(_header);

        _content = new Content();
        addChild(_content);

        this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
    }

    // Methods
    private function addedToStageHandler(event:Event):void
    {
        this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
        stage.addEventListener(ResizeEvent.RESIZE, resizeHandler);
        layout();

        /* data
         _JSONService = new JSONService();
         _JSONService.addEventListener(Event.COMPLETE, jsonServiceCompleteHandler);
         _JSONService.load();*/
    }

    private function jsonServiceCompleteHandler(event:Event):void
    {
        trace(_JSONService.data.bills[0].name);
    }

    public function resizeHandler(event:ResizeEvent = null):void
    {
        layout();
    }

    private function layout():void
    {
        trace('[Application] Resize: ' + stage.stageWidth + " " + stage.stageHeight);
        _header.setSize(stage.stageWidth,65);
        _content.y = 65;
        _content.setSize(stage.stageWidth,stage.stageHeight-65);
    }
}
}
