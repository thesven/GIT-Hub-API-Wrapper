package com.thesven.githubwrapper {
	import com.adobe.serialization.json.JSON;

	import org.osflash.signals.Signal;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
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
		
		public    var   authenticatedUserSignal:Signal;
		public    var   searchingForUsersSignal:Signal;
		public    var   getFollowersSignal:Signal;
		public    var   getFollowingSignal:Signal;
		public    var   getWatchedReposSignal:Signal;
		public    var   getInfoForUserSignal:Signal;
		public    var   loadErrorSignal:Signal;
		public    var   searchPublicRepoSignal:Signal;
		
		protected static const   USER_INFO_URL:String = 'http://github.com/api/v2/json/user/show/';
		protected static const   USER_SEARCH_URL:String = 'http://github.com/api/v2/json/user/search/';
		protected static const   WATCHED_REPOS_URL:String = 'http://github.com/api/v2/json/repos/watched/';
		protected static const   SEARCH_PUBLIC_REPO_URL:String = 'http://github.com/api/v2/json/repos/search/';
		
		public static function getInstance():GitHubWrapper{
			return _gitHubWrapper;	
		}

		public function GitHubWrapper(){
			if(_gitHubWrapper) {	
				throw new Error('GitHubWrapper is a singleton. Please use the getInstance() method.');
			} else {
				authenticatedUserSignal = new Signal(Object);
				searchingForUsersSignal = new Signal(Object);
				getFollowersSignal = new Signal(Object);
				getFollowingSignal = new Signal(Object);
				getWatchedReposSignal = new Signal(Object);
				getInfoForUserSignal = new Signal(Object);
				loadErrorSignal = new Signal(String);
				searchPublicRepoSignal = new Signal(Object);
			}
		}
		
		/*
		 * sets the login name of the user
		 * *the user must be registered on git hub
		 */
		public function set loginName(userLoginName:String):void {
			_loginName = userLoginName;
		}
		
		/*
		 * sets the git hub token of the user
		 * *the user must be registered on git hub
		 */
		public function set token(userToken:String):void {
			_token = userToken;	
		}
		
		/*
		 * used to get the information of the user whos login name and token you have supplied.
		 * authenticatedUserInfoSignal:Signal will dispatch with a JSON object containing the informaiton.
		 */
		public function getUserInfo():void{
			var url:String = USER_INFO_URL + _loginName;
			_doAuthenticatedLoad(url, authenticatedUserInfoLoaded);
		}

		protected function authenticatedUserInfoLoaded(e:Event) : void {
			removeLoadListeners((e.target as URLLoader), authenticatedUserInfoLoaded);
			authenticatedUserSignal.dispatch( _decodeAsJSONObject( (e.target as URLLoader).data ) );
		}
		
		/*
		 * used to the the information for the user whos name is supplied in the parameters
		 * @param name:String - the name of the user whos info you are searching for
		 * getInfoForUserSignal:Signal will dispatch with a JSON object containing the information.
		 */
		public function getUserInfoFor(name:String):void{
			var url:String = USER_INFO_URL + name;
			_doAuthenticatedLoad(url, userInfoLoaded);
		}

		protected function userInfoLoaded(e:Event):void {
			removeLoadListeners((e.target as URLLoader), userInfoLoaded);
			getInfoForUserSignal.dispatch( _decodeAsJSONObject( (e.target as URLLoader).data ) );
		}
		
		/*
		 * used to search for registered users on git hub
		 * @param userNameToSearchForm:String - a string containing the letters or names you are searching for
		 * serchingForUsersSignal:Signal will dispatch with a JSON object containing the information.
		 */
		public function searchForUsers(userNameToSearchFor:String):void{
			var url:String = USER_SEARCH_URL + userNameToSearchFor;
			_doAuthenticatedLoad(url, searchForUsersLoaded);
		}
		
		protected function searchForUsersLoaded(e:Event):void {
			removeLoadListeners((e.target as URLLoader), searchForUsersLoaded);
			searchingForUsersSignal.dispatch( _decodeAsJSONObject( (e.target as URLLoader).data));
		}
		
		/*
		 * used to get the infortion on the followers of the user whos login name and token were set
		 * getFollowersSignal:Signal will dispatch with a JSON object containing the information
		 */
		public function getUsersFollowers():void{
			var url:String = USER_INFO_URL + _loginName + "/followers";
			_doAuthenticatedLoad(url, getUsersFollowersLoaded);
		}

		protected function getUsersFollowersLoaded(e:Event) : void {
			removeLoadListeners((e.target as URLLoader), getUsersFollowersLoaded);
			getFollowersSignal.dispatch( _decodeAsJSONObject( (e.target as URLLoader).data ) );
		}
		
		/*
		 * used to get the information on the people who being followed by the user whos login and token were set
		 * getFollowingSignal:Signal will dispatch with a JSON object containing the informaiton
		 */
		public function getUsersFollowing():void{
			var url:String = USER_INFO_URL + _loginName + "/following";
			_doAuthenticatedLoad(url, getUserFollowingLoaded);
		}

		protected function getUserFollowingLoaded(e:Event) : void {
			removeLoadListeners((e.target as URLLoader), getUserFollowingLoaded);
			getFollowingSignal.dispatch( _decodeAsJSONObject( (e.target as URLLoader).data ));
		}
		
		/*
		 * used to get the repositores that are watched by the users whos login and token are set
		 * getWatchedReposSignal:Signal will dispatch with a JSON object containing the information
		 */
		public function getUsersWatchedRepos():void{
			var url:String = WATCHED_REPOS_URL + _loginName;
			_doAuthenticatedLoad(url, getUsersWatchedReposLoaded);
		}

		protected function getUsersWatchedReposLoaded(e:Event) : void {
			removeLoadListeners((e.target as URLLoader), getUsersWatchedReposLoaded);
			getWatchedReposSignal.dispatch( _decodeAsJSONObject( (e.target as URLLoader).data) );
		}
		
		/*
		 * used to search public repositories by the term supplied though the parameters
		 * @param searchTerm:String - the term you wish to use in your search
		 * searchPublicRepoSignal will dispatch with a JSON object containing the information
		 */
		public function searchPublicRepositories(searchTerm:String):void{
			var url:String = SEARCH_PUBLIC_REPO_URL + searchTerm;
			_doAuthenticatedLoad(url, searchPublicRepositoriesLoaded);
		}	

		protected function searchPublicRepositoriesLoaded(e:Event) : void {
			removeLoadListeners((e.target as URLLoader), searchPublicRepositoriesLoaded);
			searchPublicRepoSignal.dispatch( _decodeAsJSONObject( (e.target as URLLoader).data));
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
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _loaderSecurityError);
			loader.load(request);
		}
		
		protected function removeLoadListeners(target:URLLoader, loadFunc):void{
			target.addEventListener(Event.COMPLETE, loadFunc);
			target.removeEventListener(IOErrorEvent.IO_ERROR, _loaderIOError);
			target.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, _loaderSecurityError);
		}

		protected function _loaderSecurityError(e : SecurityErrorEvent) : void {
			(e.target).removeEventListener(IOErrorEvent.IO_ERROR, _loaderIOError);
			(e.target).removeEventListener(SecurityErrorEvent.SECURITY_ERROR, _loaderSecurityError);
			loadErrorSignal.dispatch(e.text);
		}

		protected function _loaderIOError(e : IOErrorEvent) : void {
			(e.target).removeEventListener(IOErrorEvent.IO_ERROR, _loaderIOError);
			(e.target).removeEventListener(SecurityErrorEvent.SECURITY_ERROR, _loaderSecurityError);
			loadErrorSignal.dispatch(e.text);
		}

		protected function _decodeAsJSONObject(text:String):Object{
			return JSON.decode(text);
		}

	}
}
