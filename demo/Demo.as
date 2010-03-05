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
			GitHubWrapper.getInstance().searchingForUsers.add(usersFound);
			GitHubWrapper.getInstance().getFollowers.add(followersFound);
			//GitHubWrapper.getInstance().loadAuthenticatedUserInfo();
			//GitHubWrapper.getInstance().searchForUsers('mpezzi');
			GitHubWrapper.getInstance().getUsersFollowers();
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
