package com.thesven.githubwrapper {
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
		
		public static function getInstance():GitHubWrapper{
			return _gitHubWrapper;	
		}

		public function GitHubWrapper(){
			if(_gitHubWrapper) {	
				throw new Error('GitHubWrapper is a singleton. Please use the getInstance() method.');
			}
		}
		
		public function set loginName(userLoginName:String):void {
			_loginName = userLoginName;
		}
		
		public function set token(userToken:String):void {
			_token = userToken;	
		}
		
		protected function doAuthenticatedLoad(urlToUse:String, onCompleteFunctoin:Function):void{
			
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

		private function _loaderIOError(e : IOErrorEvent) : void {
			throw new Error('There was an error loading your requesting information ::', e.text);
		}
	}
}
