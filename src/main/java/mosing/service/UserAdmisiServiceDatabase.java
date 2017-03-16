package mosing.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import lombok.extern.slf4j.Slf4j;
import mosing.mapper.UserAdmisiMapper;
import mosing.model.UserAdmisiModel;

@Slf4j
@Service

public class UserAdmisiServiceDatabase implements UserAdmisiService
{
	@Autowired
	private UserAdmisiMapper userAdmisiMapper;
	
	@Override
    public UserAdmisiModel selectUser (String username)
    {
    	log.info ("select user with username {}", username);
        return userAdmisiMapper.selectUser (username);
    }
	

}