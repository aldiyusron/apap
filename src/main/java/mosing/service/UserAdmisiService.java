
package mosing.service;

import mosing.model.UserAdmisiModel;

public interface UserAdmisiService {

	void addUser(UserAdmisiModel user);
	UserAdmisiModel selectUser(String username);
	UserAdmisiModel	selectRole(String role);
}

