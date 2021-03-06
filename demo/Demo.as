package {
	import com.thesven.githubwrapper.GitHubWrapper;

	import flash.display.Sprite;

	/**
	 * @author mikesven
	 */
	public class Demo extends Sprite {

		public function Demo() {
		
			GitHubWrapper.getInstance().loginName = '{your git hub user name}';
			GitHubWrapper.getInstance().token = '{your git hub user token}';
			
			GitHubWrapper.getInstance().loadErrorSignal.add(loadError);
			
			GitHubWrapper.getInstance().authenticatedUserSignal.add(ready);
			//GitHubWrapper.getInstance().getUserInfo();
			
			GitHubWrapper.getInstance().getInfoForUserSignal.add(userInfoFor);
			//GitHubWrapper.getInstance().getUserInfoFor('{user name}');
			
			GitHubWrapper.getInstance().searchingForUsersSignal.add(usersFound);
			//GitHubWrapper.getInstance().searchForUsers('{user name}');
			
			GitHubWrapper.getInstance().getFollowersSignal.add(followersFound);
			//GitHubWrapper.getInstance().getUsersFollowers();
			
			GitHubWrapper.getInstance().getFollowingSignal.add(followingFound);
			//GitHubWrapper.getInstance().getUsersFollowing();
			
			GitHubWrapper.getInstance().getWatchedReposSignal.add(watchedRepos);
			//GitHubWrapper.getInstance().getUsersWatchedRepos();
			
			GitHubWrapper.getInstance().searchPublicRepoSignal.add(searchRepo);
			GitHubWrapper.getInstance().searchPublicRepositories('{search term}');
		}

		private function searchRepo(action:Object) : void {
			trace(action);
		}

		private function loadError(action:String) : void {
			trace(action);
		}

		private function userInfoFor(action:Object) : void {
			trace(action);
		}

		private function watchedRepos(action:Object) : void {
			trace(action);
		}

		private function followingFound(action:Object) : void {
			trace(action);
		}

		private function followersFound(action:Object) : void {
			trace(action);
		}

		private function usersFound(action:Object) : void {
			trace(action);
		}

		private function ready(action:Object) : void {
			trace(action);
		}
	}
}
