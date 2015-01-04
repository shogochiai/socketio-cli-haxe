package js;

/**
 * ...
 * @author sledorze
 */

typedef SocketIO = {
	function listen(?server : Dynamic, ?options : Dynamic, ?fn : Dynamic) : SocketIOManager;
}

typedef SocketAuth = {
	headers : Dynamic,
	time : String,
	address : {
		address : String ,
		port : Int
	},
	xdomain : Bool,
	secure : Bool,
	issued : Int,
	url : String,
	query : Dynamic
}

typedef NodeListener = Dynamic -> Void;

extern
class SocketNamespace {

	public var id : String;

//  public static function SocketNamespace (socket : Dynamic, name : String) : Void;
  public function send(data : Dynamic, fn : Dynamic) : SocketNamespace;
  public function disconnect () : SocketNamespace;

  // from js.Node.NodeEventEmitter
  public function addListener(event:String,fn:NodeListener):Dynamic;
  public function on(event:String,fn:NodeListener):Dynamic;
  public function once(event:String,fn:NodeListener):Void;
  public function removeListener(event:String,listener:NodeListener):Void;
  public function removeAllListeners(event:String):Void;
  public function listeners(event:String):Array<NodeListener>;
  public function setMaxListeners(m:Int):Void;

	@:overload(function(name : String) : SocketNamespace{ } )
  public function emit(event:String,?arg1:Dynamic,?arg2:Dynamic,?arg3:Dynamic):Void;

  public function join(room:String):Void;
  public function leave(room:String):Void;

  /*@:native("in")*/
  public inline function in_(room:String):SocketNamespace return untyped this["in"](room)


  public function clients(room:String):Array<SocketNamespace>;

  public function set<T>( key : String , value : T , ?cb : Void -> Void ) : Void;
  public function get<T>( key : String , cb : Null<String> -> T -> Void ) : Void;

  public function socket( id : String ) : SocketNamespace;

}

typedef SocketIOManager = {

	var sockets(default,null) : SocketNamespace;

	var store(default, null) : Dynamic;
	var log(default, null) : Dynamic;
	@:native("static") var static_(default, null) : Dynamic;

	function get(key : Dynamic) : Dynamic;
	function set(key : Dynamic, value : Dynamic) : SocketIOManager;
	function enable(key : Dynamic) : SocketIOManager;
	function disable(key : Dynamic) : SocketIOManager;

	function enabled(key : Dynamic) : Bool;
	function disabled(key : Dynamic) : Bool;

	@:overload(function(fn : Void -> Void):SocketIOManager {})
	@:overload(function(fn : SocketIOManager -> Void):SocketIOManager {})
	function configure(env : Dynamic, fn : SocketIOManager -> Void) : SocketIOManager;

	function of(nsp : Dynamic) : SocketNamespace;
}
