package {

import be.devine.cp3.billsplit.Application;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.geom.Rectangle;

import starling.core.Starling;
import starling.events.ResizeEvent;

public class Main extends Sprite
{
    // Properties
    private var _app:Starling;

    // Constructor
    public function Main()
    {
        trace('[Main]');
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;

        _app = new Starling(Application, stage);
        _app.start();

        stage.addEventListener(flash.events.Event.RESIZE, resizeHandler);
    }

    // Methods
    private function resizeHandler(event:flash.events.Event):void
    {
        _app.viewPort = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
        _app.stage.stageWidth = stage.stageWidth;
        _app.stage.stageHeight = stage.stageHeight;
        _app.stage.dispatchEvent(new starling.events.ResizeEvent(ResizeEvent.RESIZE, stage.stageWidth,stage.stageHeight));
    }
}
}
