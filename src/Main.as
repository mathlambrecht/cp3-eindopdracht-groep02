package {

import be.devine.cp3.billsplit.Application;
import flash.display.MovieClip;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.geom.Rectangle;

import starling.core.Starling;
import starling.events.Event;

public class Main extends MovieClip
{
    // Properties
    private var _app:Starling;

    // Constructor
    public function Main()
    {
        trace('[Main]');

        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;

        _app = new Starling(Application, stage);
        _app.start();

        stage.addEventListener(flash.events.Event.RESIZE, resizeHandler);
    }

    // Methods

    private function resizeHandler(event:flash.events.Event):void
    {
        trace('[Main] Resize');

        _app.viewPort = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
        _app.stage.stageWidth = stage.stageWidth;
        _app.stage.stageHeight = stage.stageHeight;
        _app.stage.dispatchEvent(new starling.events.Event(starling.events.Event.RESIZE));
    }

}
}
