/**
 * Created with IntelliJ IDEA.
 * User: Annelies
 * Date: 11/04/13
 * Time: 22:08
 * To change this template use File | Settings | File Templates.
 */
package be.devine.utils.xml {
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLLoader;
import flash.net.URLRequest;

public class XMLLoader extends EventDispatcher {

    // Properties
    public static const XML_LOADED:String = 'xmlLoaded';
    public var xml:XML;

    // Constructor
    public function XMLLoader() {
        trace('[XMLLoader]');
    }

    // Methods
    public function load(path:String):void {

        var loader:URLLoader = new URLLoader();
        loader.addEventListener(Event.COMPLETE, completeHandler);
        loader.load(new URLRequest(path));

    }

    private function completeHandler(event:Event):void {
        trace('[XMLLoader] XML loaded');

        this.xml = new XML(event.currentTarget.data);
        dispatchEvent(new Event(XML_LOADED));
    }
}
}