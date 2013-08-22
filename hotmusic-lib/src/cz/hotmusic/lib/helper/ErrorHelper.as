package cz.hotmusic.lib.helper
{
	public class ErrorHelper
	{
		public function ErrorHelper()
		{
		}
		
		private static var _instance:ErrorHelper;
		public static function getInstance():ErrorHelper
		{
			if (_instance == null)
				_instance = new ErrorHelper();
			return _instance;
		}
		
		public static const WRONG_CLIENT_VERSION	:String = "Wrong client version. Please download newest version.";
		public static const SESSION_NOT_VALID		:String = "Error: user session is not valid or expired"; // odhlasit
		public static const USER_ALREADY_REGISTERED	:String = "user already registered."; // zobrazit, user uz je registrovany
		public static const CONSTRAINT_VIOLATION	:String = "ConstraintViolationException : could not execute update query"; // zaznam nelze vymazat, je pravdepodobne vyuzivan
		public static const LOGIN_INCORRECT		 	:String = "Login incorrect";
		public static const SEND_FAILED			 	:String = "Send failed";
		
		public static const WRONG_CLIENT_VERSION_ANSWER	:String = "Please download the newest application version";
		public static const SESSION_NOT_VALID_ANSWER		:String = "Session is not valid or expired, try login again please";
		public static const USER_ALREADY_REGISTERED_ANSWER	:String = "User already registered";
		public static const CONSTRAINT_VIOLATION_ANSWER 	:String = "Can not delete because it is still used. Delete all occurrences first and then try again";
		public static const LOGIN_INCORRECT_ANSWER 	:String = "Login incorrect!";
		public static const SEND_FAILED_ANSWER	 	:String = "Server is not responding right now";
		
		private static const UNKNOWN_ERROR			:String = "Unknown error";
		
		public function getMessage(error:String):String 
		{
			if (error.indexOf(WRONG_CLIENT_VERSION) >= 0)
				return WRONG_CLIENT_VERSION_ANSWER;
			
			if (error.indexOf(SESSION_NOT_VALID) >= 0)
				return SESSION_NOT_VALID_ANSWER;
			
			if (error.indexOf(USER_ALREADY_REGISTERED) >= 0)
				return USER_ALREADY_REGISTERED_ANSWER;
			
			if (error.indexOf(CONSTRAINT_VIOLATION) >= 0)
				return CONSTRAINT_VIOLATION_ANSWER;

			if (error.indexOf(LOGIN_INCORRECT) >= 0)
				return LOGIN_INCORRECT_ANSWER;
			
			if (error.indexOf(SEND_FAILED) >= 0)
				return SEND_FAILED_ANSWER;
			
			return error;
		}
	}
}