package com.thesven.githubwrapper {
	import mx.utils.ObjectProxy;
	import org.osflash.signals.Signal;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLVariables;

	/**
	 * @author michaelsvendsen
	 */
	public class GitHubWrapper {
		
		private   static   var   _gitHubWrapper:GitHubWrapper = new GitHubWrapper();
		
		protected var   _loginName:String;
		protected var   _token:String;
		
		public    var    authenticatedUserInfo:Signal;
		
		protected static const   USER_INFO_URL:String = 'http://github.com/api/v2/xml/user/show/';
		
		public static function getInstance():GitHubWrapper{
			return _gitHubWrapper;	
		}

		public function GitHubWrapper(){
			if(_gitHubWrapper) {	
				throw new Error('GitHubWrapper is a singleton. Please use the getInstance() method.');
			} else {
				
				authenticatedUserInfo = new Signal(String);
			}
		}
		
		public function set loginName(userLoginName:String):void {
			_loginName = userLoginName;
		}
		
		public function set token(userToken:String):void {
			_token = userToken;	
		}
		
		public function loadAuthenticatedUserInfo():void{
			var url:String = USER_INFO_URL + _loginName;
			_doAuthenticatedLoad(url, authenticatedUserInfoLoaded);
		}

		protected function authenticatedUserInfoLoaded(e:Event):void {
			authenticatedUserInfo.dispatch( (e.target as URLLoader).data );
		}

		protected function _doAuthenticatedLoad(urlToUse:String, onCompleteFunctoin:Function):void{
			
			var baseURL:String = urlToUse;
			
			var urlVars:URLVariables = new URLVariables();
			urlVars.login = _loginName;
			urlVars.token = _token;
			
			var request:URLRequest = new URLRequest(baseURL);
			request.data = urlVars;
			
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE, onCompleteFunctoin);
			loader.addEventListener(IOErrorEvent.IO_ERROR, _loaderIOError);
			loader.load(request);
			
		}

		protected function _loaderIOError(e : IOErrorEvent) : void {
			throw new Error('There was an error loading your requesting information ::', e.text);
		}
		
		protected function _changeLoadedTextToJSONObject(text:String):Object{
			return new Object();
		}

	}
}
