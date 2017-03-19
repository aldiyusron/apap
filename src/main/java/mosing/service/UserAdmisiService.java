package mosing.service;

import mosing.model.UserAdmisiModel;

public interface UserAdmisiService {

	void addUser(UserAdmisiModel user);
	UserAdmisiModel selectUser(String username);
	UserAdmisiModel selectUser();
	void updateUser(UserAdmisiModel user);
//	void createPasswordResetTokenForUser(UserAdmisiModel user, String token);
}

