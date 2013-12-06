/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 5/12/13
 * Time: 12:57
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.billsplit
{
import be.devine.cp3.billsplit.config.Config;
import be.devine.cp3.billsplit.model.AppModel;
import be.devine.cp3.billsplit.navigator.ScreenNavigatorWithHistory;
import be.devine.cp3.billsplit.service.JSONService;
import be.devine.cp3.billsplit.view.Content;
import be.devine.cp3.billsplit.view.Header;

import flash.events.Event;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.ResizeEvent;

public class Application extends Sprite
{
    // Properties
    private var _config:Config;

    private var _appModel:AppModel;
    private var _JSONService:JSONService;

    private var _header:Header;
    private var _content:Content;
    private var _navigator:ScreenNavigatorWithHistory;

    // Constructor
    public function Application()
    {
        this.addEventListener(starling.events.Event.ADDED_TO_STAGE, addedToStageHandler);
    }

    // Methods
    private function addedToStageHandler(event:starling.events.Event):void
    {
        this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, addedToStageHandler);

        _config = new Config();
        _config.setTheme();

        _appModel = AppModel.getInstance();
        _navigator = new ScreenNavigatorWithHistory();

        _header = new Header(_navigator);
        addChild(_header);

        _content = new Content(_navigator);
        addChild(_content);

        _JSONService = new JSONService();
        _JSONService.addEventListener(flash.events.Event.COMPLETE, jsonServiceCompleteHandler);
        _JSONService.load();

        stage.addEventListener(ResizeEvent.RESIZE, resizeHandler);
        resizeHandler(null);
    }

    private function jsonServiceCompleteHandler(event:flash.events.Event):void
    {
        _appModel.arrBillsVO = _JSONService.arrBillsData;
        _appModel.arrFriendsVO = _JSONService.arrFriendsData;
    }

    public function resizeHandler(event:ResizeEvent = null):void
    {
        trace('[Application] Resize: ' + stage.stageWidth + ' ' + stage.stageHeight);
        _header.setSize(stage.stageWidth, Config.HEADER_HEIGHT);
        _content.y = Config.HEADER_HEIGHT;
        _content.setSize(stage.stageWidth,stage.stageHeight - Config.HEADER_HEIGHT);
    }
}
}
