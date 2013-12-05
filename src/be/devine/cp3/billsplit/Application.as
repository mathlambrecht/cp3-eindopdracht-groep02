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

import feathers.themes.MinimalMobileTheme;

import flash.events.Event;

import starling.display.Sprite;


public class Application extends Sprite
{
    // Properties
    private var _appModel:AppModel;
    private var _JSONService:JSONService;

    // Constructor
    public function Application()
    {
        _appModel = AppModel.getInstance();

        new MinimalMobileTheme();

        _JSONService = new JSONService();
        _JSONService.addEventListener(Event.COMPLETE, jsonServiceCompleteHandler);
        _JSONService.load();
    }

    // Methods
    private function jsonServiceCompleteHandler(event:Event):void
    {
        trace(_JSONService.data);
    }

}
}
