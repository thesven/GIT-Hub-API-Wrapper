package com.thesven.githubwrapper {
	import com.dynamicflash.util.Base64;
	import flash.utils.ByteArray;
	import mx.utils.Base64Encoder;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequest;
	import flash.net.URLLoader;

	/**
	 * @author michaelsvendsen
	 */
	public class GitHubWrapper {
		
		private   static   var   _gitHubWrapper:GitHubWrapper = new GitHubWrapper();
		
		protected var   _loginName:String;
		protected var   _loginPass:String;
		
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
		
		public function set loginPass(userLoginPass:String):void {
			_loginPass = userLoginPass;	
		}

		public function getAuthenticatedUserInformation():Object{
			return new Object();
		}
		
		protected function doAuthenticatedLoad(urlToUse:String):void{
			
			var baseURL:String = urlToUse;
			
			var auth:String = _loginName + ":" + _loginPass;
			var encodedAuth:String = Base64.encode(auth);
			var creds:URLRequestHeader = new URLRequestHeader("Authorization", "Basic " + encodedAuth.toString());
			
			var request:URLRequest = new URLRequest(baseURL);
			request.requestHeaders.push(creds);
		}
	}
}
