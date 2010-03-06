package {
	import com.thesven.githubwrapper.GitHubWrapper;

	import flash.display.Sprite;

	/**
	 * @author mikesven
	 */
	public class Demo extends Sprite {

		public function Demo() {
		
			GitHubWrapper.getInstance().loginName = 'thesven';
			GitHubWrapper.getInstance().token = 'f11a1deff5e19497900c1bec558e88dc';
			GitHubWrapper.getInstance().authenticatedUserInfo.add(ready);
			//GitHubWrapper.getInstance().getUserInfo();
			GitHubWrapper.getInstance().searchingForUsers.add(usersFound);
			//GitHubWrapper.getInstance().searchForUsers('mpezzi');
			GitHubWrapper.getInstance().getFollowers.add(followersFound);
			//GitHubWrapper.getInstance().getUsersFollowers();
			GitHubWrapper.getInstance().getFollowing.add(followingFound);
			//GitHubWrapper.getInstance().getUsersFollowing();
			GitHubWrapper.getInstance().getWatchedRepos.add(watchedRepos);
			//GitHubWrapper.getInstance().getUsersWatchedRepos();
			GitHubWrapper.getInstance().getInfoForUser.add(userInfoFor);
			GitHubWrapper.getInstance().getUserInfoFor('mpezzi');
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
