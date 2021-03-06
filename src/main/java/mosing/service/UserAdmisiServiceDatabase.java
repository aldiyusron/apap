package mosing.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import mosing.mapper.UserAdmisiMapper;
import mosing.model.UserAdmisiModel;

@Slf4j
@Service
public class UserAdmisiServiceDatabase implements UserAdmisiService {

	@Autowired
	UserAdmisiMapper userAdmisiMapper;
	
	@Override
	public void addUser(UserAdmisiModel user)
	{
		userAdmisiMapper.addUser(user);
	}
	
	@Override
	public UserAdmisiModel selectUser(String username){
		
		return userAdmisiMapper.selectUser(username);
	}
	@Override
	public UserAdmisiModel selectUser()
	{
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String username = auth.getName();
		return userAdmisiMapper.selectUser(username);
	}
	
	@Override
	public void updateUser(UserAdmisiModel user)
	{
		userAdmisiMapper.updateUser(user);
	}
	
	@Override
	public List<UserAdmisiModel> selectAllUser()
	{
		return userAdmisiMapper.selectAllUser();
	}

	@Override
	public void updateEmail(UserAdmisiModel user) {
		// TODO Auto-generated method stub
		userAdmisiMapper.updateEmail(user);
	}

	@Override
	public List<UserAdmisiModel> selectAllLPTUser() {
		// TODO Auto-generated method stub
		return userAdmisiMapper.selectAllLPTUser();
	}
}
