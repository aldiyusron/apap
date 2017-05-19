package mosing.service;

import java.util.List;

import mosing.model.UserAdmisiModel;

public interface UserAdmisiService {

	void addUser(UserAdmisiModel user);
	UserAdmisiModel selectUser(String username);
	UserAdmisiModel selectUser();
	void updateUser(UserAdmisiModel user);
	List<UserAdmisiModel> selectAllUser();
	void updateEmail(UserAdmisiModel user);
	List<UserAdmisiModel> selectAllLPTUser();
}
