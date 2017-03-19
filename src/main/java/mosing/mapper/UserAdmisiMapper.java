package mosing.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;

import mosing.model.UserAdmisiModel;

@Mapper
public interface UserAdmisiMapper {

	@Select("select * from user where username = #{username}")
	@Results(value = { @Result(property = "username", column = "username"),
			@Result(property = "password", column = "password"), @Result(property = "email", column = "email"),
			@Result(property = "role", column = "role") })
	UserAdmisiModel selectUser(@Param("username") String username);

	@Insert("insert into user (username, password, email, role, enabled) values (#{username}, #{password}, #{email}, #{role}, 1)")
	void addUser(UserAdmisiModel user);
}